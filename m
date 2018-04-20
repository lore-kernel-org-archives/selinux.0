Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3KFZIaX001973
 for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2018 11:35:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC09.oob.disa.mil (Postfix) with SMTP id 40SKg85mxtz2NhLv
 for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2018 15:35:16 +0000 (UTC)
Received: from UPBD19PA06.eemsg.mil (unknown [192.168.18.7])
 by UPDCF3IC09.oob.disa.mil (Postfix) with ESMTP id 40SKg814Xyz2NhLm
 for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2018 15:35:16 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHC9VhQhaBNBFwAXJ4TxKO56UTcwb_LcT2G8LwNxdxOD96tTvA@mail.gmail.com>
References: <CAHC9VhQhaBNBFwAXJ4TxKO56UTcwb_LcT2G8LwNxdxOD96tTvA@mail.gmail.com>
 <152414466005.23902.12967974041384198114.stgit@warthog.procyon.org.uk>
 <152414469006.23902.8132059438921850399.stgit@warthog.procyon.org.uk>
To: Paul Moore <paul@paul-moore.com>
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
 selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 20 Apr 2018 16:35:11 +0100
Message-ID: <3232.1524238511@warthog.procyon.org.uk>
Subject: Re: [PATCH 04/24] VFS: Add LSM hooks for filesystem context [ver #7]
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Paul Moore <paul@paul-moore.com> wrote:

> Adding the SELinux mailing list to the CC line; in the future please
> include the SELinux mailing list on patches like this.  It would also
> be very helpful to include "selinux" somewhere in the subject line
> when the patch is predominately SELinux related (much like you did for
> the other LSMs in this patchset).

I should probably evict the SELinux bits into their own patch since the point
of this patch is the LSM hooks, not specifically SELinux's implementation
thereof.

> I can't say I've digested all of this yet, but what SELinux testing
> have you done with this patchset?

Using the fsopen()/fsmount() syscalls, these hooks will be made use of, say
for NFS (which I haven't included in this list).  Even sys_mount() will make
use of them a bit, so just booting the system does that.

Note that for SELinux these hooks don't change very much except how the
parameters are handled.  It doesn't actually change the checks that are made -
at least, not yet.  There are some additional syscalls under consideration
(such as the ability to pick a live mounted filesystem into a context) that
might require additional permits.

David
