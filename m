Message-ID: <36282A1733C57546BE392885C0618592015CF59C@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org,
        eparis@redhat.com
Subject: RE: [PATCH v2 1/1] NetLabel: secid reconciliation support
Date: Mon, 2 Oct 2006 16:04:37 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > If this selinux_netlbl_skb_sid() call can fail for any 
> reason other than
> > a kernel bug, then this needs to goto out instead of using 
> BUG_ON.  For
> > example, if the function can fail due to temporary memory pressure
> > leading to a failed allocation, then you want to simply 
> drop the packet,
> > not panic the kernel.  
> 
> That's fine - see the discussion Venkat and I had earlier.  
> I'll change
> it to jump to "out".

Just to clarify, my comments earlier about BUG_ON were in
relation to selinux_xfrm_decode_session which can only fail
as a result of a bug or kernel corruption. For "other" errors,
a jump out indeed seems proper, like you are already planning to do.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
