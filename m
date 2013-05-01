Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r41CEeRu024941
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2013 08:14:40 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so1802698ieb.13
        for <selinux@tycho.nsa.gov>; Wed, 01 May 2013 05:14:38 -0700 (PDT)
Received: from  (MP202x-081-ResNet.Mines.EDU. [138.67.79.81])
        by mx.google.com with ESMTPSA id b6sm3324789igv.5.2013.05.01.05.14.36
        for <selinux@tycho.nsa.gov>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 May 2013 05:14:36 -0700 (PDT)
Date: Wed, 1 May 2013 12:14:26 +0000
From: Michael Seyfert <michael@codesand.org>
To: selinux@tycho.nsa.gov
Subject: Current Makefile system is inconvenient/limited
Message-ID: <5181072c.4648320a.7ef1.ffff8111@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The current system for building selinux requires a lot of workarounds like C_INCLUDE_PATH and is also interdependent on setools. I was looking at the debian packages and they require two build throughs of selinux just to get things to compile properly. Am I the only one that thinks this is a problem?
-- 
Michael Seyfert

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
