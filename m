Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2V9vEDo023407
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 04:57:14 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2V9tuiv023595
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 09:55:57 GMT
Date: Thu, 31 Mar 2005 11:05:33 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Tom <tom@lemuria.org>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Casey Schaufler <casey@schaufler-ca.com>,
   selinux@tycho.nsa.gov
Subject: Re: Desktop apps interoperability
Message-ID: <20050331100533.GD9752@lkcl.net>
References: <20050330155207.58846.qmail@web31601.mail.mud.yahoo.com> <1112199204.8592.13.camel@cobra.ivg2.net> <20050330235010.B622@lemuria.org> <20050330221246.GC9752@lkcl.net> <20050331103736.K1195@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050331103736.K1195@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Mar 31, 2005 at 10:37:36AM +0200, Tom wrote:
> On Wed, Mar 30, 2005 at 11:12:46PM +0100, Luke Kenneth Casson Leighton wrote:
> >  kdbfs "flattens" the directory structures and forces applications,
> >  via patches to the file save and file open dialogs, to ONLY be able
> >  to save documents in certain subdirectories, ~/Documents, ~/Music ...
> >  etc.
> 
> There will be many people who reject that concept 

 yep - i know.  i didn't say it was a "nice" solution.

 for "dummies" - the sorts of people who use MAC OS/X -
 directories are a massive confusional concept.

 think of the kinds of people who store 16,000 files in "My Documents"
 because they've never heard of creating folders.
 
 [and we won't talk about the person who spent 10 minutes each
 day paging down the same word document until they got to the
 end, okay? :) ]

 we are _privileged_ people who "understand" computers, graphical
 OSes, and such.

 it's vitally important to remember that there are people out there who:

 a) can't use a mouse

 b) can't phyisically or PSYCHOLOGICALLY see or locate a cursor
    (esp. the Mozilla Firefox and MS Word vertical bar ones)

 c) don't really understand the concept of folders being a thing
    with a border around it, let alone directories.

 so, whilst we all "love" to put documents where we "want", creating
 lovely structured directory hierarchies with symlinks to convenient
 places, the majority of users simply use what's put in front of them
 [and typically use or grok very little of even that].

 and Apple put the "finder" in front of people, on MAC-OS/X,
 and they sodding love it, because it finds EVERYTHING that's
 useful to them.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
