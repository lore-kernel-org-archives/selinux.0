Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7VNU5rT016824
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 19:30:05 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7VNTFGh003718
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 23:29:16 GMT
Date: Wed, 1 Sep 2004 00:41:15 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Cc: debian-dpkg@lists.debian.org, debian-devel@lists.debian.org
Subject: dpkg and selinux
Message-ID: <20040831234115.GZ4375@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i've just heard from scott remnant who kindly responded with a
description of how he envisages debian's "triggers" system to work.

*deep breath*.

for those people involved with this issue, i really must say this:

- please read this message carefully.
- please read all of it.
- if you don't understand, please ask for clarification.
- please, if you haven't the time to respect the above requests,
  please don't reply to any discussions on this issue until you
  can.
  
  i've gone to a lot of trouble to understand and then outline
  the issues involved (my thanks to scott for explaining
  "triggers"), and i really don't want to get into discussions
  with people who may not know what those issues are, and how
  they impact debian-selinux systems.

please respect these requests.

please also if you spot any errors in what i have outlined here,
in the descriptions, logic, reasoning or conclusions, please don't
sit there like a bloody lemon assuming that i know it all and am
so far up my own bottom that i won't appreciate being corrected:
far from it - i _need_ this issue to be resolved, so that it will
minimise _my_ efforts in having to maintain a linux distro.

the quicker it's resolved, the happier i will be, and the less often
i will have to write about this issue.

SO HELP - DON'T HINDER.

onward.


as i understand it, the debian "trigger" system is designed to
optimise, over a series of installations of multiple packages,
the number of calls to:

- ldconfig
- scrollkeeper-update
- update-menus
- update-modules
- update-modules.modutils

etc.

as an example, 80% of all debian postinst (post install) packages
on my computer result in the running of update-menus.

given that all these scripts do the same thing it's an O(N*M) overkill
problem that the proposed "trigger" system would alleviate to an
O(N) problem.

the proposed "trigger" system would replace all instances of ldconfig
in all debian postinst scripts with dpkg-trigger ldconfig, all instances
of scrollkeeper-update with dpkg-trigger scrollkeeper-update.

etc.

at the end of the dpkg run [of installing multiple programs] then the
"triggers" would be activated.

if a postinst script ABSOLUTELY HAD to run a trigger THERE AND THEN,
then there is a special proposed "dpkg-trigger-right-now" program
which does the trigger there-and-then (and presumably clears the
cache so that it's not re-run at the end of the dpkg run).


the way that russell's "postinst.d" patch works is that for every
package, exactly at the end of its postinst script, the scripts in
postinst.d are run - with the name of the package as an argument.

this is subtly different from dpkg triggers, and the differences are
due to the different requirements of selinux.  YES it is necessary
to run the selinux postinst.d script on EVERY package.  YES it
is necessary to run it after every package's postinst script.

[it MIGHT be possible to postpone / delay the running of the
 selinux postinst.d script, which is why i am going to the trouble
 of writing this message: see later for more explanation ]


unfortunately, people unfamiliar with selinux don't quite
believe or understand quite how much is involved, and it differs
in subtle ways that the proposed dpkg "trigger" system as it
stands doesn't...  _quite_ fulfil.

for example, a few months ago i genuinely believed that
it would be a great idea for all package maintainers to be
responsible for selinux policy (such that it would be okay to
move selinux policy into debian packages): now i know that there
are targetted and strict policies, and that writing selinux
policy is sufficiently complex and inter-dependent for it to
require significant expert knowledge - something that package
maintainers DON'T NEED and DON'T even NEED TO KNOW ABOUT.

also, that the differences between policies for redhat, suse,
gentoo and debian are pretty minimal... but there _are_ differences,
and it's unmaintainable madness to have the policy files in
different places.


scott - and presumably the other debian package maintainers
who couldn't, unlike scott kindly did, find the time to inform
the selinux community nor refer the selinux community to any
documentation on this subject - believes that dpkg "triggers"
are sufficient for selinux's use.

i am endeavouring to either convince him otherwise, or to make
some suggestions which would allow the present or an equivalent
of the present /etc/dpkg/postinst.d/selinux script running
under russell's patched dpkg to successfully be replaced by
a dpkg "trigger".

dpkg "triggers" will ONLY work for selinux under these circumstances,
and i REALLY mean "only".

a) if the selinux dpkg "trigger" could guarantee to ALWAYS be run, not
   just be called from one or a few packages.  reason: ALL files
   installed by ALL packages must have their file contexts revamped,
   NOT just some.
   
   all files, in fact, that are listed by dpkg -L <packagename>

