Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2HJCgx6001420
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 14:12:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2HJ9Fn8025689
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 19:09:16 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-195.nas-smoothtransition.com [66.95.157.195] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id h2HJ9Fpk025685
	for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2003 19:09:15 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Russell Coker'" <russell@coker.com.au>,
   "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: general policy stuff
Date: Mon, 17 Mar 2003 14:12:22 -0500
Message-ID: <006201c2ecb9$27829790$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200303170036.12421.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> The Makefile for the policy has constraints mis-spelled in 
> the following line:
> POLICYFILES += tmp/contraints-contexts.m4

My fault...came in my last patch to fix user name space.  Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
