Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NJBfrT011987
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 15:11:41 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NJAfv8010434
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 19:10:41 GMT
Subject: Re: patch needed by latest rawhide
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200409240141.09473.russell@coker.com.au>
References: <200409240141.09473.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1095966640.16157.4.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 23 Sep 2004 15:10:40 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Thu, 2004-09-23 at 11:41, Russell Coker wrote:
> The attached patch does a domain_auto_trans for when firstboot runs the 
> xserver so that /tmp/.X11-unix gets the correct type.
> 
> It allows iptables to write to the pipe that firstboot creates.
> 
> It puts in a dontaudit rule for passwd_t and chfn_t access to 
> selinux_config_t, which I am not entirely sure about.  The same thing is 
> currently there for sysadm_passwd_t, and things work fine with the dontaudit.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
