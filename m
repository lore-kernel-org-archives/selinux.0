Message-id: <1447083624.2216.14.camel@samsung.com>
Subject: Re: [PATCH v4 00/11] Smack namespace
From: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
To: "David S. Miller" <davem@davemloft.net>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Calvin Owens <calvinowens@fb.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Eric Paris <eparis@parisplace.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Morris <james.l.morris@oracle.com>, Jann Horn <jann@thejh.net>,
 Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
 John Johansen <john.johansen@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 NeilBrown <neilb@suse.de>, Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Tejun Heo <tj@kernel.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 containers@lists.linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Lukasz Pawelczyk <havner@gmail.com>
Date: Mon, 09 Nov 2015 16:40:24 +0100
In-reply-to: <1444826525-9758-1-git-send-email-l.pawelczyk@samsung.com>
References: <1444826525-9758-1-git-send-email-l.pawelczyk@samsung.com>
Content-type: text/plain; charset=UTF-8
MIME-version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If I understand correctly the security window for 4.4 has been closed
now (as changes went to next).

Anyway, I updated the series to the latest smack-for-4.4 branch.
Including the new relabel-self interface that received namespace
treatment as well. Also the RCU fix reported on the list has been
included.

The latest version is available here:
https://github.com/Havner/smack-namespace/tree/smack-namespace-current

Also I've uploaded our Linux Test Project branch I use for Smack and
Smack namespace testing (including regressions):
https://github.com/Havner/ltp

It has the basic smack tests rewritten to C. The ones that were scripts
before. They are integrated with LTP framework.

Inside testcases/kernel/security/smack/ns is a separate set of tests
that share some common functions with the former, but are not otherwise
integrated with LTP (yet). In this regard this is very much WIP.

Those tests have an advantage though that they run a common set of
tests in 6 Smack environments: no namespace, user namespace, user
namespace + smack map. Each in a privileged and non-privileged
scenario.

To run them do the following:
cd testcases/kernel/security/smack/ns
make
./smack_ns_run.sh

smackfs has to be mounted in /smack (following the regular tests). 
mount -o bind /sys/fs/smackfs /smack
is enough.


-- 
Lukasz Pawelczyk
Samsung R&D Institute Poland
Samsung Electronics
