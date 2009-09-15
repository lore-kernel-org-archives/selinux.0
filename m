Date: Tue, 15 Sep 2009 12:32:52 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] SELinux: inline selinux_is_enabled in
 !CONFIG_SECURITY_SELINUX
In-Reply-To: <alpine.LFD.2.01.0909141901160.4950@localhost.localdomain>
Message-ID: <alpine.LRH.2.00.0909151230240.15017@tundra.namei.org>
References: <20090915005948.12692.40854.stgit@paris.rdu.redhat.com> <alpine.LRH.2.00.0909151134250.13708@tundra.namei.org> <alpine.LFD.2.01.0909141901160.4950@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 14 Sep 2009, Linus Torvalds wrote:

> 
> 
> On Tue, 15 Sep 2009, James Morris wrote:
> > 
> > Linus, I'll assume you'll want to apply this directly.
> 
> What I want is to just get pull requests that were well tested in the 
> first place. When I see an error in a pull request, my reaction is to just 
> reset awat from it, and not wanting to have anything what-so-ever to do 
> with the git tree I pulled from.
> 
> Give me a few days to get over the disgust.

Sorry about this mess.

These fixes fix build problems, so here's the latest (also, I'll be 
on a long haul flight in a few days).  Boot tested with and without 
SELinux enabled.


The following changes since commit 86d710146fb9975f04c505ec78caa43d227c1018:
  Linus Torvalds (1):
        Merge git://git.linux-nfs.org/projects/trondmy/nfs-2.6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6 for-linus3

David Howells (2):
      CRED: Allow put_cred() to cope with a NULL groups list
      KEYS: Fix garbage collector

Eric Paris (4):
      Creds: creds->security can be NULL is selinux is disabled
      SELinux: seperate avc_cache flushing
      SELinux: flush the avc before disabling SELinux
      SELinux: inline selinux_is_enabled in !CONFIG_SECURITY_SELINUX

Marc Dionne (1):
      KEYS: Unlock tasklist when exiting early from keyctl_session_to_parent

 include/linux/cred.h       |   13 ++++---
 include/linux/selinux.h    |    9 +++++
 kernel/cred.c              |    3 +-
 security/keys/gc.c         |   78 ++++++++++++++++++++++++++++---------------
 security/keys/key.c        |    4 +-
 security/keys/keyctl.c     |    3 +-
 security/keys/keyring.c    |   24 +++++++++++---
 security/selinux/avc.c     |   26 +++++++++++----
 security/selinux/exports.c |    6 +++
 9 files changed, 118 insertions(+), 48 deletions(-)


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
