Message-ID: <527A567D.7050401@tycho.nsa.gov>
Date: Wed, 06 Nov 2013 09:47:25 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 3/3] Minor manpages improvements
References: <1383740641-9927-1-git-send-email-bigon@debian.org> <1383740641-9927-3-git-send-email-bigon@debian.org>
In-Reply-To: <1383740641-9927-3-git-send-email-bigon@debian.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/06/2013 07:24 AM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> ---
>  policycoreutils/audit2allow/audit2allow.1      | 2 +-
>  policycoreutils/gui/selinux-polgengui.8        | 2 +-
>  policycoreutils/gui/system-config-selinux.8    | 2 +-
>  policycoreutils/load_policy/load_policy.8      | 2 +-
>  policycoreutils/mcstrans/man/man8/mcstransd.8  | 4 ++--
>  policycoreutils/scripts/fixfiles.8             | 4 ++--
>  policycoreutils/secon/secon.1                  | 2 +-
>  policycoreutils/semanage/semanage-boolean.8    | 2 +-
>  policycoreutils/semanage/semanage-dontaudit.8  | 2 +-
>  policycoreutils/semanage/semanage-export.8     | 6 +++---
>  policycoreutils/semanage/semanage-fcontext.8   | 2 +-
>  policycoreutils/semanage/semanage-import.8     | 4 ++--
>  policycoreutils/semanage/semanage-interface.8  | 4 ++--
>  policycoreutils/semanage/semanage-login.8      | 8 ++++----
>  policycoreutils/semanage/semanage-module.8     | 2 +-
>  policycoreutils/semanage/semanage-node.8       | 2 +-
>  policycoreutils/semanage/semanage-permissive.8 | 2 +-
>  policycoreutils/semanage/semanage-port.8       | 2 +-
>  policycoreutils/semanage/semanage-user.8       | 4 ++--
>  policycoreutils/semanage/semanage.8            | 2 +-
>  policycoreutils/sepolicy/sepolicy-generate.8   | 8 +++-----
>  policycoreutils/setfiles/restorecon.8          | 4 ++--
>  22 files changed, 35 insertions(+), 37 deletions(-)

Merged all three patches to #next.  Will be included in policycoreutils 2.3.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
