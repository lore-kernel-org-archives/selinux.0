Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3GCXmI4001081
	for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2003 08:33:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3GCXk7R011029
	for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2003 12:33:46 GMT
Received: from lyta.coker.com.au (c16702.sunsh1.vic.optusnet.com.au [210.49.228.68])
        by jazzband.ncsc.mil  with ESMTP id h3GCXhKP011026 for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2003 12:33:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
Subject: Fwd: Bug#189251: oops, cosmetics
Date: Wed, 16 Apr 2003 22:33:47 +1000
To: selinux@tycho.nsa.gov
Cc: Peter Gervai <grin@tolna.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304162233.47714.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If you have a file named "a+++b" or some other name that is a regex wildcard 
then newrules.pl does not handle AVC messages referring to it correctly.  
This patch fixes that, and I've applied it to my Debian package already.

----------  Forwarded Message  ----------

Subject: Bug#189251: oops, cosmetics
Date: Wed, 16 Apr 2003 20:01
From: Peter Gervai <grin@tolna.net>
To: 189251-maintonly@bugs.debian.org


--- newrules-selinux-   2003-04-16 12:56:54.000000000 +0200
+++ newrules-selinux    2003-04-16 13:14:13.000000000 +0200
@@ -79,6 +79,8 @@

     my($c,$c,$c,$c) = split /\|/, $group;
     $info=~s/\ $c=\S+\ //gi;
+    # escape regexp patterns --<g>
+    $info=~s/([^\w])/\\$1/g;

     @atypes=split /\ /,$command;
     foreach $i(0..$#atypes){
@@ -113,6 +115,7 @@
                print OUT  "$t ";
     }
     print OUT "};\n";
+    $occur{$k} =~ s/\\(.)/$1/g;  # de-escape string
     print OUT "$occur{$k}\n" if ($verbose);
 }

-------------------------------------------------------

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
