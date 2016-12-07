Subject: Re: Why do we block context="foobar" from User Namespace
To: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>
References: <90ddcce6-a5eb-b05e-a347-ec8ef5c47db1@redhat.com>
 <111a91e7-907d-6502-5715-ba8d8f3a850c@tycho.nsa.gov>
 <CAHC9VhQVxgPfSA49VUN6Y0swsujA6V03AqkcNyoJ0HpOTjQoMQ@mail.gmail.com>
 <bd954799-5baa-7701-9af2-0b2c5f5dbf54@tycho.nsa.gov>
 <52e000a8-1816-19c5-b70c-5998f85cf970@tycho.nsa.gov>
Cc: Seth Forshee <seth.forshee@canonical.com>, SELinux <selinux@tycho.nsa.gov>,
 "Eric W. Biederman" <ebiederm@redhat.com>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <1a03d6be-e03d-1745-5022-a1b39b27cf81@redhat.com>
Date: Wed, 7 Dec 2016 17:05:22 -0500
MIME-Version: 1.0
In-Reply-To: <52e000a8-1816-19c5-b70c-5998f85cf970@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 12/07/2016 10:47 AM, Stephen Smalley wrote:
> On 12/07/2016 10:30 AM, Stephen Smalley wrote:
>> On 12/06/2016 07:19 PM, Paul Moore wrote:
>>> On Tue, Dec 6, 2016 at 3:31 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 12/06/2016 03:04 PM, Daniel J Walsh wrote:
>>>>> Currently in SELinux and UserNamespace can not be enabled with Docker/runc at the same time.
>>>>>
>>>>> Runc mounts tmpfs directories with --context="system_u:object_r:container_file_t:s0:c1,c2" type labels
>>>>> but the following patch blocks the use of context mounts when using user namespace.
>>>>>
>>>>> http://kernel.suse.com/cgit/kernel/commit/?id=aad82892af261b9903cc11c55be3ecf5f0b0b4f8
>>>>>
>>>>> User Namespace has to be established before tmpfs are mounted so we are unable to mount a
>>>>> tmpfs with a context=flag and UserNamespace enabled.
>>>>>
>>>>> Controlling the ability to change the label of a mounted file systemd should be a MAC decision not a DAC,
>>>>> or UserNamespace. Setting the SELinux labels on an object like a file system mount point
>>>>> should be controlled by SELinux.  SELinux should check if the label of the process doing the
>>>>> mount is able to relabel from the label of the mount point, and labelto the specified label.
>>>>>
>>>>> SELinux does this for privileged processes (running with SYS_ADMIN) so use namespace should not be
>>>>> any different.  Also the process doing the mount would be allowed by DAC to set the label of the tmpfs after
>>>>> it is mounted (As long as SELinux allowed).
>>>>>
>>>>> There is no security difference between:
>>>>>
>>>>> mount -o tmpfs context="foobar" none /dev
>>>>>
>>>>>
>>>>> And
>>>>>
>>>>> mount -o tmpfs none /dev
>>>>>
>>>>> chcon foobar -R /dev
>>>>>
>>>>>
>>>>> The second would not be blocked by usernamespace.
>>>>>
>>>>> Bottom line this patch should be reverted so container runtimes like docker can use both User Namespace
>>>>> and SELinux at the same time.
>>>> I doubt we want to revert it entirely.  Looks like Smack has an explicit
>>>> exemption for tmpfs/ramfs (and sysfs, but it wouldn't really make sense
>>>> to do it there).  We could do something similar.
>>> Yes, I still think the restriction makes sense for persistent
>>> filesystems, but for things like tmpfs it does seem silly.
>> Looking further at this, the set of filesystems that presently allow
>> userns mounting are mqueue, tmpfs, cgroup/cgroup2, sysfs, ramfs, proc,
>> and devpts.  I could see allowing context mounts for mqueue, tmpfs,
>> ramfs, and devpts within the user namespace.  For cgroup/cgroup2, sysfs
>> and proc we don't want the process to be able to override the
>> policy-defined labels.  Make sense?
> Sorry, never mind about mqueue - unless the process is also in its own
> IPC namespace, that could allow it to effectively relabel existing
> mqueues.  So only tmpfs, ramfs, and devpts seem to be safe in this regard.
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
That works for me.  The mqueue one we might have to visit later.  I
think docker and
user namespace with mqueue is currently a problem.
