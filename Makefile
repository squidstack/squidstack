PROJECT_NAME = cb-squidstack

up:
	docker-compose up --build -d
	docker-compose ps

down:
	docker-compose down

logs:
	docker-compose logs -f

# ----------------------------
# Pretty health check for all services
# ----------------------------

# Adjust these to match your docker-compose port mappings
HC_ENDPOINTS = \
  "squid-ui|http://localhost:3000" \
  "kraken-auth|http://localhost:8080/health" \
  "nautilus-inventory|http://localhost:8084/health" \
  "clam-catalog|http://localhost:8082/health" \
  "jellyfish-notifications|http://localhost:8083/health" \
  "squid-recommendations|http://localhost:8085/health" \
  "barnacle-reviews|http://localhost:8086/health" \
  "manta-delivery|http://localhost:8087/health" \
  "octopus-payments|http://localhost:8088/health" \
  "cuttlefish-orders|http://localhost:8089/health" \
  "urchin-analytics|http://localhost:8090/health"

healthcheck:
	@rm -f .health_failures
	@printf "%-24s %-40s %5s  %6s\n" "Service" "URL" "Code" "Time"
	@printf "%-24s %-40s %5s  %6s\n" "------------------------" "----------------------------------------" "-----" "------"
	@set -e; \
	for e in $(HC_ENDPOINTS); do \
	  svc=$${e%%|*}; url=$${e#*|}; \
	  code_time=$$(curl -4 -sS -m 5 -o /dev/null -w "%{http_code} %{time_total}" "$$url" || echo "000 0"); \
	  code=$$(echo $$code_time | awk '{print $$1}'); \
	  tt=$$(echo $$code_time | awk '{print $$2}'); \
	  printf "%-24s %-40s %5s  %6.2fs\n" "$$svc" "$$url" "$$code" "$$tt"; \
	  if [ "$$code" = "000" ] || [ "$$code" -ge 400 ] 2>/dev/null; then echo "$$svc|$$url" >> .health_failures; fi; \
	done; \
	if [ -s .health_failures ]; then \
	  echo ""; echo "❌ Failures:"; \
	  while IFS='|' read -r s u; do printf "  - %-22s %s\n" "$$s" "$$u"; done < .health_failures; \
	  echo ""; \
	  echo "Hints:"; \
	  echo "  • 404 = service up but /health missing (add route)."; \
	  echo "  • 000 = connection failed (container down or port not published)."; \
	  rm -f .health_failures; \
	  exit 1; \
	else \
	  echo ""; echo "✅ All health checks passed."; \
	  rm -f .health_failures; \
	fi