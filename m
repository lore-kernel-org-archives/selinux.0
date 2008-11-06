Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA6G4H5A023497
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 11:04:17 -0500
Received: from mail.magitekltd.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA6G4HEm011581
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 16:04:17 GMT
Received: from [24.242.137.194] (helo=[192.168.30.40])
	by mail.magitekltd.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <lenny@magitekltd.com>)
	id 1Ky7KO-0000H4-5l
	for selinux@tycho.nsa.gov; Thu, 06 Nov 2008 10:03:24 -0600
Subject: restorecon / matchpathcon
From: LC Bruzenak <lenny@MagitekLtd.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 06 Nov 2008 10:04:15 -0600
Message-Id: <1225987455.7321.37.camel@homeserver>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I see no way to recursively/silently check path context.

The matchpathcon command has a silent but no recursive option. It does
return non-zero if something doesn't match.

The restorecon command has both recursive and don't change options but
no silent. It does not return non-zero if there is a change to be made,
so a redirect of stdout to /dev/null wouldn't suffice.

Is there another way/command?

Thx,
LCB.

-- 
LC (Lenny) Bruzenak
lenny@magitekltd.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
