Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA15894
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 14:52:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA08455
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 18:50:41 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA08451
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 18:50:39 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 0750392713
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2002 04:52:24 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id B20B915E7
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 20:52:16 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: ssh policy
Date: Wed, 23 Oct 2002 20:52:16 +0200
MIME-Version: 1.0
Message-Id: <200210232052.16261.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

# Proxy openlogging.
allow $1_ssh_t http_cache_port_t:tcp_socket name_bind;

The above has just appeared in the new policy.  I suggest that it be in the 
policy commented out at the most.

This allows any ssh user (IE any user) to potentially subvert the web cache if 
they can cause it to crash.

I don't think I'll include this in my policy tree.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
