Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA12719
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 17:36:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA10750
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 21:35:06 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA10737
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 21:35:04 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 5047D92466
	for <selinux@tycho.nsa.gov>; Fri, 23 Aug 2002 07:36:08 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id B24AC2652
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 23:36:00 +0200 (CEST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: restrict access by user identity
Date: Thu, 22 Aug 2002 23:36:00 +0200
References: <Pine.GSO.4.33.0208221358250.29931-100000@raven> <20020822205144.E6FAA6B15@lyta.coker.com.au>
In-Reply-To: <20020822205144.E6FAA6B15@lyta.coker.com.au>
MIME-Version: 1.0
Message-Id: <20020822213600.B24AC2652@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For httpd_t I think that we need to have macros for multiple 
httpd_user_content_t etc types for full multi-role support.

I don't plan to write this as I don't have much interest in this area at the 
moment.  Contributions from anyone who's doing serious things with Apache 
would be welcome.

Also it might be worth waiting for the next NSA release, it may contain some 
changes that would impact such work.


Russell Coker

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
