Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81K5erT024274
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 16:05:40 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81K5ceu016215
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 20:05:38 GMT
Date: Wed, 1 Sep 2004 18:25:51 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Scott James Remnant <scott@netsplit.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>,
   Dpkg Development <debian-dpkg@lists.debian.org>,
   Debian Developers <debian-devel@lists.debian.org>
Subject: Re: dpkg and selinux
Message-ID: <20040901172551.GC4400@lkcl.net>
References: <20040831234115.GZ4375@lkcl.net> <1094004762.6901.68.camel@descent.netsplit.com> <20040901101921.GC5882@lkcl.net> <1094045403.6901.112.camel@descent.netsplit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094045403.6901.112.camel@descent.netsplit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 01, 2004 at 02:30:03PM +0100, Scott James Remnant wrote:
> On Wed, 2004-09-01 at 11:19 +0100, Luke Kenneth Casson Leighton wrote:
> 
> > On Wed, Sep 01, 2004 at 03:12:42AM +0100, Scott James Remnant wrote:
> > > On Wed, 2004-09-01 at 00:41 +0100, Luke Kenneth Casson Leighton wrote:
> > > 
> > > > the way that russell's "postinst.d" patch works is that for every
> > > > package, exactly at the end of its postinst script, the scripts in
> > > > postinst.d are run - with the name of the package as an argument.
> > 
> So we've ascertained that this statement was wrong and that Russell's
> patch actually runs postinst.d scripts *before* the package's postinst
> script.
 	
	that is my mistake: i had not analysed russell's code.

	for a dpkg function beginning with "pre", it's run at the end;
	for a dpkg function beginning with "post" e.g. postinst,
	it's run at the beginning.

	[selinux doesn't need a pre* thing btw.]


> > the analogy is to imagine that chmod, chgrp and chown were a new
> > concept that had to be retrofitted onto a system where the default
> > permissions were noaccess, noaccess, 0000, with no members in the
> > group "noaccess".
> > 
> It's an interesting one, certainly I'd suggest the right solution would
> be to do such commands in postinst until such time as it was the default
> and the tar format could carry this information.  It would then become
> policy that it would be carried inside the tar file, just as chmod/
> chgrp/chown are carried today.
> 
> > you'd have to specify a file with unix_contexts in it which
> > had:
> > 
> >  	/bin(/.*)?		root,root,0755
> > 	/bin/ping		root,root,1755 (...or is it 3755 for setuid?)
> > 
> > etc, with THOUSANDS of entries...
> > 
> The thing that worries me about this file is that it contains policy for
> things I don't have installed on my system; 

 ah.  that's not _quite_ true: that's been catered for already.

 the file_contexts file is dynamically generated from what
 selinux policy files the site administrator decides to
 "enable".

 the site administrator must make a decision on what parts of the
 policy files are to be installed.

 i spend 10 minutes a month ago removing the selinux policy files
 for oh, gawd, tinydns, apache, openca, sendmail, and a whole stack
 of other things.

 it's good practice to do this: i just hadn't got round to it.

 in this way, an attacker can't go and install a package on your
 system and have it work, because the binaries will end up with
 no permissions to run correctly.



> and doesn't seem to cope
> well with differing policy for (e.g.) two binaries called 'ssh' which
> may have different requirements.

 that _is_ true - sort-of.

 under such circumstances, the site administrator would need to decide
 which of the 

 if someone installs dropbear rather than openssh, and someone has
 never written an selinux policy for dropbear before, then they would
 have to write one - and install it.


> SELinux's seems to suffer the same problem, it assumes what you have
> installed on your system.

 welllll... not quite: it's just that there's no automated system in
 place (yet) to make any such assumptions, such that it is necessary
 for the site administrator to _manually_ go through the set of
 160 policy packages, deciding which ones to activate and which ones
 to deactivate.

 russell _has_ been putting "X-Debian-Packages: xdm, kdm, gdm, wdm"
 into the tops of e.g. the domains/programs/xdm.te policy file,
 presumably so that in the future an automated decision can be made.

> Ordinary system administrators don't want this file, they want a
> sensible chown/chgrp/chmod setup when they install packages -- how many
> of our users really use dpkg-statoverride?
> 
> > it might not actually be the case... but the example you give below
> > tends to suggest that it might be worse than suspected, and
> > that the source code of dpkg might need to be patched instead,
> > in the same way that rpm has been patched (and cron, and ssh,
> > and udev)
> > 
> Indeed, I'm leaning towards agreeing with you.  The postinst solution
> has always smelled of rotten fish, it needs to be done properly --
> either inside dpkg or inside the package postinsts.

 inside dpkg it has to be then, because literally every postinst
 would need to ask for its file contexts to be redone.


> However I'm loath to embed specific selinux support into dpkg if it
> introduces extra dependencies, or causes problems for those not using
> it.
 
 1) fortunately, the only extra dependency will be libselinux1 which
    needs to be made "Required" such that cron, coreutils, logrotate,
	ssh etc. can use it.

 2) fortunately, the problem you mention has been catered for: there's
    a run-time callable function in libselinux1 called
	"is_selinux_enabled()".


