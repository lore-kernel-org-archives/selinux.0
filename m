Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA13394
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 09:37:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA00525
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 14:35:15 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA00507
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 14:35:09 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: azeredo@qmc.ufsc.br, <selinux@tycho.nsa.gov>
Subject: Re: Problems with policy in RH8
Date: Fri, 1 Nov 2002 15:36:36 +0100
References: <Pine.LNX.4.33.0211011219430.2804-100000@quark.qmc.ufsc.br>
In-Reply-To: <Pine.LNX.4.33.0211011219430.2804-100000@quark.qmc.ufsc.br>
MIME-Version: 1.0
Message-Id: <200211011536.36890.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 1 Nov 2002 15:37, azeredo@qmc.ufsc.br wrote:
>   I saw at the  mail list someone was trying to get selinux to run in RH8.
> I am trying too. And got many audit messages. The first one was:
>
> avc: denied  {execute} for pid=9 exe=/bin/bash
> path=/lib/libnss_files-2.2.93.so dev=16:01 ino=159491
> scontext=system_u:system_r:initrc_t
> tcontext=system_u:obeject_r:var_spool_t tclass=file

That file should be labelled system_u:object_r:shlib_t not 
system_u:obeject_r:var_spool_t.  I think that if you entirely relabel your 
system then most of the problems will disappear.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
