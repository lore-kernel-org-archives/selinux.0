From: David Herrmann <dh.herrmann@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
 teg@jklm.no, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 Eric Paris <eparis@parisplace.org>, serge@hallyn.com,
 Casey Schaufler <casey@schaufler-ca.com>, davem@davemloft.net,
 netdev@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>
Date: Fri,  4 May 2018 16:28:18 +0200
Message-Id: <20180504142822.15233-1-dh.herrmann@gmail.com>
Subject: [PATCH v2 0/4] Introduce LSM-hook for socketpair(2)
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi

This is v2 of the socketpair(2) LSM hook introduction. Changes
since v1 are:

  - Added ACKs from previous series.

  - Moved the hook into generic socketpair(2) handling. The hook is now
    called security_socket_socketpair(), just like the other hooks on
    the socket layer.
    There is no AF_UNIX specific code, anymore.

  - Added SMACK support.

  - Still *NO* AppArmor support, since upstream AppArmor lacks
    SO_PEERSEC support and requires downstream patches (in particular,
    the apparmor_unix_stream_connect() function is mostly a stub and
    was never synced with Ubuntu downstream modifications).

Old cover letter follows (only trivial changes).

Thanks
David


This series adds a new LSM hook for the socketpair(2) syscall. The idea
is to allow SO_PEERSEC to be called on AF_UNIX sockets created via
socketpair(2), and return the same information as if you emulated
socketpair(2) via a temporary listener socket. Right now SO_PEERSEC
will return the unlabeled credentials for a socketpair, rather than the
actual credentials of the creating process.

A simple call to:

    socketpair(AF_UNIX, SOCK_STREAM, 0, out);

can be emulated via a temporary listener socket bound to a unique,
random name in the abstract namespace. By connecting to this listener
socket, accept(2) will return the second part of the pair. If
SO_PEERSEC is queried on these, the correct credentials of the creating
process are returned. A simple comparison between the behavior of
SO_PEERSEC on socketpair(2) and an emulated socketpair is included in
the dbus-broker test-suite [1].

This patch series tries to close this gap and makes both behave the
same. A new LSM-hook is added which allows LSMs to cache the correct
peer information on newly created socket-pairs.

Apart from fixing this behavioral difference, the dbus-broker project
actually needs to query the credentials of socketpairs, and currently
must resort to racy procfs(2) queries to get the LSM credentials of its
controller socket. Several parts of the dbus-broker project allow you
to pass in a socket during execve(2), which will be used by the child
process to accept control-commands from its parent. One natural way to
create this communication channel is to use socketpair(2). However,
right now SO_PEERSEC does not return any useful information, hence, the
child-process would need other means to retrieve this information. By
avoiding socketpair(2) and using the hacky-emulated version, this is not
an issue.

There was a previous discussion on this matter [2] roughly a year ago.
Back then there was the suspicion that proper SO_PEERSEC would confuse
applications. However, we could not find any evidence backing this
suspicion. Furthermore, we now actually see the contrary. Lack of
SO_PEERSEC makes it a hassle to use socketpairs with LSM credentials.
Hence, we propose to implement full SO_PEERSEC for socketpairs.

Thanks
David

[1] https://github.com/bus1/dbus-broker/blob/master/src/util/test-peersec.c
[2] https://www.spinics.net/lists/selinux/msg22674.html

David Herrmann (3):
  security: add hook for socketpair()
  net: hook socketpair() into LSM
  selinux: provide socketpair callback

Tom Gundersen (1):
  smack: provide socketpair callback

 include/linux/lsm_hooks.h  |  7 +++++++
 include/linux/security.h   |  7 +++++++
 net/socket.c               |  7 +++++++
 security/security.c        |  6 ++++++
 security/selinux/hooks.c   | 13 +++++++++++++
 security/smack/smack_lsm.c | 22 ++++++++++++++++++++++
 6 files changed, 62 insertions(+)

-- 
2.17.0
