Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4SMXKHF000552
	for <selinux@tycho.nsa.gov>; Thu, 28 May 2009 18:33:20 -0400
Received: from mail-qy0-f134.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4SMXDVa012751
	for <selinux@tycho.nsa.gov>; Thu, 28 May 2009 22:33:13 GMT
Received: by qyk40 with SMTP id 40so252865qyk.32
        for <selinux@tycho.nsa.gov>; Thu, 28 May 2009 15:33:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A1D23C8.6010300@redhat.com>
References: <4A1D10AE.7020009@flumotion.com> <4A1D23C8.6010300@redhat.com>
Date: Thu, 28 May 2009 18:33:19 -0400
Message-ID: <7e0fb38c0905281533q260224c2mfb16143997f1c525@mail.gmail.com>
Subject: Re: Problem with SELinux and glusterfs when trying to allow
	memprotect/mmap_zero
From: Eric Paris <eparis@parisplace.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ioannis Aslanidis <iaslanidis@flumotion.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 27, 2009 at 7:28 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> On 05/27/2009 06:06 AM, Ioannis Aslanidis wrote:
>>
>> Hello,
>>
>> I am trying to allow the following audit message through, but it says
>> that there is a violation. Can anyone explain what exactly is going on?
>>
>> Thank you,
>>
>> Ioannis
>>
>> # cat messages.audit
>> May 27 01:51:13 streamer012 kernel: audit(1243381873.876:60): avc:
>> denied  { mmap_zero } for  pid=3155 comm="glusterfs2"
>> scontext=system_u:system_r:mount_t:s0
>> tcontext=system_u:system_r:mount_t:s0 tclass=memprotect
>>
>>
>> # cat selinuxglusterfs.te
>>
>> module selinuxglusterfs 1.0;
>>
>> require {
>>        type mount_t;
>>        class memprotect mmap_zero;
>> }
>>
>> #============= mount_t ==============
>> allow mount_t self:memprotect mmap_zero;
>>
> Add
> domain_mmap_low_type(mount_t)
> Will make this problem go away.  But I don't beleieve glusetfs should be
> causing the mount command to need to mmap_zero.  Seems like a kernerl
> problem.

Come on now, don't blame the kernel for enforcing things.

If I had to guess the mount command is calling a helper application
which is stupidly doing

mmap(NULL, MAP_FIXED ....)

And it is this mount helper program that should be fixed.  Do you have
an /sbin/mount.glusetfs ?

You very very very likely don't need this permission, you need to fix
the app....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
