Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7J4vFrT024956
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 00:57:15 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7J4uWpw028952
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 04:56:33 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Carlos =?iso-8859-1?q?An=EDsio_Monteiro?= <monteiro@ipen.br>
Subject: Re: Information about execute_no_trans permission
Date: Thu, 19 Aug 2004 14:57:10 +1000
Cc: selinux <selinux@tycho.nsa.gov>
References: <41236128.9080709@ipen.br>
In-Reply-To: <41236128.9080709@ipen.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408191457.10694.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 19 Aug 2004 00:01, Carlos Anísio Monteiro <monteiro@ipen.br> wrote:
> I would like know how work the *execute_no_trans permission*.
> Is it transition ?
> How I would interprete this avc message, for sample.
>
> avc:  denied  { execute_no_trans } for  pid=1873
> exe=/usr/sbin/boserver-apache
> path=/bin/bash dev=hda3 ino=94777 scontext=system_u:system_r:httpd_t
> tcontext=system_u:object_r:shell_exec_t tclass=file

boserver-apache (domain httpd_t) is trying to execute /bin/bash (type 
shell_exec_t).  There is no rule specifying an automatic domain transition so 
therefore this is a request to execute without transition (execute_no_trans).

If you want to allow this then use the policy:

can_exec(httpd_t, shell_exec_t)

If you want it to run in a different domain then do something like the 
following:

domain_auto_trans(httpd_t, shell_exec_t, target_domain)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
