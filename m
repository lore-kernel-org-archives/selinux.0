Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5DFdZrT013937
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 11:39:35 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i5DFdWkj026166
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 11:39:32 -0400 (EDT)
Date: Sun, 13 Jun 2004 15:36:48 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: debian-devel@lists.debian.org, SE-Linux <selinux@tycho.nsa.gov>,
   debian-user@lists.debian.org
Subject: [SE/Linux] status / progress report 13jun2004
Message-ID: <20040613153648.GB26207@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a status / progress report for Debian / SE/Linux integration.
I look forward to the day when it need no longer be maintained,
which will be when all of the outstanding issues have been addressed.

The constant work-in-progress version of this report will always be
available from:

	http://hands.com/~lkcl/selinux


The major outstanding issues are:

* debian kernels need to be available compiled with se/linux security
  enabled (and boot-time optional) by default.  this results in a
  2% performance hit (wow big deal) when se/linux is not enabled
  at boot time.  Gentoo, SuSE and Fedora all accept this 2%.

* sarge freeze is holding back libselinux1 from being made "Required"
  which is holding pretty much evveerrything up, but there is a
  temporary idea (do a package se-<pkgname>) as a workaround.

* a decision needs to be made on dpkg either to accept the postinst.d
  idea or come up with a workable alternative.  decision appears to
  be held up because people "don't like the idea of selinux" rather
  than for any genuine technical reason.

  "alternative" patched dpkg package that provide the postinst.d
  functionality will be made available "ad infinitum" until a
  decision is made.

  ... how about an se-dpkg?  maybe the se_apt-get, se_dpkg,
  se_dpkg-reconfigure scripts could be moved into it, at the
  same time?

* the idea of using a pam_selinux.so for everything has been disrupted
  slightly for certain packages such as kdm, openssh, because the
  ordering of opening ttys and calling the pam session stuff tends
  to be moved about by upstream developers - without consideration
  as to the impact it will have.  pre-pam_selinux patches (esp. for
  openssh) have been "dusted off".

