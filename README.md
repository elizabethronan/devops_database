# Database Service

PostgreSQL database for the ecommerce platform. Initialized with 
schema and seed data via `init.sql`.

## Technology Stack
- PostgreSQL 15
- Alpine Linux
- Docker

## Schema
The database is initialized with the following tables:
- **products** — stores product catalog
- **orders** — stores customer orders
- **order_items** — stores line items for each order

## Local Development

### Prerequisites
- Docker

### Run Database
```bash
docker run -p 5432:5432 eronan22/database:latest
```

### Connect to Database
```bash
psql -h localhost -U admin -d ecommerce
```

## Docker

### Build Image
```bash
docker build -t eronan22/database:latest .
```

### Run Container
```bash
docker run -d \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=password \
  eronan22/database:latest
```

## Environment Variables
| Variable | Description | Default |
|----------|-------------|---------|
| POSTGRES_DB | Database name | ecommerce |
| POSTGRES_USER | Database user | admin |
| POSTGRES_PASSWORD | Database password | - |

## Initialization
On first startup, PostgreSQL automatically runs `init-scripts/init.sql`
which creates the schema and inserts seed data.

## CI/CD
This service uses a Jenkins pipeline defined in `Jenkinsfile`.
Pipeline stages: PR Validation → Validate → Container Build & Push → 
Security Scan → Deploy

## Docker Hub
```
eronan22/database
```

Thanks!