Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3MBQnjP015655
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 07:26:49 -0400
Received: from mail-bw0-f160.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3MBQm9p000762
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 11:26:48 GMT
Received: by bwz4 with SMTP id 4so1920428bwz.18
        for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 04:26:47 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 22 Apr 2009 07:26:45 -0400
Message-ID: <9f066ee90904220426g563d2ebpa708ef8b6e1a4378@mail.gmail.com>
Subject: labeled network aware kernel
From: Mark Webb <elihusmails@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am interested in experimenting with the labeled networking that SE
Linux offers.  I am reading through Josh Brindle's blog

http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux/

My question is, how do I know if my kernel is capable of supporting
this?  I am currently running Fedora 10 with all the latest updates
but not sure how to check.

Also if I compile a kernel from source, is there anything that needs
to be done in the configuring of the kernel build to enable the
labeled networking?

Thanks,
Mark

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
