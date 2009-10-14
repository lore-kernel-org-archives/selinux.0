Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9EDabnM031902
	for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2009 09:36:37 -0400
Received: from mail-px0-f201.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9EDcImw002657
	for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2009 13:38:18 GMT
Received: by pxi39 with SMTP id 39so1103897pxi.10
        for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2009 06:36:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1255526458.9995.63.camel@gorn.columbia.tresys.com>
References: <ddbc00640910131630l35dd9552g385a8df02771a464@mail.gmail.com>
	 <1255526458.9995.63.camel@gorn.columbia.tresys.com>
Date: Wed, 14 Oct 2009 06:36:34 -0700
Message-ID: <ddbc00640910140636y28b2aa8cw164e74fd0502476b@mail.gmail.com>
Subject: Re: sesearch question
From: Joe Nall <joe@nall.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 14, 2009 at 6:20 AM, Christopher J. PeBenito
<cpebenito@tresys.com> wrote:
> On Tue, 2009-10-13 at 16:30 -0700, Joe Nall wrote:
>> When I use sesearch I appear to be seeing allow rules that are in
>> tunables that are off. The rules below come from
>> auth_manage_all_files_except_shadow which is in a disabled tunable.
>
> Sesearch will return all rules, regardless of being conditional or
> unconditional.  However, currently it does not tell you that a rule is
> conditional (what the Boolean expression is for the rule).

Are there any command line tools that I can use on a production box to
show the current effective allow rules?

joe



>
>> sesearch -A -t jcdx_icm_var_t /etc/selinux/mls/modules/active/base.pp
>> /etc/selinux/mls/modules/active/modules/*pp
>> ...
>>    allow nfsd_t { file_type -shadow_t } : dir { ioctl read getattr
>> lock search } ;
>>    allow nfsd_t { file_type -shadow_t } : file { ioctl read getattr lock } ;
>>    allow nfsd_t { file_type -shadow_t } : dir { getattr search } ;
>> ...
>>
>> --
>>
>> getsebool -a | grep nfs_export_all_rw
>> nfs_export_all_rw --> off
>>
>> --
>>
>> tunable_policy(`nfs_export_all_rw',`
>>         fs_read_noxattr_fs_files(nfsd_t)
>>         dev_getattr_all_blk_files(nfsd_t)
>>         dev_getattr_all_chr_files(nfsd_t)
>>         auth_manage_all_files_except_shadow(nfsd_t)
>>         #unprivuser_home_dir_filetrans_home_content(nfsd_t, { file dir })
>> ')
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
