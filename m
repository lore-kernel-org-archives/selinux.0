Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7O8ubrT024536
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 04:56:39 -0400 (EDT)
Received: from kokytos.rz.informatik.uni-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7O8tpMZ022888
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 08:55:52 GMT
Received: from rom.cip.ifi.lmu.de (rom.cip.informatik.uni-muenchen.de [141.84.214.183])
	by kokytos.rz.informatik.uni-muenchen.de (Postfix) with ESMTP id B0FD743572
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 10:56:33 +0200 (CEST)
Date: Tue, 24 Aug 2004 10:56:33 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: selinux and kde
Message-ID: <20040824085633.GD11911@rom.cip.ifi.lmu.de>
References: <20040823234320.GC12720@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20040823234320.GC12720@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-08-24 02:42]:
> ... does anyone ever actually _use_ strict selinux policy enforcing
> and successfully run kde under it??

Yes, I do.
All machines here are using KDE without problems. My policy is currently
based on Fedora policy 1.15.7-something (haven't come around to updating
for a while). I don't do CD burning here, so no comment on that, but
everything else should work[0].
What problems are you seeing?

Thomas

[0]: Not entirely true, I have to admit, after looking through my
policy:
# you will need this if you want to play unreal; not suitable for
# general policy
allow userdomain dri_device_t:chr_file rw_file_perms;

I also had some extra allow rules for the user_mount-domain (in
macros/user_macros.te), when mount is called from kde, but I'll have to
check again if these are needed.

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
