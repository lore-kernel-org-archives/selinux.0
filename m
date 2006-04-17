Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3HMNNwq026555
	for <selinux@tycho.nsa.gov>; Mon, 17 Apr 2006 18:23:23 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3HMNLND003523
	for <selinux@tycho.nsa.gov>; Mon, 17 Apr 2006 22:23:22 GMT
Subject: Re: VPN module
From: Erich Schubert <erich@debian.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Petre Rodan <kaiowas@gentoo.org>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1145045255.8881.12.camel@sgc.columbia.tresys.com>
References: <1144238374.19128.11.camel@wintermute.xmldesign.de>
	 <1144248600.12875.2.camel@sgc.columbia.tresys.com>
	 <20060414185125.GA7399@peter.sunspire.org>
	 <1145045255.8881.12.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 18 Apr 2006 00:23:25 +0200
Message-Id: <1145312605.8014.71.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Christopher,
Two more issues with openvpn:
avc:  denied  { sys_tty_config } for  pid=2716 comm="sh" capability=26
scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:openvpn_t:s0 tclass=capability
avc:  denied  { search } for  pid=2717 comm="openvpn" name="tun0"
dev=sysfs ino=8054 scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:object_r:sysfs_t:s0 tclass=dir

The first looks pretty straighforward, I don't know about sysfs handling
in SELinux...

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     This one's tricky. You have to use imaginary numbers, like     //\
                      eleventeen... --- Hobbes                      V_/_
          Ein schöner Moment leuchtet das Leben hindurch.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
