Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6QMJHHa011770
	for <selinux@tycho.nsa.gov>; Sat, 26 Jul 2003 18:19:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6QMI3FB027530
	for <selinux@tycho.nsa.gov>; Sat, 26 Jul 2003 22:18:03 GMT
Received: from zaphod.crypt.gen.nz (203-79-124-112.adsl.paradise.net.nz [203.79.124.112])
	by jazzswing.ncsc.mil  with ESMTP id h6QMI1GD027521
	for <selinux@tycho.nsa.gov>; Sat, 26 Jul 2003 22:18:02 GMT
Subject: Re: 2003071106 on RH 7.2
From: Kerry Thompson <kerry@crypt.gen.nz>
To: "Paul L. Allen" <paul.l.allen@boeing.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <200307250937.30020.russell@coker.com.au>
References: <3F209F03.60900@boeing.com>
	 <200307250937.30020.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1059257926.5793.4.camel@edmond.crypt.gen.nz>
Mime-Version: 1.0
Date: 27 Jul 2003 10:18:47 +1200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-07-26 at 01:37, Russell Coker wrote:
> On Thu, 24 Jul 2003 23:07, Paul L. Allen wrote:
> > It went a bit farther, but then stopped with this complaint:
> >
> > ERROR 'unknown type system_mail_t' at token ';' on line 28350
> 
> I tried to reproduce this and it seemed to work fine.
> 
> Please gzip the policy.conf file and put it on a web server where I can get a 
> copy.  Also tell me about any changes you may have made.

Probably need to:
 
    mv domains/program/unused/mta.te domains/program/

I usually miss that one too.


-- 
Kerry Thompson <kerry@crypt.gen.nz>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
