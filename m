Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4IUFXZ025553
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 13:30:17 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA4ISrCH014491
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 18:28:53 GMT
Subject: Re: Updated SELinux Release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Colin Walters <walters@verbum.org>,
   Manoj Srivastava <manoj.srivastava@stdc.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1099592751.5414.22.camel@selinux>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
	 <87vfcmqvi5.fsf@glaurung.internal.golden-gryphon.com>
	 <1099539462.5018.2.camel@nexus.verbum.private>
	 <1099575525.3174.7.camel@moss-spartans.epoch.ncsc.mil>
	 <1099592751.5414.22.camel@selinux>
Content-Type: text/plain
Message-Id: <1099592755.3174.172.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 04 Nov 2004 13:25:55 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-11-04 at 13:25, Christopher J. PeBenito wrote:
> Well in this case, I believe these changes were because of the MLS
> compile failures I had.  When the code was originally moved over to
> libsepol from checkpolicy, the MLS functions weren't switched over from
> the global policydb to the policydb pointer in the function call.  So
> really, this fixes the broken API.

Right, the change corresponds with the patch I posted to the list in
response to those compilation failures for the optional MLS code
(disabled by default).  But they don't affect the shared library API/ABI
at all even with MLS enabled, because it doesn't export these
functions.  The shared library only exports the symbols marked global in
libsepol/src/libsepol.map.  Everything else is only exported by the
static library.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
