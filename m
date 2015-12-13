Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBDN7MS2004677
 for <selinux@tycho.nsa.gov>; Sun, 13 Dec 2015 18:07:22 -0500
Received: by qgew101 with SMTP id w101so34800845qge.2
 for <selinux@tycho.nsa.gov>; Sun, 13 Dec 2015 15:06:58 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@tycho.nsa.gov, linux-audit@redhat.com
Cc: linux-security-module@vger.kernel.org
Subject: SELinux/audit kernel repo process changes
Date: Sun, 13 Dec 2015 18:06:57 -0500
Message-ID: <5186598.idHx68WrXE@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In an effort to make it a bit easier to maintain the kernel-secnext COPR I'm 
making some slight changes to how I manage the SELinux and audit kernel 
repositories.  The downside is that there is now going to be a regular rebase 
as part of the release cycle, but at least it will be well defined and part of 
the process, unlike the current reactionary rebases.

Starting with the next merge window, I'll be following the process below:

1. When a new kernel is released, rebase the repository's upstream branch to 
the tagged kernel release (or the latest LSM upstream branch in the case of 
SELinux) and apply the next branch on top of the upstream branch.  Send a pull 
request for the upstream branch to the next level maintainer.

2. Create a new branch, stable-X.XX, a copy of the upstream branch that was 
sent during the merge window.

3. Reset the next branch to the upstream branch that was sent during the merge 
window.  At this point the upstream, next, and latest stable-X.XX branch 
should be identical.

4. Accept patches into both the stable-X.XX and next branches; as necessary, 
send pull requests for stable-X.XX to the next level maintainer.  Continue 
until the next kernel is released and the process repeats.

As in the past, this process is subject to change, but I'm hopeful that this 
approach should work for the foreseeable future.

-- 
paul moore
www.paul-moore.com
