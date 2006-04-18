Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3IFY6Vk008965
	for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2006 11:34:06 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3IFY5ub003728
	for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2006 15:34:05 GMT
Subject: Re: VPN module
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: Petre Rodan <kaiowas@gentoo.org>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1145312312.8014.67.camel@wintermute.xmldesign.de>
References: <1144238374.19128.11.camel@wintermute.xmldesign.de>
	 <1144248600.12875.2.camel@sgc.columbia.tresys.com>
	 <20060414185125.GA7399@peter.sunspire.org>
	 <1145045255.8881.12.camel@sgc.columbia.tresys.com>
	 <1145312312.8014.67.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 11:34:45 -0400
Message-Id: <1145374486.13748.5.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-04-18 at 00:18 +0200, Erich Schubert wrote:
> Hello Christopher,
> > Merged.  One fix, I moved the initrc_t reading openvpn_etc_t to the init
> > module.
> 
> policy/modules/kernel/corenetwork.te.in currently has port 5000 for
> OpenVPN.
> 
> Port 1194 is the official IANA port for OpenVPN and should be added, too
> (or maybe even instead of port 5000, which is more likely to conflict
> with custom applications IMHO)

I've removed 5000 and added 1194.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
