Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4ECK7Rb010580
	for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 08:20:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4ECK5Mi006135
	for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 12:20:05 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4ECK4pI006132 for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 12:20:04 GMT
Subject: Re: Suse
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ed Street <edstreet@street-tek.com>
Cc: "'Selinux'" <selinux@tycho.nsa.gov>
In-Reply-To: <20040513225342.DC3833A404F@abyss.simplyaquatics.com>
References: <20040513225342.DC3833A404F@abyss.simplyaquatics.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1084537198.17741.30.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 14 May 2004 08:19:58 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-05-13 at 18:53, Ed Street wrote:
> I received my suse 9.1 cd’s in the mail today and was wondering if we
> have anyone working on this distro.

Thomas Bleher has SELinux packages for SuSE 9.0, so they are likely a
good starting point: http://www.cip.ifi.lmu.de/~bleher/selinux/suse/
You may want to just use our upstream .tgz files or the Fedora SRPMs for
the main SELinux packages (checkpolicy, libselinux, policycoreutils,
policy) to get our latest code, and just use his packages for the
patched userland.

Note that I've changed the URL for SuSE SELinux packages in the
selinux-doc README to this location, as his packages seem to be more
up-to-date than the ones provided earlier by Paul Dwerryhouse
(http://leapster.org/linux/selinux/suse/) and Carsten Grohmann is no
longer maintaining SELinux packages for SuSE.  The selinux-doc README
includes URLs for SELinux packages for the various distros that I know
of, i.e. Debian, Fedora Core, Gentoo, and SuSE.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
