Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA15957
	for <selinux@tycho.nsa.gov>; Sun, 22 Dec 2002 10:52:22 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA19047
	for <selinux@tycho.nsa.gov>; Sun, 22 Dec 2002 15:49:53 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA19043
	for <selinux@tycho.nsa.gov>; Sun, 22 Dec 2002 15:49:51 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Subba Rao" <sailorn@attglobal.net>, selinux <selinux@tycho.nsa.gov>
Subject: Re: avc: denied
Date: Sun, 22 Dec 2002 16:52:08 +0100
References: <200212221456.OAA17687@jazzswing.ncsc.mil>
In-Reply-To: <200212221456.OAA17687@jazzswing.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200212221652.08865.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 22 Dec 2002 15:58, Subba Rao wrote:
> ===================
> avc:  denied  { search } for  pid=848 exe=/usr/bin/perl path=/var/www/mrtg
> dev=03:01 ino=272926 scontext=system_u:system_r:crond_t
> tcontext=system_u:object_r:httpd_sys_content_t tclass=dir

Did you install my mrtg policy?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
