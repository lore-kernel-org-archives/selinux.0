Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3ECKiI4019804
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2003 08:20:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3ECKgq0001498
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2003 12:20:43 GMT
Received: from lyta.coker.com.au (c16702.sunsh1.vic.optusnet.com.au [210.49.228.68])
        by jazzband.ncsc.mil  with ESMTP id h3ECKVMi001464 for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2003 12:20:41 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: auditallow
Date: Mon, 14 Apr 2003 22:20:25 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200304141822.43798.russell@coker.com.au> <20030414121048.GB29334@snoopy.apana.org.au>
In-Reply-To: <20030414121048.GB29334@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304142220.25552.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 14 Apr 2003 22:10, Brian May wrote:
> On Mon, Apr 14, 2003 at 06:22:43PM +1000, Russell Coker wrote:
> > Apr 14 18:16:21 caesar kernel: avc:  denied  { search } for  pid=8716
> > exe=/usr/sbin/sendmail path=/run dev=09:03 ino=2593
> > scontext=root:sysadm_r:sysadm_mail_t tcontext=system_u:object_r:var_run_t
> > tclass=dir
> >
> > Surely it should be reporting "granted" not "denied".
>
> Are you sure it really is granted, and not denied?

I think that it is denied, my message was not clear enough.

The result should be printing "granted" and actually allowing the operation, 
neither of which appears to happen.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
