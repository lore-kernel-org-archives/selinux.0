Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA2HMgoW002260
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 12:22:42 -0500
Received: from mail6.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA2HKxFI000665
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 17:21:02 GMT
Date: Thu, 2 Nov 2006 12:22:34 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: "'Paul Moore'" <paul.moore@hp.com>, jbrindle@tresys.com,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        gcwilson@us.ibm.com
Subject: RE: SELinux Networking Enhancements
In-Reply-To: <001601c6fea1$d54115c0$cc0a010a@tcssec.com>
Message-ID: <Pine.LNX.4.64.0611021219110.23758@d.namei>
References: <001601c6fea1$d54115c0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2 Nov 2006, Venkat Yekkirala wrote:

> Define a filter point with all incoming from interface eth1 with eth1_t (or
> a group of clients or whatever).
> 
> allow http_server_packet_t eth1_t:secfilter { flow_in };
> 
> Essentially, the flexibility offered by an additional layer of indirection.

I think what we'd really want in a case like this is to just use secmark, 
and create new compound types for labeling packets (which is part of the 
idea of the design).

So, eth1 is thought of as "internal", and you use iptables to label 
packets with --dport 80 and -i eth1 as httpd_internal_t.

> > In fact, this appears to be entirely indepdent to xfrm labeling...
> 
> Correct. This is really labeling-mechanism-agnostic in that it filters
> all.

Then I'm not sure I understand why it's part of a discussion about 
protected path labeling.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
