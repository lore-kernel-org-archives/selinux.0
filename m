Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2O4box6000749
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2003 23:37:50 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2O4YJlY006224
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 04:34:19 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h2O4YGKX006221
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 04:34:18 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id D75C8BF43
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 15:37:45 +1100 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 31106-05
 for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 15:37:44 +1100 (EST)
Received: from tsv.sws.net.au (unknown [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 7BA3BBF42
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 15:37:44 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 312299253C
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 15:37:46 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 0D52D25B
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 05:37:34 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: setfiles.c minor change
Date: Mon, 24 Mar 2003 05:37:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200303240537.33039.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Could this:
#include <limits.h>
Be changed to this:
#include <linux/limits.h>

Such a change makes it build on a cross-compile for ARM and seems to have no 
deficiency for a regular compile (it's only used for FILE_MAX anyway).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
