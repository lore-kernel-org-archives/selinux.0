Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81A8MrT019611
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 06:08:22 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81A8Feu024613
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 10:08:19 GMT
Date: Wed, 1 Sep 2004 11:19:21 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Scott James Remnant <scott@netsplit.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>,
   Dpkg Development <debian-dpkg@lists.debian.org>,
   Debian Developers <debian-devel@lists.debian.org>
Subject: Re: dpkg and selinux
Message-ID: <20040901101921.GC5882@lkcl.net>
References: <20040831234115.GZ4375@lkcl.net> <1094004762.6901.68.camel@descent.netsplit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094004762.6901.68.camel@descent.netsplit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 01, 2004 at 03:12:42AM +0100, Scott James Remnant wrote:
> On Wed, 2004-09-01 at 00:41 +0100, Luke Kenneth Casson Leighton wrote:
> 
> > the way that russell's "postinst.d" patch works is that for every
> > package, exactly at the end of its postinst script, the scripts in
> > postinst.d are run - with the name of the package as an argument.
> > 
> > this is subtly different from dpkg triggers, and the differences are
> > due to the different requirements of selinux.  YES it is necessary
> > to run the selinux postinst.d script on EVERY package.  YES it
> > is necessary to run it after every package's postinst script.
> > 
> This is the bit I still have trouble believing; 

 i really can't help you with what you believe.

 i know you do: it's why i keep repeating it in the hope that i can
 help.

 your difficulty in believing it isn't going to make any difference
 in affecting whether it's actually true or not.

 it's quite simple:
 
	any file or directory created by dpkg as it unpacks
	the package needs to have its selinux permissions
	"retrofitted", as laid down by a SITE ADMINISTRATOR's
	decision on what version and what type of policy to use.
	
	the decision made by the site administrator (not by the
	package maintainer and not by the NSA!) results in the
	generation of a "file contexts" file,
	/etc/selinux/contexts/file_contexts.

	that file contains "the equivalent" of chmod+chown+chgrp,
	with regexps to match the files+directories+symlinks that
	that equivalent of chmod+chown+chgrp should be applied to.

	e.g. i am running a "strict" policy, version 1.14 with
	some custom modifications, so i have, as an example,
	these:

	/bin(/.*)?                      system_u:object_r:bin_t
	/bin/tcsh               --      system_u:object_r:shell_exec_t
	/bin/ls                 --      system_u:object_r:ls_exec_t

	which means "everything in /bin (and including /bin the directory)
	except /bin/tcsh and /bin/ls get the file context 'bin_t".
	
	and:

	/etc(/.*)?                      system_u:object_r:etc_t
	/etc/mtab               --      system_u:object_r:etc_runtime_t

	where etc_t is typically kept read-only to most programs,
	and files of type etc_runtime_t are typically allowed to be
	be written to by certain programs that need to (init scripts,
	dpkg etc).
	


 ... i wrote you a detailed message last night, in which i
 outlined an analogy.

 the analogy is to imagine that chmod, chgrp and chown were a new
 concept that had to be retrofitted onto a system where the default
 permissions were noaccess, noaccess, 0000, with no members in the
 group "noaccess".

 there would not be a chance in hell of being able to "retrofit"
 chmod, chgrp and chown into postinst scripts: package maintainers
 would bitch like mad, and not understand it, and it would be
 unreasonable to expect them to understand it (think of retro
 converting 30 years of FAT filesystem usage to ext2!)

 and it would almost undoubtedly be expected that every file and
 directory created would need to be chmodded, chowned and chgrp'd,
 as a package was installed.

 you'd have to specify a file with unix_contexts in it which
 had:

 	/bin(/.*)?		root,root,0755
	/bin/ping		root,root,1755 (...or is it 3755 for setuid?)

 etc, with THOUSANDS of entries...
 
 ... just like there are in /etc/selinux/contexts/file_contexts
 (5972 lines in the case of my modified 1.14 policy)

 the scope and scale of the task and achievement of selinux is
 just... mind-boggling.

 it's just... so ambitious!! *gibber*.  retro-fitting a security
 model onto linux.  madness!

 ahem.  sorry.  calm, calm.


