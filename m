Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2KKwxtu010962
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 16:59:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC09.oob.disa.mil (Postfix) with SMTP id 405QJr6XYqz2NjRX
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 20:58:52 +0000 (UTC)
Received: from UPBD19PA05.eemsg.mil (unknown [192.168.18.6])
 by UPDCF3IC09.oob.disa.mil (Postfix) with ESMTP id 405QJr5mLBz2NjRT
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 20:58:52 +0000 (UTC)
Received: by mail-lf0-f65.google.com with SMTP id y2-v6so4714637lfc.5
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 13:58:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180320155911.7271-2-sds@tycho.nsa.gov>
References: <20180320155911.7271-1-sds@tycho.nsa.gov>
 <20180320155911.7271-2-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Mar 2018 16:57:49 -0400
Message-ID: <CAHC9VhSUP1eUceRL4yhgimjvA3F_J5iK3mbsFENOiLYEpfYE2w@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
 peter.enderborg@sony.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/2] selinux: wrap selinuxfs state
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Mar 20, 2018 at 11:59 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Move global selinuxfs state to a per-instance structure (selinux_fs_info),
> and include a pointer to the selinux_state in this structure.
> Pass this selinux_state to all security server operations, thereby
> ensuring that each selinuxfs instance presents a view of and acts
> as an interface to a particular selinux_state instance.
>
> This change should have no effect on SELinux behavior or APIs
> (userspace or LSM).  It merely wraps the selinuxfs global state,
> links it to a particular selinux_state (currently always the single
> global selinux_state) and uses that state for all operations.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/selinuxfs.c | 438 ++++++++++++++++++++++++++-----------------
>  1 file changed, 261 insertions(+), 177 deletions(-)

Merged, thanks for the respin.

-- 
paul moore
www.paul-moore.com
