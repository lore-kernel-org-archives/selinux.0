Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h99EEIWt025688
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 10:14:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h99EAEVR011067
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 14:14:15 GMT
Received: from nsa.hitachi-sk.co.jp (nsa.hitachi-sk.co.jp [202.232.217.2])
        by jazzband.ncsc.mil  with ESMTP id h991P1dq019388 for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 01:25:02 GMT
Received: from vsa.hitachi-sk.co.jp ([133.108.250.41])
	by nsa.hitachi-sk.co.jp (8.11.6/3.7W) with ESMTP id h991Onq26937
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 10:24:49 +0900
Received: from gwa.hitachi-sk.co.jp (localhost [127.0.0.1])
	by vsa.hitachi-sk.co.jp (8.9.3+3.2W/3.7W) with ESMTP id KAA13902
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 10:24:48 +0900 (JST)
Received: (from root@localhost)
	by gwa.hitachi-sk.co.jp (8.11.6+Sun/3.7W) id h991OT516242
	for selinux@tycho.nsa.gov; Thu, 9 Oct 2003 10:24:30 +0900 (JST)
Received: from ori.hitachi-sk.co.jp (ori.ori.hitachi-sk.co.jp [133.108.2.2])
	by dns1.hitachi-sk.co.jp (8.11.6/3.7W) with ESMTP id h991OSS21658
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 10:24:28 +0900
Message-Id: <200310090124.AA01358@ilios104.ori.hitachi-sk.co.jp>
From: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
Date: Thu, 09 Oct 2003 10:24:28 +0900
To: selinux@tycho.nsa.gov
Subject: newrules.pl -o option
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


The usage of newrules.pl 's -o option is "-o  append output to <outputfile>".
"-o" means "append", but <outputfile> is overwritten.
Is the following patch correct ? 
Thank you.

--- newrules.pl.orig    2003-10-08 18:48:50.000000000 +0900
+++ newrules.pl 2003-10-08 18:48:59.000000000 +0900
@@ -37,7 +37,7 @@
 elsif ($input)   { open (IN, "$input");      }
 else             { open (IN, "-");           }  # STDIN
  
-if ($output)     { open (OUT, ">$output");   }
+if ($output)     { open (OUT, ">>$output");   }
 else             { open (OUT, ">-");         }  # STDOUT

----
Yuichi Nakamura
ynakam@ori.hitachi-sk.co.jp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