> I could claim that it is
> necessary for ldconfig or scrollkeeper-update to run on EVERY page...
> but that's just not true.
 
 and i can see for myself that it's not true.



> Why is it necessary for the selinux update to complete before the
> processing of the next package is begun?

 this is what i am not sure about.

 it might not actually be the case... but the example you give below
 tends to suggest that it might be worse than suspected, and
 that the source code of dpkg might need to be patched instead,
 in the same way that rpm has been patched (and cron, and ssh,
 and udev)

 namely, that there are some libselinux functions that can be used
 to ensure that at file/dir CREATE time the correct selinux permissions
 will be applied, on a per-file, per-directory basis.

 the /etc/dpkg/postinst.d/selinux approach is the quickest and simplest
 way to achieve the desired results...

 ... it might be the case that there are flaws in it that will
 _require_ modifications to dpkg...  looking at the code,
 main.c around lines 529 etc. in the tarobject function.

 am i correct in thinking that the tarobject function is responsible
 for doing the dpkg unpacking?

 because if so, that's where the setfscreatecon() function calls to
 libselinux functions would be need to be done (as they are in
 udev, cron, star, and other packages).

 this would result in guaranteed atomic file/dir/symlink create
 operations that the /etc/dpkg/postinst.d/selinux ... "hack" just
 doesn't and can't do.



> If it's really true, isn't it going to be also true that sometimes you
> need to do the selinux processing before certain actions in the postinst
> (like starting the daemon) are performed?
 
 ... you know, i think you could be right.

 i think only stephen, russell, dan or colin are in a position to
 answer that.

 hang on... in russell's postinst patch, what happens first.

 the package is unpacked, the /etc/dpkg/postinst.d/selinux script is
 run, the package's postinst script is run.

 [this is the one that makes sense]

 OR is it:

 the package is unpacked, the package's postinst script
 is run, the /etc/dpkg/postinst.d/selinux script is run.

 [this is the one that would suffer from the problems you outline
  above, scott]
 


> Or does it not matter that the daemon is started before selinux
> privileges/permissions are applied to its binary?

 yes, i think it does.

 _hope_fully russell's patched dpkg does the selinux postinst.d script
 _before_ running the package's postinst script.

 
> If that doesn't matter I don't see why it matters that the processing is
> deferred until the end of the run.

 well i too was hoping that it would be the case: it doesn't look
 like it will be.


> > for example, a few months ago i genuinely believed that
> > it would be a great idea for all package maintainers to be
> > responsible for selinux policy (such that it would be okay to
> > move selinux policy into debian packages): now i know that there
> > are targetted and strict policies, and that writing selinux
> > policy is sufficiently complex and inter-dependent for it to
> > require significant expert knowledge - something that package
> > maintainers DON'T NEED and DON'T even NEED TO KNOW ABOUT.
> > 
> Package maintainers don't need, and don't even need to know about
> debconf templates, translations, debian policy, etc.  Let's separate
> those out into separate packages too!

 i know you mean that in a sarcastic way, i am going to assume
 otherwise by rewriting your statement as i believe it should
 have been asked, pretend that you said that instead, and then
 answer that.

 this is what i believe you to have said, which "softens" the
 impact of what "you" are trying to say into a respectful joke.

> if i understand you correctly, then by the same logic, it could be
> argued that Package maintainers don't need, and don't even need to
> know about debconf templates, translations, debian policy, etc.

> surely, therefore, we should consider separating those out into
> separate packages too!

 *lol* :) not quite.

 okay... an analogy that may help you to understand: how many versions
 of the debian policy document are there?

 there's only one, isn't there?  everyone stick to it (hmmm, please
 don't correct me if that's wrong :)

 ... what if there was more than one debian policy document?

 what if SITE ADMINISTRATORS could decide which debian policy document
 should be applied to their system?

 as a concept, it doesn't work, does it?

 
 a SITE ADMINISTRATOR may decide to:

 - apply the targetted policy, which allows users to do pretty much
   anything (respecting unix perms of course) and it restricts
   services.

 - not apply a policy at all, for testing purposes.

 - apply the "strict" policy, which even stops unauthorised users from
   doing "su -", and even stops administrators from starting and
   stopping services unless they go through a special procedure

 - write, and apply, THEIR OWN policy.

 now, in the case of the latter, you can't seriously be telling
 me that a site administrator's OWN policy files, which they
 have hacked up for a particular package and a particular
 requirement, should go into a debian package?

 and that a debian maintainer must include hundreds, maybe thousands
 of separate administrators' policy files, world-wide?

 it just can't happen.




