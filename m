Message-ID: <655108679.1073882102217.JavaMail.osg@spnode33>
Date: Sun, 11 Jan 2004 23:35:02 -0500 (EST)
From: "PORTER,CHRISTOPHER B" <console@ufl.edu>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: Module problems after 2.4 upgrade
Cc: SELinux@tycho.nsa.gov
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm not familiar with the process of or need to relabel that 
directory. After compiling the kernel to a floppy disk I did "make 
modules" and "make modules_install", which both seemed to work. 
I'm a bit boggled as to why the system then can't find the modules 
when it can if I simply remove the floppy and boot from the non-SE 
kernel. In other words, the configuration files haven't changed.


Thanks for the suggestion though,


Christopher Porter
console@ufl.edu

On Sun Jan 11 17:04:24 EST 2004, Thomas Bleher 
<bleher@informatik.uni-muenchen.de> wrote:

> * "PORTER,CHRISTOPHER B" <console@ufl.edu> [2004-01-11 22:46]:
>> KERNEL: 2.4.20-8
>> OS: Redhat 9 (Shrike)
>> 
>> I've installed the SE kernel, done make bzdisk, and done make 
>> modules and make modules_install. Everything exited 
>> successfully, and the floppy boots fine. However, when the 
>> system goes to start various services and load modules, I get a 
>> range of problems such as those that follow:
>> 
>> "modprobe: Can't locate module ..."
>> 
>> "Do you need to install insmod?"
>> 
>> I double-checked and made sure that loadable module support WAS 
>> compiled in. I tried once before to grab new modutils but it 
>> didn't pan out. Any suggestions or known problems?
>  Have you relabeled your /lib/modules? Only matters if you boot 
> up in
> enforcing mode, which is not clear from your message.
> 
> Just a random thought, because I stumbled over this two times 
> today.
> 
> Friendly,
> Thomas
> 
> --
> This message was distributed to subscribers of the selinux 
> mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 



--
PORTER,CHRISTOPHER B


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
