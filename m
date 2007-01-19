Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0JJD7U1001052
	for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2007 14:13:07 -0500
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0JJE1U1016036
	for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2007 19:14:02 GMT
Date: Fri, 19 Jan 2007 14:13:56 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, Antoine Martin <antoine@nagafix.co.uk>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: 2.6.19.2 Oops
In-Reply-To: <200701191307.56051.paul.moore@hp.com>
Message-ID: <Pine.LNX.4.64.0701191413360.5360@d.namei>
References: <45B09CFA.5070805@nagafix.co.uk> <45B0E782.9070102@nagafix.co.uk>
 <200701191048.30219.paul.moore@hp.com> <200701191307.56051.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 19 Jan 2007, Paul Moore wrote:

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

Acked-by: James Morris <jmorris@namei.org>

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
> 
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