> > i am endeavouring to either convince him otherwise, or to make
> > some suggestions which would allow the present or an equivalent
> > of the present /etc/dpkg/postinst.d/selinux script running
> > under russell's patched dpkg to successfully be replaced by
> > a dpkg "trigger".
> > 
> I believe triggers really will work for what you want; if they don't
> then here's two problems with postinst.d:
> 
> 1) is there actually another use case for it that isn't solved by
>    triggers?
> 
> 2) if not, then it's a selinux-specific feature and actually worse than
>    simply embedding knowledge of selinux into dpkg.
> 
>    And here we lead on to another fairy-tale story of "classes", a
>    feature of Solaris' packaging system I quite admire.  The selinux
>    support packages could implement replacement class handling that
>    performed the required selinux voodoo as it installed files.
> 
>    (This is one of my ideas for generic conffile handling, btw.)

 ooooo.

 well, replacement, no, but "wrapping" yes.

 in other words, the selinux support packaging system would run and then be
 responsible for calling the "default" packaging system.


> > dpkg "triggers" will ONLY work for selinux under these circumstances,
> > and i REALLY mean "only".
> > 
> > a) if the selinux dpkg "trigger" could guarantee to ALWAYS be run, not
> >    just be called from one or a few packages.  reason: ALL files
> >    installed by ALL packages must have their file contexts revamped,
> >    NOT just some.
> >    
> >    all files, in fact, that are listed by dpkg -L <packagename>
> > 
> Another use case for this "always run" functionality is prelinking
> binaries, or updating the updatedb/locate database.

 yes.

 yes!

 well ... in order to be useful, both those two systems (prelink and
 updatedb) would need to be given a list of files removed and a list of
 files added, and to know what to do with them.

 
> > b) i think i am right in saying that debian "Pre-Depends"
> >    groupings will have to be respected: namely that it would be
> >    necessary AT THE LEAST to have the selinux dpkg "trigger" run
> >    on groups of packages separated at "Pre-Depends" boundaries.
> > 
> Why?
> 
> If there really is this "policy must be in place before FOO" problem,
> surely that (potentially) exists *inside* a single postinst.
 
 okay, looking at russell's patch, it looks like he's been smart
 enough to switch the ordering based on whether it's a pre or post
 script.

 it _looks_ like:

 - on post<something> , all scripts in /etc/dpkg/post<something>.d are run
   BEFORE  the package's post<something> script is run

 - on pre<something>, all scripts in /etc/dpkg/pre<something>.d are
   run AFTER ...


> In which case we're back to changing postinst of every package again
> (which is actually largely just a change-debhelper problem, anyway).

 well, if the same effect can be achieved by doing the equivalent in
 debhelper, then great.


> >    i also believe that i am right in saying that this would 
> >    probably have to be done for all dpkg triggers _anyway_ - NOT
> >    just the proposed selinux dpkg trigger.
> > 
> >    otherwise, you could end up with awful screw-ups where
> >    update-modules might not get run, and a "Pre-Dependent"
> >    package was _really_ relying on a particular module or
> >    module options being set, that sort of thing.
> > 
> You've made the very common mistake of mis-understanding how Pre-Depends
> work, 
 
 i'm happy to be corrected because i need to understand the issues.

> > c) if the dpkg "triggers" could receive the complete list of all package
> > names, then it is conceivable that this list of names could be
> > amalgamated by the dpkg trigger /usr/lib/dpkg/triggers/selinux...
> > something like this:
> > 
> I certainly don't see a problem with this.  We're wandering to classes
> with this behaviour though <g>
 
 yep :)

 all solutions welcome.

> What happens to those files the package's postinst creates?  

