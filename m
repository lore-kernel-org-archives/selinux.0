Message-ID: <36282A1733C57546BE392885C061859201572F5C@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: James Morris <jmorris@namei.org>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>
Subject: RE: [PATCH 4/7] secid reconciliation-v02: Invoke LSM hook for out
	bound traffic
Date: Mon, 18 Sep 2006 15:12:02 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Fri, 8 Sep 2006, Venkat Yekkirala wrote:
> 
> > @@ -114,6 +128,9 @@ static struct xt_target xt_connsecmark_t
> > 		.target		= target,
> > 		.targetsize	= sizeof(struct 
> xt_connsecmark_target_info),
> > 		.table		= "mangle",
> > +		.hooks		= (1 << NF_IP_LOCAL_IN) |
> > +				  (1 << NF_IP_FORWARD) |
> > +				  (1 << NF_IP_POST_ROUTING),
> 
> Why have you added constraints on the hooks?
> 
> This breaks a bunch of things.

I was trying to restrict the module usage to these, but later realized
I really needn't. Will take these out.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
