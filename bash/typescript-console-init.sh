#!/bin/bash

# Initialize npm project
npm init -y

# Install dependencies
npm install --save pdf-lib
npm install --save-dev typescript @types/node ts-node

# Create TypeScript config
cat > tsconfig.json << 'EOL'
{
  "compilerOptions": {
    "target": "es6",
    "module": "commonjs",
    "outDir": "./build",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules"]
}
EOL

# Update package.json scripts
# Using jq for JSON manipulation
npm install --save-dev jq

jq '.scripts = {
  "build": "tsc",
  "start": "ts-node src/index.ts",
  "compile": "tsc"
}' package.json > temp.json && mv temp.json package.json

# Create directory structure
mkdir -p src build input output

# Create index.ts stub
cat > src/index.ts << 'EOL'
import { PDFDocument } from 'pdf-lib';

async function main() {
  // Your PDF processing code will go here
  console.log('PDF processing script initialized');
}

main().catch(console.error);
EOL

echo "Project initialized successfully. Run 'npm run start' to execute the script."
