Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3IFZuLB009046
	for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2006 11:35:56 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3IFZsXZ013603
	for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2006 15:35:55 GMT
Subject: Re: VPN module
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: Petre Rodan <kaiowas@gentoo.org>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1145312605.8014.71.camel@wintermute.xmldesign.de>
References: <1144238374.19128.11.camel@wintermute.xmldesign.de>
	 <1144248600.12875.2.camel@sgc.columbia.tresys.com>
	 <20060414185125.GA7399@peter.sunspire.org>
	 <1145045255.8881.12.camel@sgc.columbia.tresys.com>
	 <1145312605.8014.71.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 11:36:35 -0400
Message-Id: <1145374595.13748.8.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-04-18 at 00:23 +0200, Erich Schubert wrote:
> Hi Christopher,
> Two more issues with openvpn:
> avc:  denied  { sys_tty_config } for  pid=2716 comm="sh" capability=26
> scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:system_r:openvpn_t:s0 tclass=capability
> avc:  denied  { search } for  pid=2717 comm="openvpn" name="tun0"
> dev=sysfs ino=8054 scontext=system_u:system_r:openvpn_t:s0
> tcontext=system_u:object_r:sysfs_t:s0 tclass=dir
> 
> The first looks pretty straighforward, I don't know about sysfs handling
> in SELinux...

sys_tty_config can probably be dontaudited, as it is in almost all other
daemons.  Is the search on sysfs the only access needed, or is it
reading entries in sysfs?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
