Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA12987
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 23:21:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA27543
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 03:20:15 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id DAA27539 for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 03:20:13 GMT
Date: Fri, 26 Jul 2002 13:21:29 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: IDENTIFIER
Message-ID: <20020726032129.GD27354@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is it possible to relax the definition of IDENTIFIER:

{letter}({letter}|{digit}|_)*   { return(IDENTIFIER); }

?

For the work I am doing, I need a way to seperate words
and phrases seperately.

For instance dpkg_postinst/oav_update.

Any one symbol would be OK, but suggested ones include ~!@%&-=/

(or all of them, but I haven't considered if this will cause problems
elsewhere; for instance : probably should not be used, it is used in
allow statements).
-- 
Brian May <bam@snoopy.apana.org.au>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
