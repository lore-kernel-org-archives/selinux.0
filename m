Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA06498
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 10:33:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA19468
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 14:32:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA19464
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 14:32:44 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Ed Street <blacknet@simplyaquatics.com>
Subject: Re: cleaning psidfiles database
Date: Wed, 10 Jul 2002 16:33:08 +0200
Cc: "'SE Linux'" <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0207100952070.26546-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0207100952070.26546-100000@raven>
MIME-Version: 1.0
Message-Id: <20020710143308.945886D22@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 10 Jul 2002 15:58, Stephen Smalley wrote:
> On Wed, 10 Jul 2002, Ed Street wrote:
> > Speaking of make relabel.  Would it not be a good idea to run a relabel
> > at boot time?
>
> Not unless you really want to reset the system to the initial state
> specified in file_contexts on each boot.  The persistent label mappings
> track runtime changes made since the initialization, like file type
> transitions for new files and individual relabels via chcon.  A 'make
> relabel' on each boot will lose such runtime changes unless you update
> your file contexts configuration or you exclude these files via <<none>>
> entries.  'make relabel' is also slow, as it must traverse the entire
> filesystem.

It should be noted that anyone who wants the functionality of a "make relabel 
on boot" would be better off making a copy of file_contexts for use with 
genfs which uses only pattern matching not regex's.

But it shouldn't be necessary, persistant labelling should do everything you 
want apart from the cases of ISO9660, nfs, and other file systems that can't 
be labelled.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
