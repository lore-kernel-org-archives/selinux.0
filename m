Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h82CcwLa015419
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 08:38:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h82Ccvet022307
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 12:38:57 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h82Cculq022304 for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 12:38:56 GMT
Subject: Re: ls --context of /selinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>, Daniel J Walsh <dwalsh@redhat.com>,
   James Morris <jmorris@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200309021723.27716.russell@coker.com.au>
References: <200309021723.27716.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1062506326.18568.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 Sep 2003 08:38:46 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-09-02 at 03:23, Russell Coker wrote:
> What are the plans regarding "ls --context /selinux"?
> 
> Currently the lgetxattr() system call returns -1 (EOPNOTSUPP) and the current 
> ls patch (taken from Dan's repository) refuses to even allow "ls -l" because 
> of it (probably a bug in ls as I imagine that there will always be file 
> systems that don't support it).
> 
> Will "ls --context /selinux" ever work?

Since SELinux migrated to using xattr, the utilities can only get and
set the contexts of files in a filesystem if it provides an xattr
handler.  There doesn't seem to be any reason to support getting or
setting contexts on selinuxfs entries, so I wouldn't expect us to
implement an xattr handler for it.  The 'ls' in the patched coreutils
from the NSA SELinux site simply displays (null) in the context field
for such filesystems; I'm not sure why Dan has changed the behavior in
his latest patch.  There will always be at least some filesystem types
that will not provide xattr handlers, so it does need to cleanly handle
this case.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
