Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4AH4R4j018098
 for <selinux@tycho.nsa.gov>; Tue, 10 May 2016 13:04:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so3728702wmn.1
 for <selinux@tycho.nsa.gov>; Tue, 10 May 2016 10:04:14 -0700 (PDT)
Subject: Re: [PATCH] policycoreutils: fix the extract example in semodule.8
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1462865989-19741-1-git-send-email-plautrba@redhat.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Message-ID: <5adb4684-4503-9f5c-2657-3c84fa4d1514@m4x.org>
Date: Tue, 10 May 2016 19:04:11 +0200
MIME-Version: 1.0
In-Reply-To: <1462865989-19741-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/10/2016 09:39 AM, Petr Lautrbach wrote:
> The man page's example suggested to use -g instead of -E
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  policycoreutils/semodule/semodule.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
> index 6db390c..e5b54b3 100644
> --- a/policycoreutils/semodule/semodule.8
> +++ b/policycoreutils/semodule/semodule.8
> @@ -121,7 +121,7 @@ $ semodule \-B \-p "/tmp"
>  $ semodule \-B \-S "/tmp/var/lib/selinux"
>  # Write the HLL version of puppet and the CIL version of wireshark
>  # modules at priority 400 to the current working directory
> -$ semodule \-X 400 \-g wireshark \-\-cil \-g puppet \-\-hll
> +$ semodule \-X 400 \-E wireshark \-\-cil \-E puppet \-\-hll

Actually this command extracts the HLL version of wireshark and the CIL
version of puppet (it creates wireshark.pp and puppet.cil on my system
with checkpolicy 2.5).  In order to do what the comment suggests, the
--cil and --hll flags need to be set before the -E options: semodule -X
400 --cil -E wireshark --hll -E puppet.

-- Nicolas
