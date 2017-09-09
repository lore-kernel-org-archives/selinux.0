Date: Sat, 9 Sep 2017 07:05:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: james.l.morris@oracle.com, serge@hallyn.com, paul@paul-moore.com,
 casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Message-ID: <20170909050552.GD3713@kroah.com>
References: <20170908164001.21138-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170908164001.21138-1-sds@tycho.nsa.gov>
Subject: Re: [PATCH] usb, signal, security: only pass the cred,
 not the secid, to kill_pid_info_as_cred and security_task_kill
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 08, 2017 at 12:40:01PM -0400, Stephen Smalley wrote:
> commit d178bc3a708f39cbfefc3fab37032d3f2511b4ec ("user namespace: usb:
>  make usb urbs user namespace aware (v2)") changed kill_pid_info_as_uid
> to kill_pid_info_as_cred, saving and passing a cred structure instead of
> uids.  Since the secid can be obtained from the cred, drop the secid fields
> from the usb_dev_state and async structures, and drop the secid argument to
> kill_pid_info_as_cred.  Replace the secid argument to security_task_kill
> with the cred.  Update SELinux, Smack, and AppArmor to use the cred, which
> avoids the need for Smack and AppArmor to use a secid at all in this hook.
> Further changes to Smack might still be required to take full advantage of
> this change, since it should now be possible to perform capability
> checking based on the supplied cred.  The changes to Smack and AppArmor
> have only been compile-tested.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  drivers/usb/core/devio.c     | 10 ++--------
>  include/linux/lsm_hooks.h    |  5 +++--
>  include/linux/sched/signal.h |  2 +-
>  include/linux/security.h     |  4 ++--
>  kernel/signal.c              |  6 +++---
>  security/apparmor/lsm.c      | 17 ++++++++++++-----
>  security/security.c          |  4 ++--
>  security/selinux/hooks.c     |  7 +++++--
>  security/smack/smack_lsm.c   | 12 +++++-------
>  9 files changed, 35 insertions(+), 32 deletions(-)


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