b) i think i am right in saying that debian "Pre-Depends"
   groupings will have to be respected: namely that it would be
   necessary AT THE LEAST to have the selinux dpkg "trigger" run
   on groups of packages separated at "Pre-Depends" boundaries.

   i also believe that i am right in saying that this would 
   probably have to be done for all dpkg triggers _anyway_ - NOT
   just the proposed selinux dpkg trigger.

   otherwise, you could end up with awful screw-ups where
   update-modules might not get run, and a "Pre-Dependent"
   package was _really_ relying on a particular module or
   module options being set, that sort of thing.

   or, scrollkeeper-update might not get run, such
   that a "Pre-Dependent" package which really needed
   scrollkeeper-update to succeed prior to moving on.... you
   get the picture.

c) if the dpkg "triggers" could receive the complete list of all package
names, then it is conceivable that this list of names could be
amalgamated by the dpkg trigger /usr/lib/dpkg/triggers/selinux...
something like this:

	#!/bin/sh
	#
	# receive list of package names, merge all file in all
	# said packages, run setfile on all said files.
	# blah.


	filelist=""
	for x in $*
	do
		filelist="$filelist `dpkg -L $x`"
	done

	filelist="echo $filelist | sort | uniq"

	echo $filelist | setfiles -q -s /etc/selinux/contexts/file_contexts

i realise that this is crap shellscript, i don't care, it demonstrates
the principle, namely that it merges the list of all files and
directories of all packages installed in a dpkg run, sorts them, uniques
them, and then jums then into setfiles.

this is about as optimal as it could get...

... the question is: is it enough?

what i mean is:

*1 is there an absolute requirement that the present
  /etc/dpkg/postinst.d/selinux script BE RUN at the
  end and ONLY IMMEDIATELY AT THE END of EVERY
  postinst script of EVERY package being installed?

or:

*2 is it sufficient, is it the case that it's okay, to
  just wait until the end of a dpkg run (respecting
  "Pre-Depends" groupings of course), to wait until ALL
  postinst scripts (of one or more "Pre-Depends" groups
  of course) are run and THEN to do the above [proposed]
  /usr/lib/dpkg/triggers/selinux script (more than once if there
  is more than one "Pre-Depends" grouping of course), receiving
  the list of all names of all packages just newly installed
  (in each "Pre-Depends" group of course)?

because if the latter, then as long as the proposed dpkg
"trigger" system _does_ pass the list of all package names, and
as long as the new dpkg "trigger" system _can_ be made to run
the selinux trigger _irrespective_ of whether a postinst script
asked for it to be run (in fact if a postinst script _does_
ask it to be run except via "dpkg-trigger-right-now selinux",
then an error should be raised!) then everything's hunky-dory.

and if it's _not_ okay, then unfortunately we must continue to insist
that dpkg have the postinst.d system.

or continue to maintain a fork of dpkg.

or request the ftp masters to accept the creation of an se-dpkg package
containing the forked version of dpkg.


my concern with the latter (*2) is that there would be dependency
problems due to file contexts not having been updated yet,
that are completely avoided by the /etc/dpkg/postinst.d/selinux
approach [run just after the package's postinst script is run].

... or is the problem i envisage avoided by the selinux domain
in which dpkg is run (and by breaking things down into "Pre-Depends"
groups).

this last bit is probably something that only russell, stephen,
dan and colin are likely to be able to answer: the interactions
and workings of the dpkg policy and its impact on how dpkg
operates is something that requires their expert knowledge.

l.

p.s. 

for those people not familiar with dpkg, "Pre-Depends" is a system which
forces a COMPLETE install of all "Pre-Depends" packages prior to
proceeding with the installation of a package with a "Pre-Depends"
requirement.

if you specify "Depends:" then what you are saying is that
dpkg can just run all the unpacks of all packages and all
dependencies (in any order), then run all postinsts of all
packages and all dependencies (basically in any order it likes).

this solves the issues of accidental circular dependencies by totally
avoiding the problem :)

"Pre-Depends" is the only way in which accidental circular dependencies
can have serious "broken debian system" consequences.

you so totally can't have circular "Pre-Depends" but you _can_ have two
packages "Depend" on _each other_: of course, you need to ensure that
the postinst scripts of the inter-dependent cross-"Dependent" packages
are _really_ okay with that, such that it doesn't matter what order
their postinst scripts are run in.

my concern with selinux is that if the file contexts haven't been set
up yet under such circumstances... well, you can imagine what might
happen: you end up with "access denied" errors to files and directories
that haven't had their permissions correctly set...


-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
