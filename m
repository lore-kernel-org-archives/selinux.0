Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h44AQXI4023579
	for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 06:26:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h44AQLVf028558
	for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 10:26:21 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h44AQI4D028555
	for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 10:26:19 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: ssh/login
Date: Sun, 4 May 2003 20:25:31 +1000
Cc: selinux@tycho.nsa.gov
References: <20030501022414.GA13019@snoopy.apana.org.au> <1051793224.1377.64.camel@moss-huskers.epoch.ncsc.mil> <20030504090134.GB2483@snoopy.apana.org.au>
In-Reply-To: <20030504090134.GB2483@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305042025.31763.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 4 May 2003 19:01, Brian May wrote:
> > +	extern int ss_initialized;
> > +
> > +	if (!ss_initialized)
> > +		return -ENOSYS;
> >
> >  	tsec = current->security;
> >  	return tsec->sid;
>
> I can confirm that this patch works.

Works for me on ARM too.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
