Subject: Re: 2.6.19.2 Oops
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, Antoine Martin <antoine@nagafix.co.uk>,
        James Morris <jmorris@namei.org>
In-Reply-To: <200701191307.56051.paul.moore@hp.com>
References: <45B09CFA.5070805@nagafix.co.uk>
	 <45B0E782.9070102@nagafix.co.uk> <200701191048.30219.paul.moore@hp.com>
	 <200701191307.56051.paul.moore@hp.com>
Content-Type: text/plain
Date: Fri, 19 Jan 2007 13:12:39 -0500
Message-Id: <1169230359.22731.623.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-19 at 13:07 -0500, Paul Moore wrote:
> On Friday, January 19 2007 10:48 am, Paul Moore wrote:
> > On Friday, January 19 2007 10:45 am, Antoine Martin wrote:
> > > Disabling Netlabel did the trick.
> > > Shouldn't that be sent to stable for 2.6.19.3? (it is a oops after all)
> >
> > Yep, I'm working on a patch as I type this ...
> 
> This patch should solve the problem.  Before I send this off for the stable 
> tree does anyone have any comments?
> 
> (I'd like to try and send this off by the end of the day today)
> 
> ---
>  security/selinux/ss/mls.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6.19.y/security/selinux/ss/mls.c
> ===================================================================
> --- linux-2.6.19.y.orig/security/selinux/ss/mls.c
> +++ linux-2.6.19.y/security/selinux/ss/mls.c
> @@ -641,10 +641,14 @@ int mls_export_cat(const struct context 
>  	int rc = -EPERM;
>  
>  	if (!selinux_mls_enabled) {
> -		*low = NULL;
> -		*low_len = 0;
> -		*high = NULL;
> -		*high_len = 0;
> +		if (low != NULL) {
> +			*low = NULL;
> +			*low_len = 0;
> +		}
> +		if (high != NULL) {
> +			*high = NULL;
> +			*high_len = 0;
> +		}
>  		return 0;
>  	}

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
