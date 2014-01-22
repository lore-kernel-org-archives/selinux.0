Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0MKpiRq009776
 for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2014 15:51:44 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so1144673qae.13
 for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2014 12:51:43 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@tycho.nsa.gov
Subject: SELinux tree changes
Date: Wed, 22 Jan 2014 15:51:39 -0500
Message-ID: <4717594.Pj3N9d8KHF@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello All,

I do apologize, but I've had to make some minor changes to the SELinux tree in 
an effort to preserve my sanity, and disk space, in the face of different 
development streams, linux-next, and all the various stable backport trees.  
While the tree will still be at the same location, things will be much more 
branch based:

 -> git://git.infradead.org/users/pcmoore/selinux
    #next        - patches currently in linux-next
    #stable-X.XX - patches targeting the associated stable tree

If you currently have a private tree backed against the SELinux tree you 
should now be tracking the next branch.  Once again, I apologize for any 
problems this may cause, but my initial approach to the SELinux tree was too 
simplistic to be useful in the long term.

-Paul

-- 
paul moore
www.paul-moore.com
