Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4ECNuRb010616
	for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 08:23:56 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4ECLXRA008880
	for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 12:21:33 GMT
Received: from abyss.simplyaquatics.com (abyss.simplyaquatics.com [69.44.152.139])
	by jazzswing.ncsc.mil  with ESMTP id i4ECLXjN008875
	for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 12:21:33 GMT
From: "Ed Street" <edstreet@street-tek.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Cc: "'Selinux'" <selinux@tycho.nsa.gov>
Subject: RE: Suse
Date: Fri, 14 May 2004 08:23:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <1084537198.17741.30.camel@moss-spartans.epoch.ncsc.mil>
Message-Id: <20040514122351.2D9FE3A404F@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Suse 9.1 uses kernel 2.6 and I'm thinking the 9.0 stuff would be very dated.
The better option may be going with the upstream or the fedora srpm.

Ed

-----Original Message-----
From: Stephen Smalley [mailto:sds@epoch.ncsc.mil] 
Sent: Friday, May 14, 2004 8:20 AM
To: Ed Street
Cc: 'Selinux'
Subject: Re: Suse

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

---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.677 / Virus Database: 439 - Release Date: 5/4/2004
 

---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.677 / Virus Database: 439 - Release Date: 5/4/2004
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
