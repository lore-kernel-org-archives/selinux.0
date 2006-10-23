Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9NLHVfU021865
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 17:17:31 -0400
Received: from mail8.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9NLG1OG014327
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 21:16:02 GMT
Date: Mon, 23 Oct 2006 17:17:29 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: jbrindle@tresys.com, selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: RE: SELinux Networking Enhancements
In-Reply-To: <001301c6f6c0$e3fd9b80$cc0a010a@tcssec.com>
Message-ID: <Pine.LNX.4.64.0610231715200.22353@d.namei>
References: <001301c6f6c0$e3fd9b80$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 23 Oct 2006, Venkat Yekkirala wrote:

> Yes. Currently you can't do it. But I would like to get ideas on
> a "less confusing" way to do forwarding controls. Specifically,
> what would be an ideal allow-rule-set look like for forwarding
> controls?

I really don't know at this stage.  It seems like a generally complex 
problem which needs a comprehensive solution itself, assuming it's worth 
solving, and I don't believe we need to wait for that to implement 
protected paths for host to host networking.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
