Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4Q4OCRb023474
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 00:24:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4Q4Lfar012787
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 04:21:41 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i4Q4LGQu012738
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 04:21:41 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com
Subject: Re: mysql issues...
Date: Wed, 26 May 2004 14:17:40 +1000
Cc: Valdis.Kletnieks@vt.edu, SE Linux <selinux@tycho.nsa.gov>
References: <200405250215.i4P2FFAe027848@turing-police.cc.vt.edu>
In-Reply-To: <200405250215.i4P2FFAe027848@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405261417.40958.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 25 May 2004 12:15, Valdis.Kletnieks@vt.edu wrote:
> Running the mysql command as a mortal user dies:
>
> $ mysql -hlocalhost -u MMMMMM -p MMMMMM
> Enter password:
> ERROR 2002: Can't connect to local MySQL server through socket
> '/var/lib/mysql/mysql.sock' (13)
>
> after throwing this avc message:
> May 24 21:34:19 pink kernel: audit(1085448859.069:0): avc:  denied  {
> search } for  pid=4519 exe=/usr/bin/mysql name=mysql dev=dm-6 ino=129035
> scontext=user_u:user_r:user_t tcontext=system_u:object_r:mysqld_db_t
> tclass=dir

How should we determine who gets mysql client access?  Should we have a 
tunable determining whether we allow userdomain?

> It's not able to search /var/lib/mysql to find the socket...
>
> A (slightly edited) grep shows us:
>
> Does anybody see a good reason why we don't have this too:
>
> mysqld.te: allow mysql_cmd_t mysqld_var_run_t:dir search;
> mysqld.te: allow mysql_cmd_t mysqld_var_run_t:sock_file write;
>
> and add this to mysqld.fc:
>
> /usr/bin/mysql          system_u:object_r:mysql_cmd_t

Why have mysql_cmd_t instead of just allowing user_t directly?  What is the 
benefit in having a domain for client access?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
