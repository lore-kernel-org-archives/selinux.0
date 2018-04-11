Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3BLBpHW024876
 for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2018 17:11:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC15.oob.disa.mil (Postfix) with SMTP id 40LxYZ6yXLz2kr7X
 for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2018 21:11:46 +0000 (UTC)
Received: from UPDC3CPA12_EEMSG_MP28.eemsg.mil (unknown [192.168.18.23])
 by UPDCF3IC15.oob.disa.mil (Postfix) with ESMTP id 40LxYZ5jXFz2kr7D
 for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2018 21:11:46 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id v207-v6so4631431lfa.10
 for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2018 14:11:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <eb67b174e6a3d0fe174cc738d9109cd7fda96a9b.1523316291.git.rgb@redhat.com>
References: <eb67b174e6a3d0fe174cc738d9109cd7fda96a9b.1523316291.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Apr 2018 17:11:44 -0400
Message-ID: <CAHC9VhTv_2ErGe38u+Z2CGY2BhNqbG0u_tqbMmwOYUsr4jJ3aQ@mail.gmail.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, SElinux list <selinux@tycho.nsa.gov>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH ghak47 V1] audit: normalize MAC_POLICY_LOAD
 record
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Apr 9, 2018 at 7:36 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> The audit MAC_POLICY_LOAD record had redundant dangling keywords and was
> missing information about which LSM was responsible and its completion
> status.  While this record is only issued on success, the parser expects
> the res= field to be present.
>
> Old record:
> type=MAC_POLICY_LOAD msg=audit(1479299795.404:43): policy loaded auid=0 ses=1
>
> Delete the redundant dangling keywords, add the lsm= field and the res=
> field.
>
> New record:
> type=MAC_POLICY_LOAD msg=audit(1523293846.204:894): auid=0 ses=1 lsm=selinux res=1
>
> See: https://github.com/linux-audit/audit-kernel/issues/47
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/selinux/selinuxfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 00b21b2..496915a 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -531,7 +531,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
>
>  out1:
>         audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
> -               "policy loaded auid=%u ses=%u",
> +               "auid=%u ses=%u lsm=selinux res=1",

This is another case of NACK on principle, but I think we can make an
exception in this particular case.

Also like the other patch, this will need to wait for the merge window
to close before I can merge it.

>                 from_kuid(&init_user_ns, audit_get_loginuid(current)),
>                 audit_get_sessionid(current));
>  out:
> --
> 1.8.3.1
>

-- 
paul moore
www.paul-moore.com
