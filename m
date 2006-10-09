Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k99EOcCf018341
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 10:24:38 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k99ENxjU029009
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 14:23:59 GMT
Date: Mon, 9 Oct 2006 10:24:35 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com, paul.moore@hp.com,
        sds@tycho.nsa.gov, eparis@redhat.com, jbrindle@tresys.com
Subject: RE: [PATCH 0/1] selinux: secid reconciliation fixes V01
In-Reply-To: <36282A1733C57546BE392885C0618592015CFD40@chaos.tcs.tcs-sec.com>
Message-ID: <Pine.LNX.4.64.0610091022461.28179@d.namei>
References: <36282A1733C57546BE392885C0618592015CFD40@chaos.tcs.tcs-sec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Oct 2006, Venkat Yekkirala wrote:

> > > 3. Label igmp traffic with the igmp_packet initial context.
> > 
> > Why is IGMP being handled separately?  How many other 
> > protocols will need 
> > their own specific hooks?
> 
> igmp seems like the only odd ball out in that it sends packets
> outside of a socket (even a kernel sock) context; which also
> explains why there's a separate init sid defined/deprecated for
> this in the selinux policy. 

I don't think a protocol-specific hook is going to be acceptable.  Can you 
test inside SELinux to determine that it's IGMP?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
