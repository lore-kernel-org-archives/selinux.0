Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA26471
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 17:53:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA19929
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 22:52:04 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA19925 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 22:52:03 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: uses_shlib
Date: Wed, 20 Mar 2002 23:52:56 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0203201550290.11981-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0203201550290.11981-100000@raven>
MIME-Version: 1.0
Message-Id: <20020320225257.C7CB12EC7E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Mar 2002 21:51, Stephen Smalley wrote:
> On Wed, 20 Mar 2002, Russell Coker wrote:
> > The libc on my system uses a file named /etc/ld.so.preload.
> > I have added the following line to my file_contexts:
> > /etc/ld.so.preload              system_u:object_r:ld_so_t
>
> You mean ld_so_cache_t not ld_so_t, right?

Both actually, I need the /etc/ld.so.preload as well.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
