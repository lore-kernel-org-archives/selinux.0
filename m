Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA04664
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 10:19:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA13881
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 14:18:29 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA13877 for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 14:18:27 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: init and sigchld
Date: Thu, 18 Apr 2002 16:19:25 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204180845300.26541-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204180845300.26541-100000@raven>
MIME-Version: 1.0
Message-Id: <20020418141926.325FE28605@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Apr 2002 14:47, Stephen Smalley wrote:
> On Thu, 18 Apr 2002, Russell Coker wrote:
> > What is the benefit in denying sigchld access to init?
> >
> > How can a process do harm by sending sigchld to the init process?
> >
> > I am thinking of doing the following:
> >
> > allow domain init_t:signal sigchld;
>
> This rule used to exist in every.te, and was then moved into
> general_domain_access() in global_macros.te.  I suppose we could
> revive every.te and put a few rules like this one into it.

OK.  I've created an every.te file in my tree with this rule, and removed 
every instance of
allow ... init_t:process sigchld;

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
