Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r49KpHAs007496
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2013 16:51:17 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id E3FFB1A073
	for <selinux@tycho.nsa.gov>; Thu,  9 May 2013 22:51:11 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OnJSYo-WcCIO for <selinux@tycho.nsa.gov>;
	Thu,  9 May 2013 22:51:10 +0200 (CEST)
Received: from soldur.bigon.be (unknown [IPv6:2a02:578:85fc:1:dae:a3d6:709f:cc83])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 05C861A067
	for <selinux@tycho.nsa.gov>; Thu,  9 May 2013 22:51:09 +0200 (CEST)
Date: Thu, 9 May 2013 22:51:06 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: audit2allow/sepolgen not setting the locale properly when
 calculating the bootdate
Message-ID: <20130509225106.7191c1df@soldur.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

When using a locale that use the date format other than MM/DD/YY,
allow2audit -b is not working properly (shows <no matches>). The
ausearch executable is expecting the date to be formatted in the user
locale.

Explicitly setting "locale.setlocale(locale.LC_ALL, '')" inside the
sepolgen get_audit_boot_msgs() function (or in the allow2audit
executable) is passing the correct date to the ausearch executable.

I'll propose a patch for this if you want, but I'm not sure if you would
prefer this to be fixed in the audit2allow executable or in the sepolgen
python library.

Cheers

Laurent Bigonville

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