> > am i correct in thinking that the tarobject function is responsible
> > for doing the dpkg unpacking?
> > 
> Vaguely, files are unpacked in a temporary place then moved into the
> right place (inside process_archive).

 okay, then that means that:

 1a) the unpack in the temporary place needs to be done as if the file
    was to go into the root.

 1b) the move needs to be handled carefully to ensure that the
    selinux permissions are preserved

 OR:

 2) the linux kernel could be "prepped" by the functions in libselinux
     such that the correct file contexts be applied at move time (i think!)


 from a coding point of view, i believe it'd be easier to go with 1)
 because you have the information available inside tarobject() about
 whether the thing being unpacked is a file, directory or symlink.

 that is important to know because it can be used to reduce the amount
 of work that libselinux needs to do on the regexp lookups in
 /etc/selinux/contexts/file_contexts.


> > > If it's really true, isn't it going to be also true that sometimes you
> > > need to do the selinux processing before certain actions in the postinst
> > > (like starting the daemon) are performed?
> >  
> > ... you know, i think you could be right.
> > 
> I knew I wasn't crazy :o)

 :)

> > i think only stephen, russell, dan or colin are in a position to
> > answer that.
> > 
> Sadly they've stopped answering my calls <g>

 :)  i think they left it up to me, and by examining russell's patch
 i think i worked it out.

> Actually that was irony, I could try for sarcasm if you like <g>
 
 *lol*

> > okay... an analogy that may help you to understand: how many versions
> > of the debian policy document are there?
> > there's only one, isn't there?  everyone stick to it (hmmm, please
> > don't correct me if that's wrong :)
> > 
> >  ... what if there was more than one debian policy document?
> > 
> >  what if SITE ADMINISTRATORS could decide which debian policy document
> >  should be applied to their system?
> > 
> >  as a concept, it doesn't work, does it?
> > 
> Actually, it rather does.  Site admins could specify where man pages
> went on their system, how shared libraries were installed, etc.

 eek.

> > >    And here we lead on to another fairy-tale story of "classes", a
> > >    feature of Solaris' packaging system I quite admire.  The selinux
> > >    support packages could implement replacement class handling that
> > >    performed the required selinux voodoo as it installed files.
> > > 
> > >    (This is one of my ideas for generic conffile handling, btw.)
> > 
> > ooooo.
> > 
> > well, replacement, no, but "wrapping" yes.
> > 
> > in other words, the selinux support packaging system would run and then be
> > responsible for calling the "default" packaging system.
> > 
> Yeah.  The basic theory of a class is that it's a function responsible
> for taking an unpacked item (if it exists) and placing it on the
 
 [...]

> SELinux could replace the default class handler with one that applied
> contexts after the default was run.
> 
> But as I said, this is fairy-land at the moment -- it's a feature of
> Solaris' packaging system I admire, and would certainly make some of the
> code more generic and less twisty.
 
 [time to deal with getting from here to there with the least amount of
  work...]

> > > Another use case for this "always run" functionality is prelinking
> > > binaries, or updating the updatedb/locate database.
> > 
> > yes.
> > 
> Notably though these are "always run at the end of an installation run",
> so aren't compatible with the stuff you've asked for.

 so, inside dpkg it is, then.

> > > What happens to those files the package's postinst creates?  
> > 
> > > Such as
> > > debconf-maintained configuration files, symlinks, etc.  How do those get
> > > selinux policy?
> > 
> >  to be honest, i don't rightly know.
> > 
> >  _hopefully_ they are mentioned in the dpkg -L <packagename> listing
> >  such that they can be managed.
> > 
> Nope.  Policy, in fact, demands that they aren't mentioned -- files
> written during package maintainer scripts *cannot* be dpkg managed
> conffiles.  (They get into a bit of a fight).

 oh dear.

 well, under most circumstances, i believe that can be catered for
 (with /etc/init.d/xfs creating /tmp/.font-unix being a notable
  exception).

 one particular way is that selinux has the equivalent of an
 enhanced setgid for directories (known as file_auto_trans).

 so, as long as a package has all its config files, temp files,
 run files in its own directory (e.g. /etc/cups, /var/state/cups,
 /var/run/cups) then it's possible to say, with a file_auto_trans
 statement, "if the cups daemon creates a file in the directory
 /var/spool/cups, then give it _these_ permissions".

 unfortunately you can't get any more fine-grained than that without
 actually embedding libselinux code into, say, cups.

 but fortunately, for _most_ purposes, this is sufficient.

 it's typically the packages that disobey the Debian Policy
 (or is it FHS policy) about creating per-package directories in
 /etc, /var/run, /var/spool, /var/tmp that have the problems
 (like /tmp/.font-unix)


 anyway.

 more later.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
