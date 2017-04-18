Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3IMcBAx008055
 for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2017 18:38:11 -0400
To: LSM <linux-security-module@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: SELinux "filtering" capabilities?
Message-ID: <82d9ff60-6850-0873-1e68-20bd0e27e9ee@schaufler-ca.com>
Date: Tue, 18 Apr 2017 15:37:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I don't expect anyone else to have run into this
as I am working with SELinux and Smack on the same
machine at the same time. While there are a number
of interactions that I can explain, I have one that
is perplexing me. I assume something rational is
going on, but I am having trouble tracking it down.

A process with CAP_MAC_ADMIN can change its Smack label
by writing the new label to /proc/self/attr/smack/current.*
If I have both SELinux and Smack enabled the write fails
with -EPERM, indicating that the process lacks CAP_MAC_ADMIN.
Instrumenting the Smack code verifies that, even though the
process reports having CAP_MAC_ADMIN, the capability is gone
in smack_setprocattr().

It seem that this could be happening in the write() path,
or perhaps an artifact of SELinux not knowing something
special about smackfs. I don't see anything obvious.
Unfortunately, it is going to be somewhat difficult for
me to claim that I have SELinux and Smack working, if not
together, at least begrudgingly on the same system.

----
* The smack subdir of attr isn't upstream yet, but I hope
  to get it there real soon.