> Such as
> debconf-maintained configuration files, symlinks, etc.  How do those get
> selinux policy?

 to be honest, i don't rightly know.

 _hopefully_ they are mentioned in the dpkg -L <packagename> listing
 such that they can be managed.

 i assume that if they're not listed in the dpkg -L <packagename>
 listing that that's a bug in the package, because when the time
 comes for that package to be purged, symlinks would be left behind.

 .... or, is there something that's been missed?

 does dpkg -L not include debconf-maintained configuration files?


> Aren't you going to need to modify the postinst to add policy for them
> too?
> 
> 
> > *1 is there an absolute requirement that the present
> >   /etc/dpkg/postinst.d/selinux script BE RUN at the
> >   end and ONLY IMMEDIATELY AT THE END of EVERY
> >   postinst script of EVERY package being installed?
> > 
> If there is this requirement, I maintain there is probably a requirement
> that it be run before the end of an individual postinst ... requiring
> changes to the postinst.
> 
> Use case:  Mail server, started as per-policy in postinst.
> 
> Do you need to have the selinux policies for its queue and spool
> directories in place before it starts?  

 yes, definitely.

 [see above description of my forays into russell's patch: it's
  dealt with.  hopefully.  mostly.  ]

> If so you need to modify that
> postinst to do the work before the invoke-rc.d call.
> 
> > *2 is it sufficient, is it the case that it's okay, to
> >   just wait until the end of a dpkg run (respecting
> >   "Pre-Depends" groupings of course), to wait until ALL
> >   postinst scripts (of one or more "Pre-Depends" groups
> >   of course) are run and THEN to do the above [proposed]
> >   /usr/lib/dpkg/triggers/selinux script (more than once if there
> >   is more than one "Pre-Depends" grouping of course), receiving
> >   the list of all names of all packages just newly installed
> >   (in each "Pre-Depends" group of course)?
> > 
> I don't believe you need this pre-depends grouping (see above).
> 
> > and if it's _not_ okay, then unfortunately we must continue to insist
> > that dpkg have the postinst.d system.
> > 
> Which would have an entire feature for one particular subset of users,
> leaving that feature open to abuse by the others; which I massively
> dislike.
> 
> > or continue to maintain a fork of dpkg.
> > 
> > or request the ftp masters to accept the creation of an se-dpkg package
> > containing the forked version of dpkg.
> > 
> These are the same thing, and there's no need to involve the ftpmasters.
> I'm reasonably sure that anybody is free to upload competing package
> managers, provided they don't stamp on the dpkg namespace (dpkg.*).
> 
> > my concern with the latter (*2) is that there would be dependency
> > problems due to file contexts not having been updated yet,
> > that are completely avoided by the /etc/dpkg/postinst.d/selinux
> > approach [run just after the package's postinst script is run].
> > 
> Why would there be this problem?

 
> > ... or is the problem i envisage avoided by the selinux domain
> > in which dpkg is run (and by breaking things down into "Pre-Depends"
> > groups).
> > 
> Why do we need to do this breaking-things-into-groups?
> 
> > for those people not familiar with dpkg, "Pre-Depends" is a system which
> > forces a COMPLETE install of all "Pre-Depends" packages prior to
> > proceeding with the installation of a package with a "Pre-Depends"
> > requirement.
> > 
> > if you specify "Depends:" then what you are saying is that
> > dpkg can just run all the unpacks of all packages and all
> > dependencies (in any order), then run all postinsts of all
> > packages and all dependencies (basically in any order it likes).
> > 
> *BZZZT* wrong!
> 
> Utterly, utterly, incorrect my friend.
 
 *lol* :)

> Pre-Depends does require complete installation of a package has been
> performed before the pre-depending package.  This means that the pre-
> depended package will have been unpacked and configured (including
> postinst) before the pre-depending package is even unpacked.

 yes.

 that is what i understood this to be, i just wasn't able to articulate
 it clearly.


> Depends requires that depended packages have been unpacked and
> configured before depending packages are configured.  This means that
> the packages may be unpacked in a reasonably random order, BUT THAT
> CONFIGURATION HAPPENS *IN ORDER* (not "any order it likes").
>

 that i didn't know.  makes sense.

 thanks for responding to this scott: we'll get there, i'm sure.

 i'll write a summary message later, outlining some of the 
 problems you've highlighted.

 (e.g the symlinks-created-in-postinst scripts one)

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
