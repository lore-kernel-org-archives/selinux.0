Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA07628
	for <selinux@tycho.nsa.gov>; Fri, 13 Dec 2002 17:31:25 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA19634
	for <selinux@tycho.nsa.gov>; Fri, 13 Dec 2002 22:29:02 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA19629
	for <selinux@tycho.nsa.gov>; Fri, 13 Dec 2002 22:29:00 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E9558924C8
	for <selinux@tycho.nsa.gov>; Sat, 14 Dec 2002 09:31:20 +1100 (EST)
Date: Fri, 13 Dec 2002 23:31:08 +0100
To: selinux@tycho.nsa.gov
Subject: new Debian packages
Message-ID: <20021213223108.GA5424@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: russell@coker.com.au (Russell Coker)
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have packaged the new kernel patch and the selinux-small code and uploaded
them to my web site and to Debian.

Please make sure that you install the "selinux" and "selinux-policy-default"
packages BEFORE booting a kernel compiled with the latest kernel patch.

The new kernel patch has a new type that is used in the boot phase and
will be unhappy if you have an old policy (it still seems to work
though - you can get your machine to the stage of installing the new
policy and rebooting when it's in such a state).



Russell Coker

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
