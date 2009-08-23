Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7NGqBlU010572
	for <selinux@tycho.nsa.gov>; Sun, 23 Aug 2009 12:52:11 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7NGrKjL028281
	for <selinux@tycho.nsa.gov>; Sun, 23 Aug 2009 16:53:21 GMT
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Cc: 503252-forwarded@bugs.debian.org, Russell Coker <russell@coker.com.au>
Subject: policycoreutils: audit2allow -l doesn't work with dmesg pipe
Date: Sun, 23 Aug 2009 09:50:08 -0500
Message-ID: <87d46mvb33.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        This has been reported against the Debian BTS.

        If you don't have auditd running and you run the following
 command you should expect no output:
load_policy ; dmesg|audit2allow -l

        But it doesn't happen, it seems that the -l option doesn't work
 when taking input from dmesg.

        manoj

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=503252
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
