Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAJElGRb018154
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 09:47:16 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAJEkjBb029768
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 14:46:45 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hAJEki4o029765
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 14:46:45 GMT
Date: Wed, 19 Nov 2003 14:47:08 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Policy error of the day
Message-ID: <20031119144708.GB8546@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The policy build error for today is:

ERROR 'unknown type mailman_queue_chkpwd_t' at token ';' on line 81971:
#line 10047
allow mailman_queue_su_t mailman_queue_chkpwd_t:process transition;
/usr/bin/checkpolicy:  error(s) encountered while parsing configuration
make: *** [/etc/security/selinux/policy.15] Error 1

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
