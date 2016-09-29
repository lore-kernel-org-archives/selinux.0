Subject: Re: [PATCH 1/1] policycoreutils: setfiles: ignore restorecon_xattr in
 git
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20160928203644.9458-1-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <abfcf400-8375-9b8b-32a6-14ebf8f0e8a7@tycho.nsa.gov>
Date: Thu, 29 Sep 2016 10:50:35 -0400
MIME-Version: 1.0
In-Reply-To: <20160928203644.9458-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/28/2016 04:36 PM, Nicolas Iooss wrote:
> Commit f1352e739925 ("policycoreutils: setfiles - Utility to find
> security.restorecon_last entries") introduced restorecon_xattr binary
> without adding it to .gitignore.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied.

> ---
>  policycoreutils/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/policycoreutils/.gitignore b/policycoreutils/.gitignore
> index 3a96936c6ce0..53d5d558d61b 100644
> --- a/policycoreutils/.gitignore
> +++ b/policycoreutils/.gitignore
> @@ -12,6 +12,7 @@ semodule_package/semodule_package
>  semodule_package/semodule_unpackage
>  sestatus/sestatus
>  setfiles/restorecon
> +setfiles/restorecon_xattr
>  setfiles/setfiles
>  setsebool/setsebool
>  hll/pp/pp
> 
