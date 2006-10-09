Message-ID: <36282A1733C57546BE392885C0618592015CFD55@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: James Morris <jmorris@namei.org>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com, paul.moore@hp.com,
        sds@tycho.nsa.gov, eparis@redhat.com, jbrindle@tresys.com
Subject: RE: [PATCH 0/1] selinux: secid reconciliation fixes V01
Date: Mon, 9 Oct 2006 12:45:03 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[Thought I had sent this earlier, but found this waiting for me to finish]

> -----Original Message-----
> From: James Morris [mailto:jmorris@namei.org]
> Sent: Monday, October 09, 2006 9:25 AM
> To: Venkat Yekkirala
> Cc: selinux@tycho.nsa.gov; redhat-lspp@redhat.com; paul.moore@hp.com;
> sds@tycho.nsa.gov; eparis@redhat.com; jbrindle@tresys.com
> Subject: RE: [PATCH 0/1] selinux: secid reconciliation fixes V01
> 
> 
> On Mon, 9 Oct 2006, Venkat Yekkirala wrote:
> 
> > > > 3. Label igmp traffic with the igmp_packet initial context.
> > > 
> > > Why is IGMP being handled separately?  How many other 
> > > protocols will need 
> > > their own specific hooks?
> > 
> > igmp seems like the only odd ball out in that it sends packets
> > outside of a socket (even a kernel sock) context; which also
> > explains why there's a separate init sid defined/deprecated for
> > this in the selinux policy. 
> 
> I don't think a protocol-specific hook is going to be 
> acceptable.  Can you 
> test inside SELinux to determine that it's IGMP?

I did in fact test inside SELinux, and that's how I found
out these were igmp packets. These were getting labeled implicitly
with unlabeled_t, and now after labeling thse distinctly, policy won't
have to grant access to the network to unlabeled packets. An alternative
is to not flow control any traffic that doesn't have a sock associated
with it.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
