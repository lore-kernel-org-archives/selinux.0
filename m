Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA15835
	for <selinux@tycho.nsa.gov>; Sun, 29 Sep 2002 20:22:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA07927
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 00:20:59 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id AAA07922
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 00:20:57 GMT
Date: Mon, 30 Sep 2002 10:22:06 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: selinux@tycho.nsa.gov
Subject: Indentifying SE-Linux version
Message-ID: <20020930002206.GB24855@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The version of the SELinux libraries seem to be constantly
changing, and introducing new incompatabilities, etc.

I think we need a way to identify what version of selinux
a given binary has been compiled against.

This could be done, for instance, with an identifying string inside
libsecure.a that is also put in compiled code, so we can do something
like:

strings /usr/bin/stat | grep SELINUX

to obtain, say "SELINUX V12".

Something like (not tested):

static char id[] = "\nSELINUX v12\n";

should be sufficient...

(Assuming that this hasn't already been done)
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
