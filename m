Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vARLgQAT007957
 for <selinux@tycho.nsa.gov>; Mon, 27 Nov 2017 16:42:26 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 3ylwN43ffsz2SjFy
 for <selinux@tycho.nsa.gov>; Mon, 27 Nov 2017 18:30:44 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 3ylwN431q3z2SjFw
 for <selinux@tycho.nsa.gov>; Mon, 27 Nov 2017 18:30:44 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id o41so33385538lfi.2
 for <selinux@tycho.nsa.gov>; Mon, 27 Nov 2017 08:19:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511791439-15957-1-git-send-email-danielj@mellanox.com>
References: <1511791439-15957-1-git-send-email-danielj@mellanox.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Nov 2017 11:19:38 -0500
Message-ID: <CAHC9VhRqB4DxRjR=ceaJuc12M5R4ZAXgmBrEKws4BQMGVeASzw@mail.gmail.com>
To: Dan Jurgens <danielj@mellanox.com>, selinux@tycho.nsa.gov
Cc: pebenito@ieee.org, honli@redhat.com, refpolicy@oss.tresys.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/1] networkmanager: Grant access to unlabeled
 PKeys
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Nov 27, 2017 at 9:03 AM, Dan Jurgens <danielj@mellanox.com> wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
>
> For controlling IPoIB VLANs
>
> Reported-by: Honggang LI <honli@redhat.com>
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> Tested-by: Honggang LI <honli@redhat.com>
> ---
>  networkmanager.te |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

[NOTE: resending due to a typo in the refpol mailing list address]

We obviously need something like this now so we don't break IPoIB, but
I wonder if we should make the IB access controls dynamic like the
per-packet network access controls.  We could key off the presence of
the IB pkey and endport definitions: if there are any objects defined
in the loaded policy we enable the controls, otherwise we disable
them.

> diff --git a/networkmanager.te b/networkmanager.te
> index 76d0106..5e881f4 100644
> --- a/networkmanager.te
> +++ b/networkmanager.te
> @@ -184,6 +184,8 @@ userdom_write_user_tmp_sockets(NetworkManager_t)
>  userdom_dontaudit_use_unpriv_user_fds(NetworkManager_t)
>  userdom_dontaudit_use_user_ttys(NetworkManager_t)
>
> +corenet_ib_access_unlabeled_pkeys(NetworkManager_t)
> +
>  optional_policy(`
>         avahi_domtrans(NetworkManager_t)
>         avahi_kill(NetworkManager_t)
> --
> 1.7.1

-- 
paul moore
www.paul-moore.com
