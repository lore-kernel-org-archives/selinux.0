Subject: Re: [PATCH] policycoreutils: fix typos in semanage manpages
To: Philipp Gesang <philipp.gesang@intra2net.com>, Selinux@tycho.nsa.gov
References: <1464362001-5636-1-git-send-email-philipp.gesang@intra2net.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <fedff3a2-13d9-a934-388c-43f5f4552eba@tycho.nsa.gov>
Date: Mon, 6 Jun 2016 13:12:36 -0400
MIME-Version: 1.0
In-Reply-To: <1464362001-5636-1-git-send-email-philipp.gesang@intra2net.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/27/2016 11:13 AM, Philipp Gesang wrote:
> Signed-off-by: Philipp Gesang <philipp.gesang@intra2net.com>

Applied.

Thanks,

> ---
>  policycoreutils/semanage/semanage-dontaudit.8 | 2 +-
>  policycoreutils/semanage/semanage-export.8    | 2 +-
>  policycoreutils/semanage/semanage-import.8    | 2 +-
>  policycoreutils/semanage/semanage-interface.8 | 2 +-
>  policycoreutils/semanage/semanage-port.8      | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/policycoreutils/semanage/semanage-dontaudit.8 b/policycoreutils/semanage/semanage-dontaudit.8
> index 122780d..3d29911 100644
> --- a/policycoreutils/semanage/semanage-dontaudit.8
> +++ b/policycoreutils/semanage/semanage-dontaudit.8
> @@ -8,7 +8,7 @@
>  semanage is used to configure certain elements of
>  SELinux policy without requiring modification to or recompilation
>  from policy sources.  semanage dontaudit toggles whether or not dontaudit rules will be in the policy.  Policy writers use dontaudit rules to cause
> -confined applications to use alternative paths.  Dontaudit rules are denied but not reported in the logs.  Some times dontaudit rules can cause bugs in applications but policy writers will not relize it since the AVC is not audited.  Turning off dontaudit rules with this command to see if the kernel is blocking an access.
> +confined applications to use alternative paths.  Dontaudit rules are denied but not reported in the logs.  Some times dontaudit rules can cause bugs in applications but policy writers will not realize it since the AVC is not audited.  Turning off dontaudit rules with this command to see if the kernel is blocking an access.
>
>  .SH "OPTIONS"
>  .TP
> diff --git a/policycoreutils/semanage/semanage-export.8 b/policycoreutils/semanage/semanage-export.8
> index 469b1bb..d688224 100644
> --- a/policycoreutils/semanage/semanage-export.8
> +++ b/policycoreutils/semanage/semanage-export.8
> @@ -7,7 +7,7 @@
>  .SH "DESCRIPTION"
>  semanage is used to configure certain elements of
>  SELinux policy without requiring modification to or recompilation
> -from policy sources.  semanage import and export can be used to extract the SELinux modifications from one machine and apply them to another. You can put a hole group of semanage commands within a file and apply them to a machine in a single transaction.
> +from policy sources.  semanage import and export can be used to extract the SELinux modifications from one machine and apply them to another. You can put a whole group of semanage commands within a file and apply them to a machine in a single transaction.
>
>  .SH "OPTIONS"
>  .TP
> diff --git a/policycoreutils/semanage/semanage-import.8 b/policycoreutils/semanage/semanage-import.8
> index 5437de3..4a9b3e7 100644
> --- a/policycoreutils/semanage/semanage-import.8
> +++ b/policycoreutils/semanage/semanage-import.8
> @@ -7,7 +7,7 @@
>  .SH "DESCRIPTION"
>  semanage is used to configure certain elements of
>  SELinux policy without requiring modification to or recompilation
> -from policy sources.  semanage import and export can be used to extract the SELinux modifications from one machine and apply them to another. You can put a hole group of semanage commands within a file and apply them to a machine in a single transaction.
> +from policy sources.  semanage import and export can be used to extract the SELinux modifications from one machine and apply them to another. You can put a whole group of semanage commands within a file and apply them to a machine in a single transaction.
>
>  .SH "OPTIONS"
>  .TP
> diff --git a/policycoreutils/semanage/semanage-interface.8 b/policycoreutils/semanage/semanage-interface.8
> index d318bb8..fe8b250 100644
> --- a/policycoreutils/semanage/semanage-interface.8
> +++ b/policycoreutils/semanage/semanage-interface.8
> @@ -52,7 +52,7 @@ MLS/MCS Security Range (MLS/MCS Systems only) SELinux Range for SELinux login ma
>
>  .SH EXAMPLE
>  .nf
> -list all interface defitions
> +list all interface definitions
>  # semanage interface \-l
>
>  .SH "SEE ALSO"
> diff --git a/policycoreutils/semanage/semanage-port.8 b/policycoreutils/semanage/semanage-port.8
> index 3f067c5..5a6a57f 100644
> --- a/policycoreutils/semanage/semanage-port.8
> +++ b/policycoreutils/semanage/semanage-port.8
> @@ -53,7 +53,7 @@ Protocol for the specified port (tcp|udp) or internet protocol version for the s
>
>  .SH EXAMPLE
>  .nf
> -List all port defitions
> +List all port definitions
>  # semanage port \-l
>  Allow Apache to listen on tcp port 81
>  # semanage port \-a \-t http_port_t \-p tcp 81
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
