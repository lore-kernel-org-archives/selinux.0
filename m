Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA17358
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 20:34:27 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id BAA17394
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 01:32:25 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id BAA17390 for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 01:32:23 GMT
Date: Wed, 20 Nov 2002 12:37:11 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Brad Chapman <jabiru_croc@yahoo.com>, Joshua Brindle <JBrindle@snu.edu>,
        Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
Subject: Re: SELinux distro building
Message-ID: <20021120013711.GA32740@snoopy.apana.org.au>
References: <sdd11fd2.035@atlas.snu.edu> <20021113005009.53937.qmail@web40018.mail.yahoo.com> <20021113013123.GA21921@snoopy.apana.org.au> <20021113082902.GA26850@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021113082902.GA26850@snoopy.apana.org.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 13, 2002 at 07:29:03PM +1100, Brian May wrote:

I have updated this file:

> <URL:http://www.microcomaustralia.com.au/debian/selinux-small-2002102211.tar.gz>

It should now be able to include the LSM include files correctly.

Also, the configure script will now do a simple check to ensure that the
LSM directory given is correct.
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
