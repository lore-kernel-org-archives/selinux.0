Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA13kbdB005988
	for <selinux@tycho.nsa.gov>; Tue, 31 Oct 2006 22:46:38 -0500
Received: from mail1.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA13ixKW024548
	for <selinux@tycho.nsa.gov>; Wed, 1 Nov 2006 03:45:00 GMT
Date: Tue, 31 Oct 2006 22:46:35 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: jbrindle@tresys.com, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, gcwilson@us.ibm.com,
        Paul Moore <paul.moore@hp.com>
Subject: RE: SELinux Networking Enhancements
In-Reply-To: <000601c6fd2e$ceea6ab0$cc0a010a@tcssec.com>
Message-ID: <Pine.LNX.4.64.0610312242270.27961@d.namei>
References: <000601c6fd2e$ceea6ab0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 31 Oct 2006, Venkat Yekkirala wrote:

> Implementation issues aside, lately I have been wondering about doing
> something in the filter table using something we could call secfilter
> or so.
> 
> You would still use secmark to label the packets, but they (along with
> any external labels) could get filtered in the secfilter module. This
> way we could control what external labels could come thru from what peers.
> For internal labels it would be more of an assurance thing. This would also
> automatically take care of forwarding controls.

Ok, so, there'd be an iptables match which looked up the security context 
on the SA the packet arrives/departs on?  Sounds like it could work.  
Perhaps call it xfrmlabel ?



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
