Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA12808
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 10:10:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA17110
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 15:09:00 GMT
Received: from angusbay.vnl.com ([194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id PAA17106 for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 15:08:59 GMT
Date: Sun, 24 Mar 2002 15:22:23 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Mix and Match problems
Message-ID: <20020324152223.GM20057@vnl.com>
References: <20020322212840.CF3FE108F@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020322212840.CF3FE108F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A question for Russ. In your debian package you still
have the original policy/README file. If you are 
trying to build an selinux using your policy Makefile
there is a catch-22. The README suggests building
and installing policy first; but your Makefile uses
chsid. chsid is not built until the next step when
you make and make install libsecure; and even then
it would not ordinarily be built as the original 
libsecure/test/Makefile suggests it is needed only 
if chcon is not present.

After going through that, I still got errors when
trying to use your make install. I'm going to 
presume that is due to the fact that I'm doing
a build under a non-selinux kernel and thus
chsid is missing something it needs.

This may all be moot, and I'm getting the problems
only because I'm mixing your policy with Stephen's
release, but thought I'd mention it in case it's
of any use.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
