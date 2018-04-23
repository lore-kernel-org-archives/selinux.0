Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3NH4W30015906
 for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2018 13:04:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID11.oob.disa.mil (Postfix) with SMTP id 40VCVk526HzXq2H
 for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2018 17:04:30 +0000 (UTC)
Received: from USFB19PA09_EEMSG_MP5.eemsg.mil (unknown [192.168.16.6])
 by USFBF3ID11.oob.disa.mil (Postfix) with ESMTP id 40VCVk25yJzXq3F
 for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2018 17:04:30 +0000 (UTC)
To: David Herrmann <dh.herrmann@gmail.com>, linux-kernel@vger.kernel.org
Cc: James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
 teg@jklm.no, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 Eric Paris <eparis@parisplace.org>, serge@hallyn.com,
 davem@davemloft.net, netdev@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20180423133015.5455-1-dh.herrmann@gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <32eea1d6-450c-bc68-59d6-74bc5011ead2@schaufler-ca.com>
Date: Mon, 23 Apr 2018 10:04:19 -0700
MIME-Version: 1.0
In-Reply-To: <20180423133015.5455-1-dh.herrmann@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 0/3] Introduce LSM-hook for socketpair(2)
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 4/23/2018 6:30 AM, David Herrmann wrote:
> Hi
>
> This series adds a new LSM hook for the socketpair(2) syscall. The idea
> is to allow SO_PEERSEC to be called on AF_UNIX sockets created via
> socketpair(2), and return the same information as if you emulated
> socketpair(2) via a temporary listener socket. Right now SO_PEERSEC
> will return the unlabeled credentials for a socketpair, rather than the
> actual credentials of the creating process.
>
> ...
>
> This series only adds SELinux backends, since that is what we need for
> RHEL. I will gladly extend the other LSMs if needed.

I would be very happy to see a proposed patch for Smack. It shouldn't
be much different from the SELinux version, with the exception that it
will use pointers to smk_known structures instead of secids. It would be
a big help, as someone just threw a whole new species of scorpion into
this pit.

>
> Thanks
> David
>
> [1] https://github.com/bus1/dbus-broker/blob/master/src/util/test-peersec.c
> [2] https://www.spinics.net/lists/selinux/msg22674.html
>
> David Herrmann (3):
>   security: add hook for socketpair(AF_UNIX, ...)
>   net/unix: hook unix_socketpair() into LSM
>   selinux: provide unix_stream_socketpair callback
>
>  include/linux/lsm_hooks.h |  8 ++++++++
>  include/linux/security.h  |  7 +++++++
>  net/unix/af_unix.c        |  5 +++++
>  security/security.c       |  6 ++++++
>  security/selinux/hooks.c  | 14 ++++++++++++++
>  5 files changed, 40 insertions(+)
>
