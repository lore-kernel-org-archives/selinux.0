Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MGZsgA007231
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 12:35:54 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MGV6YP002435
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 16:31:07 GMT
Subject: RE: Iptables discussion
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <200507221557.j6MFvKvx017930@gotham.columbia.tresys.com>
References: <200507221557.j6MFvKvx017930@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 12:28:39 -0400
Message-Id: <1122049719.26463.35.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Trigger? The commit should cause the regeneration to happen.

Can you describe in more detail how the regeneration will occur.

Will you be regenerating a single file_contexts file, or per user 
(which is what should happen, IMHO). If the latter, how do you plan
to take the Unix users out of the equation for libsemanage.

Will you be rewriting the file as the change occurs, and simply 
renaming the result file upon commit, or will you delay template
expansion upon commit. 

Basically, how will the implementation work.

> > Also, I believe the mapping of paths to selinux users is
> > fundamentally flawed, and needs to be more generic. I will
> > acknowledge that the code I've posted so far offers no solution
> > either, and may actually be worse.
> > 
> > I want to add a new expansion called... CONTENT_DIR, which maps
> > to a bunch of locations where I store music and movies on my home
> > computer, and labels those to a certain type.
> > 
> > I want to add a new expansion called... REMOVABLE_MNT_POINT, that
> > I want labeled removable_t via integration with udev, which follows
> > my custom naming policy.
> > 
> > How does this future-proof API handle those scenarios.
> > 
> 
> I agree that this api doesn't cut it. The only alternative I have is the ability
> to specify arbitrary name-value pairs that get expanded and pass in the selinux
> user in addition to the pairs.

Let's postpone this discussion until the questions above are answered,
which are highly relevant.

Yes, I support name-value pairs... I also think we need to index such
name value pairs by a key (say the user), and that key will be used
to connect them together. I've thought about this a bit, and to me
this whole business maps very well to sql relations. All those config
files should be tables with key-value relations, and foreign keys,
and cascading deletes.... but let's not get into that right now, and
look for a more immediate solution.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
