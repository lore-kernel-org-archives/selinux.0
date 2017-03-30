MIME-Version: 1.0
Sender: tomeu.vizoso@gmail.com
In-Reply-To: <20170329213439.GC19617@parsley.fieldses.org>
References: <20170329152724.19030-1-tomeu.vizoso@collabora.com>
 <20170329213439.GC19617@parsley.fieldses.org>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Thu, 30 Mar 2017 09:49:07 +0200
Message-ID: <CAAObsKDThPAQpgO7R+JT=foU1=BEor-Zy7DES2tnGe=rGe=REw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Fix SBLABEL_MNT for NFS mounts
To: "J. Bruce Fields" <bfields@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 29 March 2017 at 23:34, J. Bruce Fields <bfields@redhat.com> wrote:
> On Wed, Mar 29, 2017 at 05:27:23PM +0200, Tomeu Vizoso wrote:
>> Labelling of files in a NFSv4.2 currently fails with ENOTSUPP because
>> the mount point doesn't have SBLABEL_MNT.
>>
>> Add specific condition for NFS4 filesystems so it gets correctly
>> labeled.
>
> Huh.  Looking at the code, I think this is meant to be handled by the
> SECURITY_FS_USE_NATIVE case--there was a similar failure fixed some time
> ago by 9fc2b4b436cf.  What kernel are you seeing this on?  Is it a
> recent regression (in which case, what's the latest kernel that worked
> for you)?

I have seen this on 4.11-rc4, but I never tried to get this working before.

I will try to find time to see why SECURITY_FS_USE_NATIVE isn't working here.

Thanks,

Tomeu

> --b.
>
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> Cc: J. Bruce Fields <bfields@redhat.com>
>>
>> ---
>>
>> Hi,
>>
>> cannot remotely say that I currently understand how selinux is expected
>> to work within NFS mounts, but this change allowed me to fully boot AOSP
>> with its rootfs and ramdisk on a single NFS share.
>>
>> Thanks,
>>
>> Tomeu
>> ---
>>  security/selinux/hooks.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 0c2ac318aa7f..71cd1d8c67c2 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -485,6 +485,7 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
>>               !strcmp(sb->s_type->name, "debugfs") ||
>>               !strcmp(sb->s_type->name, "tracefs") ||
>>               !strcmp(sb->s_type->name, "rootfs") ||
>> +             !strcmp(sb->s_type->name, "nfs4") ||
>>               (selinux_policycap_cgroupseclabel &&
>>                (!strcmp(sb->s_type->name, "cgroup") ||
>>                 !strcmp(sb->s_type->name, "cgroup2")));
>> --
>> 2.9.3
>>
