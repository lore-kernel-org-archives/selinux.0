Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i15LdaRb019077
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 16:39:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i15LbvQk022516
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 21:37:57 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by jazzswing.ncsc.mil  with ESMTP id i15LbvYo022511
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 21:37:57 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i15JsjmV029864
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 14:54:45 -0500
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id i15Jsjge029862
	for selinux@tycho.nsa.gov; Thu, 5 Feb 2004 14:54:45 -0500
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i15I7CRb018109
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 13:07:12 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i15I5ijN005090
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 18:05:44 GMT
Received: from mail.osdl.org (fw.osdl.org [65.172.181.6])
	by jazzswing.ncsc.mil  with ESMTP id i15I5fZH005075
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 18:05:42 GMT
Date: Thu, 5 Feb 2004 10:06:56 -0800
From: Chris Wright <chrisw@osdl.org>
To: Torben Krause <torben.krause@gmx.de>
Cc: linux-security-module@wirex.com, selinux@tycho.nsa.gov
Subject: Re: Trouble with installation of lsm kernel patch and SE linux Packages on Debian
Message-ID: <20040205100656.B17935@osdlab.pdx.osdl.net>
References: <40214589.5090702@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40214589.5090702@gmx.de>; from torben.krause@gmx.de on Wed, Feb 04, 2004 at 08:18:33PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[ Cc: to selinux list, which is a better place to ask these question ]

* Torben Krause (torben.krause@gmx.de) wrote:
> Here my Questions:
> 
> Which kernel patch must i use for lsm, kernel-patch-2.4-oldlsm or 
> kernel-patch-2.4-lsm ? And is there a for 2.4.23/woody ?
> 
> Furthermore, i want to know whether i've understood the information on 
> russel cokers webpage  right: new SE Linux is only available to 2.4 as 
> unstable (beside 2.6 kernel). Old SE Linux is available as unstable and 
> stable to 2.4.
> 
> Is that right ?!?

Russell is the best person to answer this.  Similar questions have been
asked on the selinux mailing list.  I believe there is a current selinux
that is backported to 2.4 and available on Woody.  According to Russell,
update /etc/apt/sources.list with:
deb http://www.microcomaustralia.com.au/debian/ stable selinux main


> So, first i patched my kernel with the lsm infrastructure 
> (kernel-patch-2.4-lsm_2003.04.07 as .deb) with make-kpkg. In the next 
> step i installed
> libselinux-dev_2003081307,selinux-policy-default_1:1.1-3.bam.1 and 
> selinux, the management utilities. I've taken the files from deb 
> http://selinux.lemuria.org/debian/ stable selinux main.
> 
> While the installion process of the selinux-policy-default i got the 
> follwing error mesage:
> 
> Setting up selinux-policy-default (1.1-3.bam.1) ...
> SE Linux not running so files not relabeled.
> Run 'make -C /etc/selinux/ relabel' manually to relabel.
> /usr/bin/checkpolicy:  loading policy configuration from 
> /etc/security/selinux/src/policy.conf
> ERROR 'parse error' at token 'normal_config_file_read_access' on line
> 84244: normal_config_file_read_access(spamd_t)
> 
> /usr/bin/checkpolicy:  error(s) encountered while parsing configuration
> make: *** [/etc/security/selinux/policy.12] Error 1
> dpkg: error processing selinux-policy-default (--configure):
>   subprocess post-installation script returned error exit status 2
> Errors were encountered while processing:
>   selinux-policy-default
> 
> 
> What is wrong there ?

I don't know, I'm sure someone on the selinux list can help you here.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
