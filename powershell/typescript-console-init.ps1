# Initialize npm project
npm init -y

# Install dependencies
npm install --save pdf-lib
npm install --save-dev typescript @types/node ts-node

# Create TypeScript config
$tsConfig = @"
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
"@
Set-Content -Path "tsconfig.json" -Value $tsConfig

# Update package.json scripts
$packageJson = Get-Content "./package.json" | ConvertFrom-Json
$packageJson.scripts = @{
    "build" = "tsc"
    "start" = "ts-node src/index.ts"
    "compile" = "tsc"
}
$packageJson | ConvertTo-Json -Depth 100 | Set-Content "package.json"

# Create directory structure
New-Item -ItemType Directory -Path "src" -Force
New-Item -ItemType Directory -Path "build" -Force
New-Item -ItemType Directory -Path "input" -Force
New-Item -ItemType Directory -Path "output" -Force
