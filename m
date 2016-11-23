Subject: Re: [PATCH 5/5] libsepol: fix unknown magic section number error
 message
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161122222342.16771-1-nicolas.iooss@m4x.org>
 <20161122222342.16771-5-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8cb7bf82-3a8c-d22b-7fbc-ff15125f9026@tycho.nsa.gov>
Date: Wed, 23 Nov 2016 12:35:06 -0500
MIME-Version: 1.0
In-Reply-To: <20161122222342.16771-5-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/22/2016 05:23 PM, Nicolas Iooss wrote:
> When running hll/pp on some invalid policy module, it can output:
> 
>     libsepol.sepol_module_package_read: unknown magic number at section
>     1, offset: 251, number: 0x
> 
> The last number looks funny and was caused by using "%ux". "u" is not a
> prefix like "l", "h", "z"... and "%x" already expects an unsigned
> integer (cf. http://man7.org/linux/man-pages/man3/printf.3.html).
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied all five patches.

> ---
>  libsepol/src/module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsepol/src/module.c b/libsepol/src/module.c
> index 1c2becea5ef6..219355f30d27 100644
> --- a/libsepol/src/module.c
> +++ b/libsepol/src/module.c
> @@ -627,7 +627,7 @@ int sepol_module_package_read(sepol_module_package_t * mod,
>  		default:
>  			/* unknown section, ignore */
>  			ERR(file->handle,
> -			    "unknown magic number at section %u, offset: %zx, number: %ux ",
> +			    "unknown magic number at section %u, offset: %zx, number: %x ",
>  			    i, offsets[i], le32_to_cpu(buf[0]));
>  			break;
>  		}
> 
