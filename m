Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB504kRb001721
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 19:04:46 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB5045lU007987
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 00:04:05 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hB5043SX007972
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 00:04:04 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 5154661BF1
	for <selinux@tycho.nsa.gov>; Fri,  5 Dec 2003 11:04:37 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 26278-02 for <selinux@tycho.nsa.gov>;
	Fri, 5 Dec 2003 11:04:36 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id DA7D361BF0
	for <selinux@tycho.nsa.gov>; Fri,  5 Dec 2003 11:04:36 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id AEB58924C4
	for <selinux@tycho.nsa.gov>; Fri,  5 Dec 2003 11:04:36 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id C01477F296
	for <selinux@tycho.nsa.gov>; Fri,  5 Dec 2003 11:04:34 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Basic question on policy design
Date: Fri, 5 Dec 2003 11:04:34 +1100
References: <000401c3ba6a$ad593430$8100a8c0@columbia.tresys.com> <3FCF968B.3050504@diyab.net>
In-Reply-To: <3FCF968B.3050504@diyab.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312051104.34261.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 5 Dec 2003 07:18, Diyab <diyab@diyab.net> wrote:
> require the ability to speak to one another.  So for process to process
> you might end up with something like:

can_tcp_connect(httpd_t, postgresql_t)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
