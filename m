Message-ID: <36282A1733C57546BE392885C0618592015CFD40@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com, paul.moore@hp.com,
        sds@tycho.nsa.gov, eparis@redhat.com, jbrindle@tresys.com
Subject: RE: [PATCH 0/1] selinux: secid reconciliation fixes V01
Date: Mon, 9 Oct 2006 10:18:32 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > 3. Label igmp traffic with the igmp_packet initial context.
> 
> Why is IGMP being handled separately?  How many other 
> protocols will need 
> their own specific hooks?

igmp seems like the only odd ball out in that it sends packets
outside of a socket (even a kernel sock) context; which also
explains why there's a separate init sid defined/deprecated for
this in the selinux policy. 

> 
> > + * @igmp_classify_skb:
> > + *	Sets the skb's secid to the igmp initsid.
> 
> This explanation is SELinux-specific.

Will fix this.

> 
> Your patches need to be against the latest net-2.6 tree.

OK.
> 
> 
> 
> - James
> -- 
> James Morris
> <jmorris@namei.org>
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
