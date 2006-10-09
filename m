Message-ID: <36282A1733C57546BE392885C0618592015CFD5B@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: James Morris <jmorris@namei.org>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com, paul.moore@hp.com,
        sds@tycho.nsa.gov, eparis@redhat.com, jbrindle@tresys.com
Subject: RE: [PATCH 0/1] selinux: secid reconciliation fixes V01
Date: Mon, 9 Oct 2006 13:20:15 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: James Morris [mailto:jmorris@namei.org]
> Sent: Monday, October 09, 2006 12:02 PM
> To: Venkat Yekkirala
> Cc: selinux@tycho.nsa.gov; redhat-lspp@redhat.com; paul.moore@hp.com;
> sds@tycho.nsa.gov; eparis@redhat.com; jbrindle@tresys.com
> Subject: RE: [PATCH 0/1] selinux: secid reconciliation fixes V01
> 
> 
> On Mon, 9 Oct 2006, Venkat Yekkirala wrote:
> 
> > I did in fact test inside SELinux, and that's how I found
> > out these were igmp packets. These were getting labeled implicitly
> > with unlabeled_t, and now after labeling thse distinctly, 
> policy won't
> > have to grant access to the network to unlabeled packets. 
> An alternative
> > is to not flow control any traffic that doesn't have a sock 
> associated
> > with it.
> 
> This might be worth considering as an intermediate step, and 
> multicast 
> support can be added later.  Just need to make sure it doesn't break 
> anything else.

A problem with NOT flow-controlling traffic with no associated sock is
that this (no-flow-control) would also then apply to the forwarded traffic.
I would rather just see what breaks (I seriously doubt it) in beta2 and fix
it.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