* pam seems to have "lost the plot" a bit and serious consideration
  is being given to doing a fork for BOTH redhat AND debian.

  [the debian pam maintainer has a staggering FIFTY upstream
   patches in debian/patches/ for 0.77.  he's prepared to accept
   ANOTHER patch to add to the list, for selinux, but only
   against latest cvs - 0.78 or above.  redhat also have to
   maintain their own patches - against 0.76 - which includes
   bug fixes that aren't in the "alternative" debian packages
   yet, and it's all just going pear-shaped]



packaging:

	* "alternative" unstable packages (which had had to be patched,
	  see individual status reports below) for:

		coreutils, cron, dpkg, init, kern, logrotate and pam 
	
	 are all available from http://selinux.lemuria.org/newselinux
	 (or from the original http://www.coker.com.au/newselinux)

	* "standard", or "default" packages for unstable (sid)
	
		selinux-policy-default, selinux-utils, libselinux1,
		checkpolicy, policycoreutils and selinux-doc
	
	  are available from the debian mirrors - current versioning
	  is 1.12-2 to 1.12-3 of these packages.

NSA/SELinux kernel 2.6:

	http://www.nsa.gov/selinux/code/download5.cfm
	http://sf.net/projects/selinux/ (see cvs).

	status: most of the selinux enhancements are available
	        upstream in 2.6, however the very latest patches
			are only available from the above sites.

debian:

	http://lists.debian.org/debian-devel/2004/05/msg01738.html

	status: presently, base packages are frozen and no modifications
	        or additional packages are allowed (to base).  this
			affects libselinux1 status from being changed, and therefore
			pretty much everything else from thereon down.

			temporary measure idea for maintainers is to produce
			"se-pkgname" which will later on be an empty package
			depending on "pkgname".

debian kernel 2.6 images:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=249510
	http://open.hands.com/~lkcl/selinux

	status: raised only 12 days ago.  requested that se/linux
		    security config options be enabled in stock
		    Debian kernels but require selinux=1 and enforcing=1
			to switch it on.

coreutils:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193328

	status: 1 year old, requested information, information now
	        provided, upstream and maintainer prodded for
			acknowledgement.  [30may2004] mike stone responded 
			by saying that it's unlikely that action will be taken
			until after sarge is released.

logrotate:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=224880

	status: russell alerted maintainer that upstream inclusion
	        is done (157 days ago) but debian package 3.7-1
			disables it by default due to libselinux1 not being
			"base/required" or "important".  change made to
			libselinux1 to reflect that.
			
			[30may2004] paul martin confirmed that he is waiting
			for this change, and the "ftpmasters" need to make
			the decision.

			13jun2004: pinged paul suggesting the se-<pkgname>
			idea.

cron:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644

	i think this one's my favourite.

	status: 1 year old. bit of a wing-ding and misunderstanding
	        over a field name, fortunately the maintainer stood
			his ground until the non-cron-code-experts understood
			the issues.  updated patch sent.
			31may2004: steve (maintainer) evaluating patch.  also
			steve aware of sarge freeze and implications.
			8jun2004:  bug found in cron which was accidentally
			fixed in selinux version.  steve (maintainer) now
			happy.  to check / confirm latest patch with sds (nsa) 
			8jun2004: steve to create a cron and se-cron package
			where se-cron will be a dummy package when sarge
			is released (and libselinux1 goes to "Required").

			10jun2004: dan walters created new patch, with some
			additional cleanups etc. sent to steve (maintainer)

pam:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=249499
	http://www.redhat.com/archives/pam-list/2004-May/msg00058.html

	status: amazingly, only 19 days old.  unless there's an
	        earlier one and it's already been integrated
			upstream.  changes are only to pam_unix, apparently,
			on that one (and there's another patch for pam_selinux).
	        information sought from upstream and from the
			maintainer.
			30may2004: several messages to upstream explaining
			that pam_selinux.so is needed upstream before
			other packages can start putting
			"session required pam_selinux.so" into upstream
			as well.
			30may2004: subscribed direct to list to avoid
			moderation and wrote message explaining situation
			(pam upstream acceptance or lack of equals major
			 hold-up).
			1jun2004: issue with packages opening and closing
			sessions, plus upstream packages moving the place
			where pam is called from (e.g. openssh) causing
			tty problems.  serious consideration being given
			to reinvoking / dusting-off the selinux patches that
			pam_selinux was supposed to do away with, on the
			basis that upstream authors are less likely to
			interfere with the ordering of "#ifdef WITH_SELINUX"
			than they are with moving calls to pam_open_session.

			8jun2004: situation with pam is bad: no communication
			whatsoever received from upstream.  bugs in 0.76 fixed
			for fedora, too much work to back-port.  serious
			consideration being given to forking pam.  debian
			maintainer happy to accept patch against latest sf.net
			cvs (0.78 or above)

dpkg:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=249496
	http://lists.debian.org/debian-dpkg/2002/03/msg00154.html
	http://lists.debian.org/debian-devel/2002/03/msg02063.html
	http://lists.debian.org/debian-dpkg/2004/05/msg00255.html
	http://lists.debian.org/debian-devel/2004/06/msg00698.html

	status: mr russell coker's postinst.d patch is apparently
	        well-known and the bugreport has been merged with
			other bugs, one of which (#17243) dates back to
			1998! kuudosss.  however, the maintainer says that
			those bugs are part of a larger picture of
			required / requested functionality and they don't
			want to proceed with what would turn out to be a
			temporary measure.

			30may2004: after evaluating options (see links
			above) initiated thread to convince dpkg
			developers to incorporate postinst.d patch.

			13jun2004: no response yet received, another ping
			initiated.

init:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=242900

	status: raised 50 days ago.  seeking information from
	        debian maintainer.

			13jun2004 contact.  advised maintainer of
			se-cron idea pending sarge unfreeze, suggested
			doing an se-init (se-sysvinit), temporarily.

openssh:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193664

	status: 30may2004 - russell's explained that this patch is no
	        longer needed because the patches to PAM deal with
			this, now.

			8jun2004 - serious consideration being given to
			requesting the (retired) openssh WITH_SELINUX
			patch be added due to calls to pam_open_session
			having been moved to before ttys are set up
			(in sshd).  it's all gone pear-shaped.

			10jun2004: investigation by dan and russell leads
			to a decision to reintroduce the former openssh patch,
			the one that didn't need pam_selinux, and to drop
			pam_selinux in openssh.


star, procps, util-linux, shadow, vixie-cron:

	status: although patches are available from
	        http://www.nsa.gov/selinux/code/download5.cfm, 
	        no bug-report or integration into debian/selinux have
	        been initiated for these packages.

	colin walters does have debian packages available
	(mirrored at http://selinux.lemuria.org/walters)

login:

	status: what used to be a patch in login can be achieved
	        equally well with pam_selinux.so session.

	TODO: must write patch for kdm's /etc/pam.d/kdm to have
	        pam_selinux.so session required

kdm:

	status: patch created to do context switch but due to the
	        design of kdm's backend the use of pam_selinux.so
			session achieves the same goal, making patching kdm
			unnecessary.
			
	TODO: must write patch for kdm's /etc/pam.d/kdm to have
	        pam_selinux.so session required


wdm:

	status: patch created but not yet accepted upstream.  code
	        in wdm needs to be evaluated to see if pam_selinux.so
			session will do the same job.

gdm:

	status: patch accepted upstream to do session management.
	        it was essential in gdm that this be done because
			the process doing authentication is separated from
			the process doing the program running: pam_selinux.so
			session would therefore be insufficient [without a
			rewrite of gdm?]

xdm:

	status: not known [to me].

libselinux:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=251749

	status: still at priority "optional".  30may2004 message sent
	        to debian-devel requesting assistance in alerting
			the "ftpmasters" to the issue.  response: russell
			should have received a notification because ftp.debian.org
			automatically "overrides" the priority.

postfix:

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=253732

	status: the postfix policy requires that you disable chrooting
	        in order for postfix to work.  253732 is a wish-list
			requesting an extra dpkg config question advising people
			to select "no i do not want to chroot" if they are
			installing on an se/linux system.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
