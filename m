Message-ID: <1485377535.15074.80.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: selinux_restorecon.3 man page typo fix
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Lokesh Mandvekar <lsm5@fedoraproject.org>, selinux@tycho.nsa.gov
Date: Wed, 25 Jan 2017 15:52:15 -0500
In-Reply-To: <20170125204635.13443-1-lsm5@fedoraproject.org>
References: <20170125204635.13443-1-lsm5@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-01-25 at 15:46 -0500, Lokesh Mandvekar wrote:
> Signed-off-by: Lokesh Mandvekar <lsm5@fedoraproject.org>

Thanks, applied

> ---
>  libselinux/man/man3/selinux_restorecon.3 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libselinux/man/man3/selinux_restorecon.3
> b/libselinux/man/man3/selinux_restorecon.3
> index 2d8274b..d698818 100644
> --- a/libselinux/man/man3/selinux_restorecon.3
> +++ b/libselinux/man/man3/selinux_restorecon.3
> @@ -26,7 +26,7 @@ containing a directory or file to be relabeled.
>  If this is a directory and the
>  .IR restorecon_flags
>  .B SELINUX_RESTORECON_RECURSE
> -has been set (for decending through directories), then
> +has been set (for descending through directories), then
>  .BR selinux_restorecon ()
>  will write an SHA1 digest of the combined specfiles (see the
>  .B NOTES
