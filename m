From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v8 09/18] SELinux: Only store the network interface's ifindex
Date: Mon, 17 Dec 2007 15:51:45 -0500
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        vyekkirala@TrustedCS.com, chanson@TrustedCS.com
References: <20071214213548.10069.59135.stgit@flek.lan> <20071214215041.10069.63711.stgit@flek.lan> <1197921401.17307.110.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1197921401.17307.110.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712171551.45775.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 17 December 2007 2:56:41 pm Stephen Smalley wrote:
> On Fri, 2007-12-14 at 16:50 -0500, Paul Moore wrote:
> >  /* Initialize an AVC audit data structure. */
> >  #define AVC_AUDIT_DATA_INIT(_d,_t) \
> > -        { memset((_d), 0, sizeof(struct avc_audit_data)); (_d)->type =
> > AVC_AUDIT_DATA_##_t; }
> > +        { memset((_d), 0, sizeof(struct 
> > avc_audit_data)); \
> > +	  (_d)->type = AVC_AUDIT_DATA_##_t; \
> > +	  if ((_d)->type == AVC_AUDIT_DATA_NET) \
> > +		  (_d)->u.net.netif = -1; }
>
> As a minor nit, at the same time you do this, turn this into a static
> inline function please.

Can do ... although when talking about this with some other people I'm not 
sure I need to use -1 as a sentinel value, zero should work.  If that is the 
case I won't need to change this definition.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
