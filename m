Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA09760
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 11:25:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA27584
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 15:23:56 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id PAA27580
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 15:23:55 GMT
Date: Wed, 9 Oct 2002 17:25:04 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: Apache 2 file contexts
Message-ID: <20021009172503.A22321@lemuria.org>
References: <20021008160033.A5253@lemuria.org> <200210081906.13285.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200210081906.13285.russell@coker.com.au>; from russell@coker.com.au on Tue, Oct 08, 2002 at 07:06:13PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Apache2 requires some weird socket access, that I traced to the
following (by disabling all the dontaudits in the apache.te):

Oct  9 19:16:20 nsa2 kernel: avc:  denied  { read } for  pid=5347 exe=/usr/sbin/apache2 path=/1 dev=00:07 ino=3 scontext=system_u:system_r:httpd_t tcontext=tom:object_r:sysadm_devpts_t tclass=chr_file

piping that into newrules tells me:

allow httpd_t sysadm_devpts_t:chr_file { read };


Which to my (still somewhat green) ears doesn't sound like a
tremendously great idea.
It uses this only during startup, so I'm not entirely sure what it's
doing. Anyone else played with Apache2 already?


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
