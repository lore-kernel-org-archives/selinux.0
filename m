Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7NGqEEu010577
	for <selinux@tycho.nsa.gov>; Sun, 23 Aug 2009 12:52:14 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7NGpetd021138
	for <selinux@tycho.nsa.gov>; Sun, 23 Aug 2009 16:51:40 GMT
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Cc: 524508-forwarded@bugs.debian.org, Bastian Blank <waldi@debian.org>
Subject: policycoreutils - semanage does not set umask
Date: Sun, 23 Aug 2009 09:46:54 -0500
Message-ID: <87hbvyvb8h.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        This has been reported to the Debian BTS.

        semanage does not set the umask for itself and does not fix the
 permissions of rewritten files. This leads to a unreadable (for generic
 user and therfor ssh) seusers file:
 -rw-r----- 1 root root 187 17. Apr 16:22 /etc/selinux/default/seusers

        The pam module does not bail out on that but always assigns
 user_u for users.

        manoj

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=524508
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
