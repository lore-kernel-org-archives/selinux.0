Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA09035
	for <selinux@tycho.nsa.gov>; Sat, 8 Jun 2002 09:15:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA20353
	for <selinux@tycho.nsa.gov>; Sat, 8 Jun 2002 13:15:18 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA20349
	for <selinux@tycho.nsa.gov>; Sat, 8 Jun 2002 13:15:16 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Announce: Project to port SE Linux to SuSE 8.0
Date: Sat, 8 Jun 2002 15:13:04 +0200
References: <200205311915.16873.jw@centraltexasit.com> <20020606073215.3774971A1@lyta.coker.com.au> <20020606103018.A25497@lemuria.org>
In-Reply-To: <20020606103018.A25497@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020608131544.E11951198@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 6 Jun 2002 10:30, Tom wrote:
> On Wed, Jun 05, 2002 at 01:48:04PM +0200, Russell Coker wrote:
> > > My idea is to post patches and RPMs to the web site as I (and others)
> > > manage to build them.
> >
> > That's the easy part, policy files is the hard part.
>
> which means we need more of them. more examples, more working policies
> for programs of various kinds.
>
> right now, I believe the number of people actually using SELinux is
> pretty small. but once it's increased a little (say, by 500%, to
> something like 10 people :) ) we should gather some and include the
> best ones as examples.

Yes, I think we need some policy files to hold up as examples for people who 
want to create new policy by cut/paste.  However I think that the main thing 
we need now is support for more daemons.  Once we have policy files for all 
the most common daemons (including all the ones that are installed by default 
in all popular distributions) then it'll be a lot easier to get it working on 
a given system.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
