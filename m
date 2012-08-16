Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7GNpNO8000647
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2012 19:51:23 -0400
Received: by obbup19 with SMTP id up19so4920012obb.12
        for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2012 16:51:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACLa4pvLe4Ptucw8GJWZHLeOXenR_osq1s1in0uf-HEj1EOQjg@mail.gmail.com>
References: <1344454290.25533.12.camel@localhost>
	<201208142118.42167.russell@coker.com.au>
	<CACLa4pss-g6qhtwmEv+pOq-jQG7smPxSEt0RU76UnL7=QPh6Hw@mail.gmail.com>
	<201208151556.44770.russell@coker.com.au>
	<CACLa4pvLe4Ptucw8GJWZHLeOXenR_osq1s1in0uf-HEj1EOQjg@mail.gmail.com>
Date: Thu, 16 Aug 2012 19:51:13 -0400
Message-ID: <CACLa4ptTz2t4=YsMsZwr6=Q+D9ssD4b84dd0cyrh2Eeg1EFbWQ@mail.gmail.com>
Subject: Re: A filename to label translation daemon
From: Eric Paris <eparis@parisplace.org>
To: russell@coker.com.au
Cc: Colin Walters <walters@verbum.org>, Daniel J Walsh <dwalsh@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Latest update was trying to decide if keeping Russell's stem work was
worth the code complexity given the speedups I can get just moving to
pcre and using a precompiled data format.  I'm thinking they aren't as
huge a win, but it's still clearly a win.  My testing is:

start timer
for (i = 0; i < 100; i++)
    initialize db;
    look up one path;
    clean up db
stop timer

So the stems code will help even more if you do more than 1 lookup per
db load.  Results at the moment for that testing looks like:

 $ ./glibc
13.390 seconds used by the processor.
$ ./glibc-stems
 8.750 seconds used by the processor.
$ ./pcre
 2.160 seconds used by the processor.
$ ./pcre-stems
 2.040 seconds used by the processor.
$ ./pcre-mmap
 0.230 seconds used by the processor.
$ ./pcre-mmap-stems
 0.170 seconds used by the processor.

So we're talking about a x50 speedup here for my best case vs
something analogous to what we are doing today.

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
