Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB9AtCRb021594
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 05:55:12 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB9AsRlU001581
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 10:54:27 GMT
Received: from nox.lemuria.org ([213.191.86.35])
	by jazzswing.ncsc.mil  with ESMTP id hB9AsRSX001578
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 10:54:27 GMT
Date: Tue, 9 Dec 2003 11:54:49 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Policy in arch/tla
Message-ID: <20031209115448.B1732@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've finally managed to get it set up. It doesn't like its destination
directory already existing, apparently. That plus a few limit
directives that Brian supplied worked out.

Please try if it works. The repository is:

tom@lemuria.org--selinux-public
    http://guest:guest@nox.lemuria.org/arch/public/

And there is one item there named "policy--default--0.1"

guest should have both read and write access. I think that's ok. If any
jerk trashes everything, we can easily revert, and if someone wants to
fill my harddisk with MP3s, feel free to. :)


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
