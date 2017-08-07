Message-ID: <1502117158.4300.8.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Mon, 07 Aug 2017 10:45:58 -0400
In-Reply-To: <20170805163750.1920-6-nicolas.iooss@m4x.org>
References: <20170805163750.1920-1-nicolas.iooss@m4x.org>
 <20170805163750.1920-6-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 6/6] sepolicy: remove stray space in section "SEE ALSO"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-08-05 at 18:37 +0200, Nicolas Iooss wrote:
> The space after "sepolicy(8)" breaks the formatting of section SEE
> ALSO
> in man pages generated with sepolicy:
> 
>   SEE ALSO
>     selinux(8), ssh(8), semanage(8), restorecon(8), chcon(1),
> sepolicy(8)  ,  setsebool(8),
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied all six patches.

> ---
>  python/sepolicy/sepolicy/manpage.py | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/python/sepolicy/sepolicy/manpage.py
> b/python/sepolicy/sepolicy/manpage.py
> index 35b3722dbe45..ed8cb71cd6d4 100755
> --- a/python/sepolicy/sepolicy/manpage.py
> +++ b/python/sepolicy/sepolicy/manpage.py
> @@ -922,8 +922,7 @@ This manual page was auto-generated using
>  .B "sepolicy manpage".
>  
>  .SH "SEE ALSO"
> -selinux(8), %s(8), semanage(8), restorecon(8), chcon(1), sepolicy(8)
> -""" % (self.domainname))
> +selinux(8), %s(8), semanage(8), restorecon(8), chcon(1),
> sepolicy(8)""" % (self.domainname))
>  
>          if self.booltext != "":
>              self.fd.write(", setsebool(8)")
