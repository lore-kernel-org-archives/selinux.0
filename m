Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA12329
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 14:38:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA06982
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 18:36:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA06978
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 18:36:31 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: init and sigchld
Date: Fri, 19 Apr 2002 20:38:01 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204191353170.18117-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204191353170.18117-100000@raven>
MIME-Version: 1.0
Message-Id: <20020419183801.BA6441EE37@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 19 Apr 2002 19:53, Stephen Smalley wrote:
> On Thu, 18 Apr 2002, Russell Coker wrote:
> > OK.  I've created an every.te file in my tree with this rule, and removed
> > every instance of
> > allow ... init_t:process sigchld;
>
> Actually, I suppose that we could just place this rule into init.te.

Makes sense to me.  I've done that in my tree now.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
