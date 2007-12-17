Subject: Re: load_policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30712170827t67aa7760m879573601e56ad9f@mail.gmail.com>
References: <dd18b0c30712170827t67aa7760m879573601e56ad9f@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 17 Dec 2007 14:16:10 -0500
Message-Id: <1197918970.17307.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-12-17 at 08:27 -0800, Justin Mattock wrote:
> Hello I am new to selinux and seem to be at a road block. If anybody
> has any info on  my situation it would be appreciative.
> The problem I have is the policy isn't loading at boot time.  putting
> load_policy in /etc/rc.local gives me a please choose a security
> context; when choosing sysadm_r sysadm_t response is invalid security
> context. Then looking into init I see this 
> ldd /sbin/init
>      linux-gate.so.1 => (oxffffe000)                          
>      libc.so.6 => /lib/libc.so.6 (0xb7e73000)
> <----no /lib/libselinux.so.1 (how to add libselinux to init?)
>      /lib/ld- linux.so.2 (0xb7fca000)                     
> 
> could this be why selinux_init_load_policy doesnt work?  
> any info would be helpful.

I'm not sure I understand what you are asking.

In Fedora and Debian, System V init has been modified to perform the
initial loading of security policy and to then re-exec itself into the
proper domain.

In Ubuntu, they don't use System V init, and there has been recent work
to add a -i option to load_policy to perform the initial policy load so
that load_policy can be run from initramfs before upstart is executed.
See prior postings by Chad Sellers.

Running load_policy from a rc script should technically work (as far as
actually loading a policy into the kernel), but it doesn't help with
processes that have already started - those will keep running in
kernel_t rather than being placed into the proper domain.  You need to
load policy earlier.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
