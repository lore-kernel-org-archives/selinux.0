Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4ECYXRb010681
	for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 08:34:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4ECWARA009598
	for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 12:32:10 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4ECWAjN009595
	for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 12:32:10 GMT
Subject: RE: Suse
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ed Street <edstreet@street-tek.com>
Cc: "'Selinux'" <selinux@tycho.nsa.gov>
In-Reply-To: <20040514122351.2D9FE3A404F@abyss.simplyaquatics.com>
References: <20040514122351.2D9FE3A404F@abyss.simplyaquatics.com>
Content-Type: text/plain
Message-Id: <1084538065.17741.44.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 14 May 2004 08:34:25 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-05-14 at 08:23, Ed Street wrote:
> Suse 9.1 uses kernel 2.6 and I'm thinking the 9.0 stuff would be very dated.
> The better option may be going with the upstream or the fedora srpm.

I think Thomas Bleher was using a 2.6 SELinux kernel, but am not
certain.  But even if he were using the current 2.4 SELinux kernel, it
has the same API (recall that Jim Carter back ported the API changes and
xattr support from 2.6. to 2.4), so the patched userland should work
fine.  It is true that the Fedora SRPMS will have the latest selinux
patches, and that the patches have undergone changes, so it would be
good for Thomas or you to at least check your selinux patches against
the latest ones and see whether it is worthwhile to pull in updated
versions.  We try to keep a core set of patches available for reference
from http://www.nsa.gov/selinux/patches and in the sourceforge CVS tree,
but that is only a subset of the full set of SELinux patches in Fedora
Core 2 devel.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
