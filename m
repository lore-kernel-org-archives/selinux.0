Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i711M3rT004658
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 21:22:03 -0400 (EDT)
Received: from darksorcerers.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i711LUHs013906
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 01:21:31 GMT
Message-Id: <200408010121.i711LUHs013906@mummy.ncsc.mil>
Date: Sun, 1 Aug 2004 4:20:54 -0000
From: "Nikolay" <Nikolay@alexandrov.ws>
To: selinux@tycho.nsa.gov
Reply-to: "Nikolay" <nikolay@alexandrov.ws>
Subject: Some ideas and info.
Content-Type: text/plain; charset="iso-8859-1";
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi. I was wondering if you've thought about implementing non-exec pages and
stack randomization?
In case that the user hasn't got the PaX patches it's nice to be protected
at least a little more isn't it ? I think that at least basic
implementations of such mechanisms is needed and would help in improving the
security level.
I could implement such ideas, if you'd like ofcourse.

(Sorry for my poor english (it's not my native language. I also intend to
write often here, I like the ideas of your project and I would be glad to
help you.)
Best regards,
Nikolay


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
