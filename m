Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA28544
	for <selinux@tycho.nsa.gov>; Thu, 21 Nov 2002 10:03:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA27676
	for <selinux@tycho.nsa.gov>; Thu, 21 Nov 2002 15:00:55 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id PAA27672
	for <selinux@tycho.nsa.gov>; Thu, 21 Nov 2002 15:00:54 GMT
Message-Id: <200211211510.KAA18104@moss-shockers.ncsc.mil>
Date: Thu, 21 Nov 2002 10:10:22 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: RE: login (new default_contexts, run-time detection)
To: selinux@tycho.nsa.gov, mayerf@tresys.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Exactly.  I fully expect that upgrades will leave both around (exactly
> the problem I had on my system).  Also, I gathered from your description
> that /etc/security/default_contexts is optional and might not even
> be there.

True.  However, you can generally rely on having a default_contexts file,
and one is installed by default.  For any real package manager, I would
expect it to remove the old file, and we could likewise remove any old files 
from /etc/security as part of our installation instructions and quickinstall 
target.  In fact, this would seem to be an issue as well for your install-src 
policy Makefile target; at present, it would leave old .te files from the former 
policy that might have been removed in the new policy.
  
> I'd like a more reliable method, e.g., making some sys call, that would
> be a definitive hint. Any other ideas?

Since these changes were in progress for a long time by their developer,
the new call for obtaining the set of reachable legal SIDs for the user
from the security server was merged a while back, so you can't just
check for its existence.  Likewise, preliminary versions of the new libsecure
functions appeared a while back, so you can't just check for their existence
in the installed libsecure.  The only discernible difference is that login,
sshd, and crond now use the new libsecure functions (but they are stripped
before installation, so you can't just check their symbol tables) and 
default_contexts is now installed.  I'd suggest just checking for 
default_contexts.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
