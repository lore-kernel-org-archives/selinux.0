Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96HWevY001502
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 13:32:40 -0400
Received: from mail6.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96HVQQW026206
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 17:31:27 GMT
Date: Fri, 6 Oct 2006 13:32:36 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Joshua Brindle <jbrindle@tresys.com>
cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: Denials from newest kernel
In-Reply-To: <1160141519.16462.33.camel@twoface.columbia.tresys.com>
Message-ID: <Pine.LNX.4.64.0610061331590.6460@d.namei>
References: <1160141519.16462.33.camel@twoface.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Oct 2006, Joshua Brindle wrote:

> I'm going to load up some secmark rules as soon as I get an iptables
> build that lets me (wonder why rawhides doesn't come with SECMARK :\ )
> and try this again.

You need compat_net=1 to test what FC6 and RHEL5 will be shipping.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
