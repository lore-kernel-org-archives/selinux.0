Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KFPvrT004771
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 11:25:58 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KFPG4v015416
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 15:25:16 GMT
Subject: Re: conflict between libselinux and libsepol
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1093013527.9495.0.camel@nexus.verbum.private>
References: <1092942083.1721.101.camel@moss-spartans.epoch.ncsc.mil>
	 <1092972342.29540.35.camel@nexus.verbum.private>
	 <1093002523.16585.31.camel@moss-spartans.epoch.ncsc.mil>
	 <1093013527.9495.0.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1093015484.16585.199.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 20 Aug 2004 11:24:44 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-20 at 10:52, Colin Walters wrote:
> Well, one problem we ran into yesterday is that the content of
> file_contexts is not easily verified to ensure there are no undefined
> types.  During an installation, setfiles would abort after 10 errors by
> default.  What we want to do is verify the content during a policy
> package build, to ensure this doesn't happen again.
> 
> I'm attaching my (obviously untested) patch to setfiles, I think it will
> work once sepol is fixed.

The shared libsepol only exports interfaces listed in libsepol.map (and
declared by convention in sepol/sepol.h), presently just the genbools
functions.  The static libsepol library exports all global symbols.  I
envision two very different classes of consumers of libsepol:

- Programs like checkpolicy that are tightly coupled to the binary
policy internals.  Such programs will need to change for any nontrivial
changes to the binary policy internals.  A stable library ABI for such
programs would be rather difficult to provide and maintain, so they must
link with the static libsepol.

- Programs like load_policy (and setfiles, in your example) that only
need simple interfaces for abstract binary policy queries or transforms,
like the genbools transforms or a context validation query.  We can
provide a stable ABI for such programs, so they can use the shared
libsepol.

Hence, I would recommend that we add a function to libsepol to provide a
higher level interface for context validation against a given binary
policy, add it to libsepol.map, and declare the prototype in sepol.h for
use by setfiles.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
