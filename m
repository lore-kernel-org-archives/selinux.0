Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8JJA8rT013342
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 15:10:08 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8JJ992w028145
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 19:09:10 GMT
Date: Sun, 19 Sep 2004 20:21:08 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <method@gentoo.org>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: [RFC] Upstream policy handling
Message-ID: <20040919192108.GD23901@lkcl.net>
References: <414DA0A7.1000708@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <414DA0A7.1000708@gentoo.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 19, 2004 at 11:07:19AM -0400, Joshua Brindle wrote:

> If there are any other suggestions or comments on this I'd like to hear 
> them. Obviously the implementation details are up in the air here, and I 
> know that some of you can't/won't use bk. If there are suggestions for a 
>  better system and a way to host it (preferably neutrally) that would 
> be great.

 a little understood and even less deployed method of using
 cvs is to checkout a repository with a tag (e.g. NSA) and then
 checkout individual files with a different tag (e.g. REDHAT).

 the REDHAT repository should contain *only* the files that are
 different (or extra).

 first you do a cvs co -r NSA and then you do a cvs update -r REDHAT.

 what happens is that the files in the REDHAT repository overwrite
 those in the mainly NSA local checkout: examination of CVS/Entries
 shows a mixed selection of NSA and REDHAT tags.


 note that you _cannot_ due to a bug do a cvs co followed
 by a cvs update -r REDHAT.  if you then look in valtags
 (in CVSROOT on in this case the sourceforge repository)
 then you will find that there is an entry with two spaces:
 this causes all subsequent cvs operations to fail until the
 file is MANUALLY edited.  yes a bug was raised about this,
 and even a patch produced (several years ago) and no the cvs
 maintainers haven't bothered to fix it.

 a small script could be written to do the checkouts.

 maintainers of the REDHAT repository simply add whatever files that
 are different from the NSA repository to the REDHAT repository.

 one other thing that's useful is of course cvs diff -r NSA to check
 the differences between the REDHAT files and NSA ones: this works
 as expected.

 cvs update also works as expected.

 the only thing is that from a maintenance point of view (commits)
 it will be necessary to write some scripts (to go in CVSROOT)
 that double-check who is allowed to commit to the NSA tag and
 who to the REDHAT one.

 at this point i'd recommend doing the same trick as above, with
 subversion, over cvs any day...

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
