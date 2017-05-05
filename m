Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v45BdqWD020959
 for <selinux@tycho.nsa.gov>; Fri, 5 May 2017 07:39:52 -0400
Subject: Re: [PATCH 1/1] libselinux: add selinuxenforced tool
To: =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
 selinux@tycho.nsa.gov
References: <20170504211237.27440-1-cgzones@googlemail.com>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <1c7f42af-ea7f-bf0b-5c6a-fccfb776faf5@redhat.com>
Date: Fri, 5 May 2017 13:39:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170504211237.27440-1-cgzones@googlemail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Dne 4.5.2017 v 23:12 Christian Göttsche via Selinux napsal(a):
> Add command line tool selinuxenforced to determine the current SELinux enforced via exit code.
> Useful for script usage or monitoring.

Could the following script do the work?

case $(getenforce) in
 "Permissive") exit 1
  ;;
  "Enforcing") exit 0
  ;;
  "Disabled") exit 2
  ;;
esac


> ---
>  libselinux/man/man8/selinuxenforced.8 | 24 ++++++++++++++++++++++++
>  libselinux/utils/.gitignore           |  1 +
>  libselinux/utils/selinuxenforced.c    | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+)
>  create mode 100644 libselinux/man/man8/selinuxenforced.8
>  create mode 100644 libselinux/utils/selinuxenforced.c
> 
> diff --git a/libselinux/man/man8/selinuxenforced.8 b/libselinux/man/man8/selinuxenforced.8
> new file mode 100644
> index 00000000..5ef746e5
> --- /dev/null
> +++ b/libselinux/man/man8/selinuxenforced.8
> @@ -0,0 +1,24 @@
> +.TH "selinuxenforced" "8" "4 May 2017" "Security Enhanced Linux" "SELinux Command Line documentation"
> +.SH "NAME"
> +selinuxenforced \- tool to be used within shell scripts to determine if SELinux is in enforced mode
> +.
> +.SH "SYNOPSIS"
> +.B selinuxenforced
> +.
> +.SH "DESCRIPTION"
> +Indicates whether SELinux is in enforced mode or not.
> +.
> +.SH "EXIT STATUS"
> +It exits with status 0 if SELinux is in enforced mode,
> +1 if SELinux is in permissive mode,
> +2 if SELinux is disabled,
> +and 10 if a library call fails.
> +.
> +.SH AUTHOR
> +Christian Göttsche, <cgzones@googlemail.com>
> +.
> +.SH "SEE ALSO"
> +.BR selinux (8),
> +.BR setenforce (8),
> +.BR getenforce (8),
> +.BR selinuxenabled (8)
> diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> index 5cd01025..bc1f4327 100644
> --- a/libselinux/utils/.gitignore
> +++ b/libselinux/utils/.gitignore
> @@ -21,6 +21,7 @@ selabel_partial_match
>  selinux_check_securetty_context
>  selinuxenabled
>  selinuxexeccon
> +selinuxenforced
>  setenforce
>  setfilecon
>  togglesebool
> diff --git a/libselinux/utils/selinuxenforced.c b/libselinux/utils/selinuxenforced.c
> new file mode 100644
> index 00000000..b5e1c8e8
> --- /dev/null
> +++ b/libselinux/utils/selinuxenforced.c
> @@ -0,0 +1,33 @@
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <selinux/selinux.h>
> +
> +int main(void)
> +{
> +	int rc;
> +
> +	rc = is_selinux_enabled();
> +	if (rc < 0) {
> +		fputs("selinuxenforced:  is_selinux_enabled() failed", stderr);
> +		return 10;
> +	}
> +	if (rc == 1) {
> +		rc = security_getenforce();
> +		if (rc < 0) {
> +			fputs("selinuxenforced:  security_getenforce() failed", stderr);
> +			return 10;
> +		}
> +
> +		if (rc) {
> +			// enforced mode
> +			return 0;
> +		}
> +
> +		// permissive mode
> +		return 1;
> +	}
> +
> +	// SELinux disabled
> +	return 2;
> +}
> 
