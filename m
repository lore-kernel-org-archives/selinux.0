Subject: Re: [PATCH] selinux_xfrm_sec_ctx_alloc: null-terminate context
	string
From: Joy Latten <latten@austin.ibm.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov
In-Reply-To: <1185294148.15699.364.camel@faith.austin.ibm.com>
References: <46A61263.2050404@trustedcs.com>
	 <1185294148.15699.364.camel@faith.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 24 Jul 2007 11:45:08 -0500
Message-Id: <1185295509.15699.372.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-07-24 at 11:22 -0500, Joy Latten wrote:
> On Tue, 2007-07-24 at 09:53 -0500, Venkat Yekkirala wrote:
> > xfrm_audit_log() expects the context string to be null-terminated
> > which currently doesn't happen with user-supplied contexts.
> > 
> > Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
> > ---
> >  security/selinux/xfrm.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > --- selinux-2.6/security/selinux/xfrm.c	2007-07-24 09:43:23.000000000 -0500
> > +++ selinux-2.6/security/selinux/xfrm.c	2007-07-24 09:44:11.000000000 -0500
> > @@ -216,7 +216,7 @@ static int selinux_xfrm_sec_ctx_alloc(st
> >  		return -ENOMEM;
> >  
> >  	*ctxp = ctx = kmalloc(sizeof(*ctx) +
> > -			      uctx->ctx_len,
> > +			      uctx->ctx_len + 1,
> >  			      GFP_KERNEL);
> >  
> >  	if (!ctx)
> > @@ -229,6 +229,7 @@ static int selinux_xfrm_sec_ctx_alloc(st
> >  	memcpy(ctx->ctx_str,
> >  	       uctx+1,
> >  	       ctx->ctx_len);
> > +	ctx->ctx_str[ctx->ctx_len] = 0;
> >  	rc = security_context_to_sid(ctx->ctx_str,
> >  				     ctx->ctx_len,
> >  				     &ctx->ctx_sid);
> 
> At the moment I am working on a re-work of the xfrm_audit_log() so 
> that we can audit RFC-required events as well. I will add this fix into
> the new patch and send to netdev. Venkat, I will include your ack
> and cc you in the submission. Let me know if this is ok.
> 
Oops! This patch is not in xfrm_audit_log() code. So, I won't be
including it in my patch or anything. Sorry, didn't have my coffee
yet. :-)

Regards,
Joy



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
