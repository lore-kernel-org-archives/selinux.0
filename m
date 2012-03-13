MIME-Version: 1.0
In-Reply-To: <1331561492.20879.15.camel@moss-pluto>
References: <CANvtKVZJ7EU3N8M=NMROtmyTKs+VUCZyMT9uJtNmraK7rz-fAA@mail.gmail.com>
	<1331561492.20879.15.camel@moss-pluto>
Date: Tue, 13 Mar 2012 15:09:21 +0800
Message-ID: <CANvtKVbggKFjczrwY+KzmdBMUe+De1ATJOPKP51A_32VbWE+tg@mail.gmail.com>
Subject: Re: [PATCH] libselinux init functions
From: Xin Ouyang <xinpascal@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2012/3/12 Stephen Smalley <sds@tycho.nsa.gov>:
> On Mon, 2012-03-12 at 18:17 +0800, Xin Ouyang wrote:
>> Hi all,
>>
>> I am working on the newest release of SELinux userspace packages and
>> sysvinit, and find there are a defect for init function of libselinux.
>>   * libselinux-2.1.9
>>   * sysvinit-2.88dsf
>>
>> AFAIK, while sysvinit is configured with SELinux, /sbin/init would be
>> linked to libselinux. So before /sbin/init running, init_selinuxmnt()
>> would be called.
>>
>> // libselinux-2.1.9/src/init.c
>>
>> static void init_lib(void) __attribute__ ((constructor));
>> static void init_lib(void)
>> {
>>         selinux_page_size = sysconf(_SC_PAGE_SIZE);
>>         init_selinuxmnt();
>> }
>>
>> As called before /sbin/init, init_selinuxmnt() is called before any
>> other userspace process.
>> At this time, procfs(/proc) and selinuxfs(/sys/fs/selinux or /selinux)
>> have not been mounted, because kernel do not mount them.
>>
>> So, after init_lib() -> init_selinuxmnt(), global variable
>> "selinux_mnt" is still null.
>>
>> /sbin/init would call is_selinux_enabled() to check whether selinux
>> enabled. Because "selinux_mnt" is null, is_selinux_enabled() always
>> return 0.
>
> /sbin/init isn't supposed to call is_selinux_enabled() before calling
> selinux_init_load_policy(), as is_selinux_enabled() will always return 0
> if policy has not yet been loaded.  That has always been true.  Sounds
> like you have an incorrect selinux patch for your sysvinit.

So, you mean is_selinux_enabled() is not equal to the cmdline
"selinux=1" passed to kernel, it just equal to
"is_selinux_policy_loaded".

Sorry I got it wrong.

Therefore, selinux_init_load_policy() would be always be called at
/sbin/init's first running, to check if "selinux=1" passed to kernel
and load policy.

Thank you, Stephen. :)

- Pascal

>
> selinux_init_load_policy() internally tests whether SELinux is enabled
> in the kernel (by trying to mount selinuxfs)  and will correctly return
> -1 with *enforce set to 0 so that the caller knows to proceed despite
> the failure to load.
>
> Certainly the Debian sysvinit did it correctly in the past, as did the
> Fedora sysvinit (back when Fedora used sysvinit).
>
> --
> Stephen Smalley
> National Security Agency
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
