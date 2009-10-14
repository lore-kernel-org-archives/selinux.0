Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9EDMv0p029786
	for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2009 09:22:57 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n9EDOcmw027857
	for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2009 13:24:38 GMT
Subject: Re: sesearch question
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joe Nall <joe@nall.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <ddbc00640910131630l35dd9552g385a8df02771a464@mail.gmail.com>
References: <ddbc00640910131630l35dd9552g385a8df02771a464@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 14 Oct 2009 09:20:58 -0400
Message-Id: <1255526458.9995.63.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-10-13 at 16:30 -0700, Joe Nall wrote:
> When I use sesearch I appear to be seeing allow rules that are in
> tunables that are off. The rules below come from
> auth_manage_all_files_except_shadow which is in a disabled tunable.

Sesearch will return all rules, regardless of being conditional or
unconditional.  However, currently it does not tell you that a rule is
conditional (what the Boolean expression is for the rule).

> sesearch -A -t jcdx_icm_var_t /etc/selinux/mls/modules/active/base.pp
> /etc/selinux/mls/modules/active/modules/*pp
> ...
>    allow nfsd_t { file_type -shadow_t } : dir { ioctl read getattr
> lock search } ;
>    allow nfsd_t { file_type -shadow_t } : file { ioctl read getattr lock } ;
>    allow nfsd_t { file_type -shadow_t } : dir { getattr search } ;
> ...
> 
> --
> 
> getsebool -a | grep nfs_export_all_rw
> nfs_export_all_rw --> off
> 
> --
> 
> tunable_policy(`nfs_export_all_rw',`
>         fs_read_noxattr_fs_files(nfsd_t)
>         dev_getattr_all_blk_files(nfsd_t)
>         dev_getattr_all_chr_files(nfsd_t)
>         auth_manage_all_files_except_shadow(nfsd_t)
>         #unprivuser_home_dir_filetrans_home_content(nfsd_t, { file dir })
> ')
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
