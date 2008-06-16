Message-ID: <4856A941.9080300@windriver.com>
Date: Mon, 16 Jun 2008 13:56:17 -0400
From: Vikram Ambrose <Vikram.Ambrose@windriver.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>, Eric Paris <eparis@parisplace.org>
Subject: Re: SELinux Bootstrap - without chroot
References: <4856998A.1020606@windriver.com> <1213639038.15523.141.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1213639038.15523.141.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2008-06-16 at 12:49 -0400, Vikram Ambrose wrote:
>   
>> Without a chroot environment, How does one go about building/installing, 
>> well basically the entire process including the bootstrap in a self 
>> contained build directory?
>>
>> I have been playing with refpolicy. And from what I have learned, 
>> refpolicy allows you to define a LOCAL_ROOT but none of the selinux 
>> userspace tools allow you to make use of a folder other than 
>> /etc/selinux as that path is hard coded in all the source files.
>>
>> In essence I want to know how to build a policy and tar it up, extract 
>> it into a target rootfs and simply call "load_policy" to use it.
>>     
>
> I'm not sure LOCAL_ROOT is what you think it is; there is a DESTDIR
> definition though that gets used by the Fedora policy package build.
> Looks like there is even a TEST_TOOLCHAIN definition although I haven't
> used that one and it would have the same problems with libsemanage
> helpers that you ran into earlier.
>   
Yes sorry, i meant to say DESTDIR
> Note that they get installed to $DESTDIR/usr/share/selinux/$SELINUXTYPE
> by make install.  In Fedora, they are packaged as such, then when you
> install the package on the target host, they are unpacked
> to /usr/share/selinux/$SELINUXTYPE by the package manager and then a %
> post scriptlet runs semodule on them to install them under /etc/selinux
> and load them.
>
>   
In Fedora, does anaconda chroot into the sysroot and call semodule 
during installation?
> Options for you might include:
> 1) Run semodule_link and semodule_expand at build time to link and
> expand the modules to a kernel policy up front.  Then you can just put
> the files into place without running semodule later.
>   
I will investigate this option further, thank you.
> 2) Build monolithic policy instead of modular policy.  Then there is no
> intermediate step and no use of semodule*.
>
>   
I would like to use a modular build.
> You don't really want to load the policy on the build host, do you?
> That's not a good idea - it will disturb the functioning of the build
> host, and you still need to restart userspace to get everything into the
> right domain.
>
>   
No I dont want to load the policy on the build host, sorry for that 
confusion.


-- 
Vikram Ambrose | Linux Products Division | WindRiver Corporation


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
