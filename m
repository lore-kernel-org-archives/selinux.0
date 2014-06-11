Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5B7B4we026356
 for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2014 03:11:04 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so7074357pbb.41
 for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2014 00:11:04 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.84.82])
 by mx.google.com with ESMTPSA id ci4sm73197961pbb.50.2014.06.11.00.11.02
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 11 Jun 2014 00:11:03 -0700 (PDT)
Message-ID: <5398005F.60602@gmail.com>
Date: Wed, 11 Jun 2014 12:38:15 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Default context with context mount option.
References: <539477AF.20408@gmail.com> <5395B7E9.90304@tycho.nsa.gov>
 <5396BEC4.3000801@gmail.com> <5396F475.9030601@tycho.nsa.gov>
In-Reply-To: <5396F475.9030601@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/10/14 17:35, Stephen Smalley wrote:
> On 06/10/2014 04:16 AM, dE wrote:
>> On 06/09/14 19:04, Stephen Smalley wrote:
>>> On 06/08/2014 10:48 AM, dE wrote:
>>>> When a new file is created on a FS which supports security namespace but
>>>> the FS is mounted using context= option, then what will be the context
>>>> of the newly created file on the FS?
>>>>
>>>> I did exactly this, and next, umount and then mount the FS readonly to
>>>> get the getfattr dump to realize the security namespace is not empty
>>>> (this came as a surprise).
>>>>
>>>> So, can someone explain what exactly happens in this case?
>>> The kernel lies to you ;)
>>>
>>> If SELinux (or another security module that implements the
>>> inode_getsecurity and inode_listsecurity hooks) is enabled, then the
>>> security module gets to report its view of the security.* attributes to
>>> userspace instead of whatever may or may not be stored by the
>>> filesystem.  That allows SELinux to handle such requests even for
>>> filesystems that do not natively support the security.* namespace as
>>> well as remap attribute values as needed to deal with removed types or
>>> conversion from non-MLS to MLS policies or various other situations.
>> Yes, if I mount vfat for e.g. check the xattr using getfattr, there does
>> exist a security attribute. But these FSs are defined by genfscon.
>>
>> But about FSs which do support the security namespace (like XFS), and so
>> do not have a genfscon statement associated to them they but still have
>> a security namespace value (as reported by the kernel, which lies to
>> userspace).
>>
>> Question is -- are these values actually written to the FS or are they
>> just empty? Things get more confusing cause I get permission denied when
>> trying to delete the security namespace values.
> It shouldn't be written to the filesystem.  You can check by booting
> with SELinux disabled (selinux=0 on the kernel command-line or
> /etc/selinux/config SELINUX=disabled) and then running getfattr; then
> the kernel will just call down to the filesystem code to fetch the
> attribute without any interference by the security module.  However,
> note that this will trigger an automatic filesystem relabel upon reboot
> into SELinux to ensure that all files are labeled, which can take some time.
>
> With regard to removing the security.selinux attributes, SELinux also
> prohibits that entirely; see
> security/selinux/hooks.c:selinux_inode_removexattr() in the kernel.  So
> again, to do that, you'd have to boot with SELinux disabled, but it
> shouldn't be necessary.

So preventing removal of security namespace is hard coded into the kernel.

I booted off sysrescuecd to check the security context -- and no, there 
was no security context for the file.

Thanks for clarifying.
