Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBBIcKgd031447
 for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2015 13:38:20 -0500
Received: by padhk6 with SMTP id hk6so29142194pad.2
 for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2015 10:37:50 -0800 (PST)
To: paul@paul-moore.com
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, eparis@parisplace.org,
 james.l.morris@oracle.com, serge@hallyn.com,
 linux-security-module@vger.kernel.org, jeffv@google.com,
 nnk@google.com, arve@google.com
From: Daniel Cashman <dcashman@android.com>
Subject: Exposing secid to secctx mapping to user-space
Message-ID: <566B17FB.6010405@android.com>
Date: Fri, 11 Dec 2015 10:37:47 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

I would like to write a patch that would expose, via selinuxfs, the
mapping between secids in the kernel and security contexts to
user-space, but before doing so wanted to get some feedback as to
whether or not such an endeavor could have any support upstream.  The
direct motivation for this is the desire to communicate calling security
ids/contexts over binder IPC on android for use in a user-space object
manager.  Passing the security ids themselves would be simpler and more
efficient in the critical kernel path, but they currently have no
user-space meaning.

Thank You,
Dan
