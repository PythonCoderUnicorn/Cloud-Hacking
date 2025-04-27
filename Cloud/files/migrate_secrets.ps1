
# AWS Configuration
$accessKey = "358e6db6a38477dac4f1"
$secretKey = "a2cbb21185f09b45bb752d516bf8de3403e4a1fd"
$region = "us-east-1"

# output log file
$logfile = "upload_log.txt"


<#
.SYNOPSIS
    Simulates basic AWS S3 bucket functionality in PowerShell.

.DESCRIPTION
    This script provides a set of functions to mimic common S3 operations
    like creating buckets, listing buckets, and uploading/downloading
    "files" (represented as strings within the script).  This is useful
    for testing or learning purposes without needing actual AWS access.

.NOTES
    This script does NOT interact with actual AWS services.  All data
    is stored in PowerShell variables within the script's scope.
    This is a simulation for educational and testing purposes.
#>

#region Global Variables
#  Simulated S3 Data Storage
$Global:S3Buckets = @{}  #  Hash table to store buckets (key = bucket name, value = content)
#endregion

#region Functions

function New-S3Bucket {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$BucketName
    )

    # Check if the bucket name is valid (basic validation)
    if (-not ($BucketName -match "^[a-z0-9.-]{3,63}$")) {
        Write-Error "Invalid bucket name: $BucketName. Bucket names must be between 3 and 63 characters long and can contain only lowercase letters, numbers, hyphens, and periods."
        return
    }

    # Check if the bucket already exists
    if ($Global:S3Buckets.ContainsKey($BucketName)) {
        Write-Warning "Bucket '$BucketName' already exists."
        return
    }

    # Create the bucket (in our simulation, this is adding an entry to the hashtable)
    $Global:S3Buckets[$BucketName] = @{}  #  Initialize an empty hashtable to store "files"
    Write-Host "Bucket '$BucketName' created."
}

function Get-S3Bucket {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, Position = 0)]
        [string]$BucketName
    )

    if ($PSBoundParameters.ContainsKey("BucketName")) {
        #  If a specific bucket name was provided
        if ($Global:S3Buckets.ContainsKey($BucketName)) {
            #  Return the bucket (just the name in this simplified simulation)
            Write-Host "Bucket: $BucketName"
            #  Show the "files" in the bucket
            Write-Host "  Files:"
            if ($Global:S3Buckets[$BucketName].Count -eq 0)
            {
                Write-Host "    <No files>"
            }
            else
            {
               foreach ($key in $Global:S3Buckets[$BucketName].Keys)
               {
                 Write-Host "    $key"
               }
            }

        } else {
            Write-Warning "Bucket '$BucketName' not found."
        }
    } else {
        # If no bucket name was provided, list all buckets
        if ($Global:S3Buckets.Count -eq 0) {
            Write-Host "No buckets found."
        } else {
            Write-Host "Buckets:"
            foreach ($key in $Global:S3Buckets.Keys) {
                Write-Host "  $key"
            }
        }
    }
}

function Set-S3Content {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$BucketName,

        [Parameter(Mandatory = $true, Position = 1)]
        [string]$Key,  #  The "file" name (key)

        [Parameter(Mandatory = $true, Position = 2)]
        [string]$Content # The "file" content (a string)
    )

    # Check if the bucket exists
    if (-not ($Global:S3Buckets.ContainsKey($BucketName))) {
        Write-Error "Bucket '$BucketName' not found."
        return
    }

    #  In a real S3, you can overwrite.  We will do the same.
    $Global:S3Buckets[$BucketName][$Key] = $Content
    Write-Host "Content '$Key' uploaded to bucket '$BucketName'."
}

function Get-S3Content {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$BucketName,

        [Parameter(Mandatory = $true, Position = 1)]
        [string]$Key # The "file" name (key)
    )

    # Check if the bucket exists
    if (-not ($Global:S3Buckets.ContainsKey($BucketName))) {
        Write-Error "Bucket '$BucketName' not found."
        return
    }

     # Check if the key (file) exists in the bucket
    if (-not ($Global:S3Buckets[$BucketName].ContainsKey($Key))) {
        Write-Error "Key '$Key' not found in bucket '$BucketName'."
        return
    }
    #  Return the content
    Write-Host "Content of '$Key' from bucket '$BucketName':"
    Write-Host $($Global:S3Buckets[$BucketName][$Key])
}
#endregion

#region Examples
#  Example Usage (Demonstrates the functions)
Write-Host "
--------------------------------------------------------
  Simulated AWS S3 Example
--------------------------------------------------------
"

# Create some buckets
New-S3Bucket -BucketName "my-first-bucket"
New-S3Bucket -BucketName "my-second-bucket"
New-S3Bucket -BucketName "test.bucket" # test with period

# Attempt to create a bucket with an invalid name
New-S3Bucket -BucketName "InvalidBucketNameTooLong12345678901234567890"
New-S3Bucket -BucketName "Invalid-Bucket-Name-With-Capitals"

# List all buckets
Get-S3Bucket

# List a specific bucket
Get-S3Bucket -BucketName "my-first-bucket"

# Upload some "files" to a bucket
Set-S3Content -BucketName "my-first-bucket" -Key "file1.txt" -Content "This is the content of file1."
Set-S3Content -BucketName "my-first-bucket" -Key "file2.txt" -Content "This is another file's content."
Set-S3Content -BucketName "my-second-bucket" -Key "data.csv" -Content "name,age\nJohn,30\nJane,25"

# Get a specific file's content
Get-S3Content -BucketName "my-first-bucket" -Key "file1.txt"
Get-S3Content -BucketName "my-second-bucket" -Key "data.csv"

# List the first bucket again to see the files.
Get-S3Bucket -BucketName "my-first-bucket"

# Example of trying to get a non-existent file
Get-S3Content -BucketName "my-first-bucket" -Key "nonexistent.txt"

# Example of trying to get from a non-existent bucket.
Get-S3Content -BucketName "non-existent-bucket" -Key "file1.txt"

#endregion
