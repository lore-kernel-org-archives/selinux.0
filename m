Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2GMhUx6024772
	for <selinux@tycho.nsa.gov>; Sun, 16 Mar 2003 17:43:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA05610
	for <selinux@tycho.nsa.gov>; Sun, 16 Mar 2003 22:40:04 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id WAA05593
	for <selinux@tycho.nsa.gov>; Sun, 16 Mar 2003 22:39:59 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 25969BF42
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 09:43:04 +1100 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 16142-06
 for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 09:43:03 +1100 (EST)
Received: from tsv.sws.net.au (unknown [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id EF627BF41
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 09:43:02 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id AEC2A9253C
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 09:43:03 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 9EFE42C2D
	for <selinux@tycho.nsa.gov>; Sun, 16 Mar 2003 23:42:53 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Apache policy
Date: Sun, 16 Mar 2003 23:42:50 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200303162342.50653.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am continuing to work on my new Apache policy and it's getting fairly good.

I have got my new policy for cgi-bin scripts fairly well done apart from one 
fundamental issue that also applies to the current sourceforge policy for 
Apache.  That is that user cgi-bin scripts are run in the system_r role which 
is bad form.

Having those scripts run in system_r means that the domains that they enter 
(such as for sending mail) also have to be allowed for system_r.  Currently I 
have all the cgi-bin scripts run their mail as system_mail_t, I am unsure 
which is worse, allowing the user to run the mail in the same domain as the 
system mail, or allowing many more domains for system_r.  This just gets even 
uglier whichever way you proceed.

Now I think that the only correct thing to do is to have a cgiwrap/suexec type 
program with SE Linux functionality to use the correct role and identity for 
the cgi-bin scripts (I believe that something similar has been done 
previously but not released).

When I get this done I think that we should make the standard policy only 
support cgi-bin scripts through a SE modified cgiwrap program, as anything 
else leads to deficiencies in the policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
