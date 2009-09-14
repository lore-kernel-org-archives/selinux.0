Date: Mon, 14 Sep 2009 12:58:34 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@elte.hu>,
        David Howells <dhowells@redhat.com>
Subject: [GIT] fix creds / SELinux regressions
In-Reply-To: <20090913025409.6583.58777.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.0909141256530.29020@tundra.namei.org>
References: <20090913025409.6583.58777.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Linus, please pull.


The following changes since commit 86d710146fb9975f04c505ec78caa43d227c1018:
  Linus Torvalds (1):
        Merge git://git.linux-nfs.org/projects/trondmy/nfs-2.6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6 for-linus

Eric Paris (3):
      Creds: creds->security can be NULL is selinux is disabled
      SELinux: seperate avc_cache flushing
      SELinux: flush the avc before disabling SELinux

 include/linux/cred.h       |   13 ++++++++-----
 include/linux/selinux.h    |    9 +++++++++
 security/selinux/avc.c     |   26 +++++++++++++++++++-------
 security/selinux/exports.c |    6 ++++++
 4 files changed, 42 insertions(+), 12 deletions(-)

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
