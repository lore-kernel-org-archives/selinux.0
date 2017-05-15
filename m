Message-ID: <1494880681.11971.18.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] libselinux: close the subs file if fstat failed
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Mon, 15 May 2017 16:38:01 -0400
In-Reply-To: <20170512201357.4091-2-nicolas.iooss@m4x.org>
References: <20170512201357.4091-1-nicolas.iooss@m4x.org>
 <20170512201357.4091-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-05-12 at 22:13 +0200, Nicolas Iooss wrote:
> selabel_subs_init() returned without closing cfg when a call to
> fstat()
> failed. Fix this.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied both patches.

> ---
>  libselinux/src/label.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 0e43474c352e..71a273bdeb2a 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -104,7 +104,7 @@ struct selabel_sub *selabel_subs_init(const char
> *path,
>  		return list;
>  
>  	if (fstat(fileno(cfg), &sb) < 0)
> -		return list;
> +		goto out;
>  
>  	while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {
>  		char *ptr = NULL;
