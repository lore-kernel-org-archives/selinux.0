Message-ID: <54B80D7B.30003@tycho.nsa.gov>
Date: Thu, 15 Jan 2015 13:56:59 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: John Brooks <john.brooks@jolla.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH v2 0/3] Improve check_assertions performance through hash
 tweaks
References: <1420668221-52637-1-git-send-email-john.brooks@jolla.com>
 <1421281443-4905-1-git-send-email-john.brooks@jolla.com>
In-Reply-To: <1421281443-4905-1-git-send-email-john.brooks@jolla.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/14/2015 07:24 PM, John Brooks wrote:
> Updated to not override environment with -O2, improved readability of the hash
> implementation, and restored avtab_alloc's behavior of allocating a fraction of
> the expected number of elements as buckets for better efficiency in small hashes.
> 
> John Brooks (3):
>   Build libsepol with -O2
>   Use a better hash function for libsepol's avtab
>   Tweak avtab hash table parameters for better performance
> 
>  libsepol/include/sepol/policydb/avtab.h |  7 ++---
>  libsepol/src/Makefile                   |  2 +-
>  libsepol/src/avtab.c                    | 45 ++++++++++++++++++++++++++++-----
>  3 files changed, 44 insertions(+), 10 deletions(-)

Thanks, all three patches applied.
