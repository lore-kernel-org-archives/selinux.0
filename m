Subject: Re: [PATCH 2/2] policycoreutils: Remove unused autoconf files from po/
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1468443169-29229-1-git-send-email-plautrba@redhat.com>
 <1468443169-29229-2-git-send-email-plautrba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9ab3a552-8ccb-80a4-ee01-c222b8674c3d@tycho.nsa.gov>
Date: Mon, 25 Jul 2016 13:59:22 -0400
MIME-Version: 1.0
In-Reply-To: <1468443169-29229-2-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/13/2016 04:52 PM, Petr Lautrbach wrote:
> None of *.in and POTFILES* files is used in current build process.
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied both patches.

> ---
>  policycoreutils/po/Makefile.in    | 218 ------------------------------------
>  policycoreutils/po/Makefile.in.in | 230 --------------------------------------
>  policycoreutils/po/POTFILES       |  72 ------------
>  policycoreutils/po/POTFILES.in    |  60 ----------
>  4 files changed, 580 deletions(-)
>  delete mode 100644 policycoreutils/po/Makefile.in
>  delete mode 100644 policycoreutils/po/Makefile.in.in
>  delete mode 100644 policycoreutils/po/POTFILES
>  delete mode 100644 policycoreutils/po/POTFILES.in
