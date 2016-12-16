Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBGM2uso028377
 for <selinux@tycho.nsa.gov>; Fri, 16 Dec 2016 17:02:57 -0500
Received: by mail-ua0-f195.google.com with SMTP id b35so2677954uaa.0
 for <selinux@tycho.nsa.gov>; Fri, 16 Dec 2016 14:02:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 16 Dec 2016 17:02:53 -0500
Message-ID: <CAHC9VhSVjPnQsMhxPUWxtbhoYieff_TWQp66==K66MKOR93mFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: clean up cred usage and simplify
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <james.l.morris@oracle.com>,
 linux-security-module@vger.kernel.org, casey@schaufler-ca.com,
 john.johansen@canonical.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Dec 16, 2016 at 12:41 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> SELinux was sometimes using the task "objective" credentials when
> it could/should use the "subjective" credentials.  This was sometimes
> hidden by the fact that we were unnecessarily passing around pointers
> to the current task, making it appear as if the task could be something
> other than current, so eliminate all such passing of current.  Inline
> various permission checking helper functions that can be reduced to a
> single avc_has_perm() call.
>
> Since the credentials infrastructure only allows a task to alter
> its own credentials, we can always assume that current must be the same
> as the target task in selinux_setprocattr after the check. We likely
> should move this check from selinux_setprocattr() to proc_pid_attr_write()
> and drop the task argument to the security hook altogether; it can only
> serve to confuse things.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c          | 294 +++++++++++++++-----------------------
>  security/selinux/include/objsec.h |  10 ++
>  security/selinux/selinuxfs.c      |  73 +++++-----
>  3 files changed, 166 insertions(+), 211 deletions(-)

Merged, thanks.

Looking at this patch, I think getting rid of the wrappers was the
right way to go from a readability perspective.

-- 
paul moore
www.paul-moore.com
