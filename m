Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4VGBgMV004495
 for <selinux@tycho.nsa.gov>; Wed, 31 May 2017 12:11:42 -0400
Received: by mail-lf0-f43.google.com with SMTP id h4so12344838lfj.3
 for <selinux@tycho.nsa.gov>; Wed, 31 May 2017 09:11:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <149624586416.16947.1791692521620960783.stgit@sifl>
References: <149624586416.16947.1791692521620960783.stgit@sifl>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 31 May 2017 12:11:26 -0400
Message-ID: <CAHC9VhTX5zV5jQVCUswgARmdOh9-+DUD_h1L26sYN6CtkQ9DcA@mail.gmail.com>
Subject: Re: [PATCH v2] tools: add perltidy to the syntax checker/fixer
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 31, 2017 at 11:51 AM, Paul Moore <pmoore@redhat.com> wrote:
> From: Paul Moore <paul@paul-moore.com>
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  tools/check-syntax |   87 ++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 67 insertions(+), 20 deletions(-)

FYI, I went ahead and merged this into the testsuite repo; the only
change from v1 is the mv/cat fix that Stephen pointed out earlier.

I also applied the formatting fixes to the repository as well, the
patch is too large to send to the list, but the diffstat is below:

commit e66b1b7ad81a0e8ba10e55b09a062ed90c729020
master, github/master)
Author: Paul Moore <paul@paul-moore.com>
Date:   Wed May 31 11:51:55 2017 -0400

all: format the perl code with "./tools/check-syntax -f"

Signed-off-by: Paul Moore <paul@paul-moore.com>

tests/bounds/test                |  148 +++--
tests/cap_userns/test            |   25 -
tests/capable_file/test          |   63 +-
tests/capable_net/test           |   29 -
tests/capable_sys/test           |   32 +
tests/checkreqprot/test          |    8
tests/domain_trans/test          |   17 -
tests/dyntrace/test              |   17 -
tests/dyntrans/test              |   17 -
tests/entrypoint/test            |    9
tests/execshare/test             |   15
tests/exectrace/test             |   17 -
tests/execute_no_trans/test      |   15
tests/extended_socket_class/test |   84 ++-
tests/fdreceive/test             |   30 +
tests/file/test                  |   97 ++-
tests/inet_socket/test           |  175 +++--
tests/inherit/test               |   35 +
tests/ioctl/test                 |   35 +
tests/link/test                  |   52 +-
tests/loop.pl                    |   11
tests/mac_admin/test             |   39 +
tests/mkdir/test                 |   57 +-
tests/mmap/test                  |  234 ++++---
tests/mqueue/test                |   54 +-
tests/msg/test                   |   77 +-
tests/netlink_socket/test        |   45 +
tests/nnp/test                   |   23 -
tests/open/test                  |   53 +-
tests/overlay/test               | 1230 +++++++++++++++++++---------------
tests/prlimit/test               |   41 +
tests/ptrace/test                |   15
tests/readlink/test              |   33 +
tests/relabel/test               |   33 +
tests/rename/test                |   91 ++-
tests/runtests.pl                |   20 -
tests/rxdir/test                 |   33 +
tests/sem/test                   |   54 +-
tests/setattr/test               |   31 +
tests/setnice/test               |   17 -
tests/shm/test                   |   47 +
tests/sigkill/test               |   41 +
tests/stat/test                  |   21 -
tests/sysctl/test                |   16
tests/task_create/test           |   11
tests/task_getpgid/test          |   15
tests/task_getscheduler/test     |   15
tests/task_getsid/test           |   15
tests/task_setnice/test          |   20 -
tests/task_setpgid/test          |   11
tests/task_setscheduler/test     |   32 +
tests/unix_socket/test           |   65 +-
52 files changed, 1983 insertions(+), 1437 deletions(-)

-- 
paul moore
www.paul-moore.com
