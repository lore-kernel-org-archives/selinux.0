Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w341bbbd002566
 for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2018 21:37:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 40G7qb6gZrzrMHQ
 for <selinux@tycho.nsa.gov>; Wed,  4 Apr 2018 01:37:15 +0000 (UTC)
Received: from UPBD19PA14.eemsg.mil (unknown [192.168.18.14])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 40G7qb5WK6zrKY3
 for <selinux@tycho.nsa.gov>; Wed,  4 Apr 2018 01:37:15 +0000 (UTC)
Received: by mail-lf0-f49.google.com with SMTP id j68-v6so22877146lfg.13
 for <selinux@tycho.nsa.gov>; Tue, 03 Apr 2018 18:37:14 -0700 (PDT)
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Apr 2018 21:37:11 -0400
Message-ID: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: [GIT PULL] SELinux patches for v4.17
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Linus,

A bigger than usual pull request for SELinux, 13 patches (lucky!)
along with a scary looking diffstat.  Although if you look a bit
closer, excluding the usual minor tweaks/fixes, there are really only
two significant changes in this pull request: the addition of proper
SELinux access controls for SCTP and the encapsulation of a lot of
internal SELinux state.  The SCTP changes are the result of a
multi-month effort (maybe even a year or longer?) between the SELinux
folks and the SCTP folks to add proper SELinux controls.  A special
thanks go to Richard for seeing this through and keeping the effort
moving forward.  The state encapsulation work is a bit of janitorial
work that came out of some early work on SELinux namespacing.  The
question of namespacing is still an open one, but I believe there is
some real value in the encapsulation work so we've split that out and
are now sending that up to you.

Everything passes the selinux-testsuite, but there are a few known
merge conflicts.  The first is with the netdev tree and is in
net/sctp/socket.c.  Unfortunately it is a bit ugly, thankfully Stephen
Rothwell has already done the heavy lifting in resolving the merge for
you, and the SCTP folks have given his merge patch a thumbs-up.  Link
below:

* https://marc.info/?l=linux-netdev&m=152047486123499&w=2

There are also two conflicts with James' security tree, both rather
easy.  The first is in security/selinux/hooks.c and is quite trivial,
but since I've got the linux-next archive handy, here is a link to the
merge fixup:

* https://marc.info/?l=linux-next&m=152160312324537&w=2

The second security/SELinux conflict is in include/linux/lsm_hooks.h
and while the size of the fixup is scary at first, it is really just
the three new LSM/SCTP hooks and isn't that bad at all:

* https://marc.info/?l=linux-next&m=152273068901460&w=2

In the past I know you have preferred to handle your own merge
conflict resolution, but the above is a bit more than usual, at least
for the SELinux tree.  If you would prefer that I handle the merge
conflicts and send you a new PR (or something else), let me know.

Thanks,
-Paul

--
The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

 Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux
-pr-20180403

for you to fetch changes up to 6b6bc6205d98796361962ee282a063f18ba8dc57:

 selinux: wrap AVC state (2018-03-20 16:58:17 -0400)

----------------------------------------------------------------
selinux/stable-4.17 PR 20180403

----------------------------------------------------------------
Arnd Bergmann (1):
     selinux: fix typo in selinux_netlbl_sctp_sk_clone declaration

Paul Moore (1):
     selinux: rename the {is,set}_enforcing() functions

Richard Haines (7):
     netlabel: If PF_INET6, check sk_buff ip header version
     security: Add support for SCTP security hooks
     sctp: Add ip option support
     sctp: Add LSM hooks
     selinux: Add SCTP support
     selinux: Fix ltp test connect-syscall failure
     selinux: Update SELinux SCTP documentation

Stephen Smalley (4):
     selinux: wrap global selinux state
     selinux: fix handling of uninitialized selinux state in get_bools/classes
     selinux: wrap selinuxfs state
     selinux: wrap AVC state

Documentation/security/LSM-sctp.rst     |  175 +++++
Documentation/security/SELinux-sctp.rst |  158 +++++
include/linux/lsm_hooks.h               |   36 +
include/linux/security.h                |   25 +
include/net/sctp/sctp.h                 |    4 +-
include/net/sctp/structs.h              |   12 +
include/uapi/linux/sctp.h               |    1 +
net/netlabel/netlabel_unlabeled.c       |   10 +
net/sctp/chunk.c                        |   10 +-
net/sctp/ipv6.c                         |   45 +-
net/sctp/output.c                       |   34 +-
net/sctp/protocol.c                     |   43 ++
net/sctp/sm_make_chunk.c                |   12 +
net/sctp/sm_statefuns.c                 |   18 +
net/sctp/socket.c                       |   73 +-
security/security.c                     |   22 +
security/selinux/avc.c                  |  282 ++++----
security/selinux/hooks.c                |  922 +++++++++++++++++++-------
security/selinux/ibpkey.c               |    3 +-
security/selinux/include/avc.h          |   38 +-
security/selinux/include/avc_ss.h       |    9 +-
security/selinux/include/classmap.h     |    2 +-
security/selinux/include/conditional.h  |   11 +-
security/selinux/include/netlabel.h     |   22 +-
security/selinux/include/objsec.h       |    6 +-
security/selinux/include/security.h     |  231 +++++--
security/selinux/netif.c                |    2 +-
security/selinux/netlabel.c             |  148 ++++-
security/selinux/netnode.c              |    4 +-
security/selinux/netport.c              |    2 +-
security/selinux/selinuxfs.c            |  493 ++++++++------
security/selinux/ss/avtab.c             |    9 +-
security/selinux/ss/avtab.h             |    3 -
security/selinux/ss/ebitmap.c           |    7 +-
security/selinux/ss/ebitmap.h           |    3 -
security/selinux/ss/hashtab.c           |    8 +-
security/selinux/ss/hashtab.h           |    4 -
security/selinux/ss/mls.c               |   72 +-
security/selinux/ss/mls.h               |   38 +-
security/selinux/ss/services.c          | 1100 ++++++++++++++++++-------------
security/selinux/ss/services.h          |   24 +-
security/selinux/ss/status.c            |   47 +-
security/selinux/xfrm.c                 |   23 +-
43 files changed, 2939 insertions(+), 1252 deletions(-)
create mode 100644 Documentation/security/LSM-sctp.rst
create mode 100644 Documentation/security/SELinux-sctp.rst

-- 
paul moore
www.paul-moore.com
