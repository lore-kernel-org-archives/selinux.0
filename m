Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9EEtvMo013301
	for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2009 10:55:57 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9EEvbmw005672
	for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2009 14:57:38 GMT
Message-ID: <4AD5E676.6070009@redhat.com>
Date: Wed, 14 Oct 2009 10:55:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: sesearch question
References: <ddbc00640910131630l35dd9552g385a8df02771a464@mail.gmail.com>	 <1255526458.9995.63.camel@gorn.columbia.tresys.com> <ddbc00640910140636y28b2aa8cw164e74fd0502476b@mail.gmail.com>
In-Reply-To: <ddbc00640910140636y28b2aa8cw164e74fd0502476b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/14/2009 09:36 AM, Joe Nall wrote:
> On Wed, Oct 14, 2009 at 6:20 AM, Christopher J. PeBenito
> <cpebenito@tresys.com> wrote:
>> On Tue, 2009-10-13 at 16:30 -0700, Joe Nall wrote:
>>> When I use sesearch I appear to be seeing allow rules that are in
>>> tunables that are off. The rules below come from
>>> auth_manage_all_files_except_shadow which is in a disabled tunable.
>>
>> Sesearch will return all rules, regardless of being conditional or
>> unconditional.  However, currently it does not tell you that a rule is
>> conditional (what the Boolean expression is for the rule).
> 
> Are there any command line tools that I can use on a production box to
> show the current effective allow rules?
> 
> joe
> 
> 
> 
sesearch -A -C -t  TYPE
Will show you the rules with booleans.  You could eliminate all lines with booleans turned off via a script.

BTW Our version of setools has bython bindings that would allow you to do write a tool in python.  Sadly upstream has not accepted the patch

import setools



>>
>>> sesearch -A -t jcdx_icm_var_t /etc/selinux/mls/modules/active/base.pp
>>> /etc/selinux/mls/modules/active/modules/*pp
>>> ...
>>>    allow nfsd_t { file_type -shadow_t } : dir { ioctl read getattr
>>> lock search } ;
>>>    allow nfsd_t { file_type -shadow_t } : file { ioctl read getattr lock } ;
>>>    allow nfsd_t { file_type -shadow_t } : dir { getattr search } ;
>>> ...
>>>
>>> --
>>>
>>> getsebool -a | grep nfs_export_all_rw
>>> nfs_export_all_rw --> off
>>>
>>> --
>>>
>>> tunable_policy(`nfs_export_all_rw',`
>>>         fs_read_noxattr_fs_files(nfsd_t)
>>>         dev_getattr_all_blk_files(nfsd_t)
>>>         dev_getattr_all_chr_files(nfsd_t)
>>>         auth_manage_all_files_except_shadow(nfsd_t)
>>>         #unprivuser_home_dir_filetrans_home_content(nfsd_t, { file dir })
>>> ')
>>>
>>> --
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>> the words "unsubscribe selinux" without quotes as the message.
>> --
>> Chris PeBenito
>> Tresys Technology, LLC
>> (410) 290-1411 x150
>>
>>
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
