Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA20481
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 15:09:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA22345
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 19:08:11 GMT
Received: from gricklegrass.epoch.ncsc.mil (gricklegrass.epoch.ncsc.mil [144.51.25.138])
	by jazzswing.ncsc.mil  with ESMTP id TAA22341
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 19:08:10 GMT
Date: Fri, 26 Apr 2002 15:09:45 -0400
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: new SE Linux release
Message-ID: <20020426150945.A6434@gricklegrass.epoch.ncsc.mil>
References: <20020426132826.12CAE2CC9@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020426132826.12CAE2CC9@lyta.coker.com.au>; from russell@coker.com.au on Fri, Apr 26, 2002 at 03:28:25PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yes, I do know what the plans are for a new release. :-)

We have been reducing the effort needed to "produce" a release since our
first public release and hope to reduce it much further in the future.
Nevertheless, each release take significant effort that we can't spend
on SELinux.  So we try to release often enough, but not too often.  That
said, we hope to produce a new release Real Soon Now.  Where Real Soon
Now is no earlier than Monday, but maybe as early as Monday or Tuesday.
Unfortunately there are a number of places where "things can get stuck"
for us, so I can't promise any release dates, but I will personally be
surprised if a new release isn't available sometime next week - my
best educated guess is a new release on Tuesday.

We also recognize that this is frustrating for everyone.  That's one
reason that the nsa directory of the CVS tree on SourceForge is not
just the latest NSA release, but also published (on this list) critical
patches that we anticipate being in the next release.

On Fri, Apr 26, 2002 at 03:28:25PM +0200, Russell Coker wrote:
> Do you know what the plans are for a new SE Linux release?
> 
> Currently there are 4 kernel patches and about a dozen separate patches to 
> selinux-small which are needed in addition to the base code.
> 
> This is difficult to manage for me and other people preparing distributions 
> of SE Linux and is probably more difficult for people who want to compile 
> their own.  Also there are some new patches I want to write for SE Linux but 
> I have not done because I don't want to get too far from the official code.
> 
> I believe that if my tree diverges too much from the official tree then 
> potential users will be afraid to use it.
> 
> Another issue is the developments of the sample policy.  Organizations such 
> as Tresys Technology are writing documents about SE Linux policy based on the 
> structure of the sample policy and the location of the policydb.  However 
> that policy has been changed in some structural ways and the location of the 
> policydb has been changed.  As these changes are not in an official release 
> Tresys are not documenting them, which means that my packages do not match up 
> with Tresys documents which thus causes confusion for the users.
> 
> Also instead of a new release an official patch comprising two patch files 
> (one for the kernel and one for the selinux-small) to apply against the last 
> release would be just as good.  Also I believe that it would be best if such 
> a patch was released every time there was to be a structural change to the 
> sample policy or a change to the macros used.
> 
> 
> One thing I want to code is some changes to setfiles.  I believe that I can 
> make setfiles more flexible regarding input files (by removing the order 
> dependency on the file_contexts) as well as making it use less CPU time for 
> the average case.  But I am not prepared to start work on this until I get a 
> copy of the newest setfiles source (some reasonably serious changes have been 
> applied recently and I'm concerned that the next release might not quite 
> match the patches I've received).
> 
> Another thing I want to do is improve the macros.  I have some ideas for 
> macros that will make it easier to write policy without being too permissive 
> (I believe that some of the current macros are being misused and some domains 
> are getting more access than they deserve).  Also I aim to make the 
> domains/program/* files significantly smaller on average through better 
> macros, this is primarily because a small file is easier to audit.  But 
> another benefit is that as it's easier to write a small file the users will 
> be more likely to create new domains instead of improperly forcing additional 
> programs into the same domain or blindly copying an existing domain without 
> removing unnecessary permissions.
> 
> But my policy tree is already immensely different from the latest release, 
> and I don't want to introduce any more significant changes until the last 
> policy changes we all agreed on are in use by everyone.
> 
> When I start using Sourceforge for policy files (as Stephen has requested) 
> this situation will improve, but I still don't want to go too far from the 
> distribution (you should be able to copy files back and forth between a 
> Debian system and a Slackware install without excessive pain).
> 
> 
> Russell Coker
> 
> 
> PS  I was going to send this as a private message, but I decided that there's 
> quite a bit of background stuff here that many people will find interesting.
 
--
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
