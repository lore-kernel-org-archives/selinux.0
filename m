Message-ID: <4856DC93.5000909@windriver.com>
Date: Mon, 16 Jun 2008 17:35:15 -0400
From: Vikram Ambrose <Vikram.Ambrose@windriver.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>, Eric Paris <eparis@parisplace.org>
Subject: Re: SELinux Bootstrap - without chroot
References: <4856998A.1020606@windriver.com>	 <1213639038.15523.141.camel@moss-spartans.epoch.ncsc.mil>	 <4856A941.9080300@windriver.com> <1213640369.15523.152.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1213640369.15523.152.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2008-06-16 at 13:56 -0400, Vikram Ambrose wrote:
>   
>> Stephen Smalley wrote:
>>     
>>> Note that they get installed to $DESTDIR/usr/share/selinux/$SELINUXTYPE
>>> by make install.  In Fedora, they are packaged as such, then when you
>>> install the package on the target host, they are unpacked
>>> to /usr/share/selinux/$SELINUXTYPE by the package manager and then a %
>>> post scriptlet runs semodule on them to install them under /etc/selinux
>>> and load them.
>>>
>>>   
>>>       
>> In Fedora, does anaconda chroot into the sysroot and call semodule 
>> during installation?
>>     
>
> Some combination of anaconda and rpm, yes.  semodule runs from a %post
> scriptlet in the selinux-policy-targeted package at package install
> time.
>
>   
>>> Options for you might include:
>>> 1) Run semodule_link and semodule_expand at build time to link and
>>> expand the modules to a kernel policy up front.  Then you can just put
>>> the files into place without running semodule later.
>>>   
>>>       
>> I will investigate this option further, thank you.
>>     
>
> Ok.  You can see an example of it in the 'make validate' target,
> although that is just to check that they will link and expand
> successfully; it isn't used to install the policy normally and likely
> doesn't keep the final result around.
>
>   
I am getting a bit confused between "modular" and "monolithic", in both 
cases a policy.X file is needed to load the policy into the kernel, right?

and in the modular case, the policy.X file simply points to the various 
.pp files and in the monolithic case everything is in the policy.X file? 
Analogous to shared library and static library link (modular/monolithic)?


-- 
Vikram Ambrose | Linux Products Division | WindRiver Corporation


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
