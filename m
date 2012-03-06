Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q26FVTkn027052
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2012 10:31:29 -0500
Received: by iaoo28 with SMTP id o28so7809112iao.12
        for <selinux@tycho.nsa.gov>; Tue, 06 Mar 2012 07:31:28 -0800 (PST)
MIME-Version: 1.0
Reply-To: hanwen@xs4all.nl
In-Reply-To: <4F560C02.3020805@tresys.com>
References: <CAOw_e7YkXECVOO9JnP0FvWYMpdZ2PzPBQwEy3ppCd4GcVnwfEw@mail.gmail.com>
	<4F560C02.3020805@tresys.com>
Date: Tue, 6 Mar 2012 12:31:27 -0300
Message-ID: <CAOw_e7Zhb1080TGr2nLxJJz_Zga70TrybZp404THpChs8hthpA@mail.gmail.com>
Subject: Re: Suppressing selinux label getxattrs on FUSE
From: Han-Wen Nienhuys <hanwenn@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Mar 6, 2012 at 10:07 AM, Christopher J. PeBenito
<cpebenito@tresys.com> wrote:
> On 03/06/12 06:51, Han-Wen Nienhuys wrote:
>> Hi there,
>>
>> What is the best way to stop to SELinux from trying read ACL security
>> labels for (FUSE) mounts?
>>
>> Background:
>>
>> From what I read, Selinux is not really working on FUSE filesystems,
>> however, when I run a FUSE filesystem, I see various GETXATTR calls
>> passing by asking for
>
> SELinux uses the security.selinux xattr.
>
>> security.capability
>
> I'm guessing this is for fs capabilities.
>
>> system.posix_acl_default
>> system.posix_acl_access
>
> POSIX ACL.
>
> You'd presumably have to disable these mechanisms to eliminate this access.

Would you have some pointers to background on these mechanisms?  Sorry
for the newbie-ish question.

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
