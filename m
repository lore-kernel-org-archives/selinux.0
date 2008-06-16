Message-ID: <4856998A.1020606@windriver.com>
Date: Mon, 16 Jun 2008 12:49:14 -0400
From: Vikram Ambrose <Vikram.Ambrose@windriver.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: SELinux Bootstrap - without chroot
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Without a chroot environment, How does one go about building/installing, 
well basically the entire process including the bootstrap in a self 
contained build directory?

I have been playing with refpolicy. And from what I have learned, 
refpolicy allows you to define a LOCAL_ROOT but none of the selinux 
userspace tools allow you to make use of a folder other than 
/etc/selinux as that path is hard coded in all the source files.

In essence I want to know how to build a policy and tar it up, extract 
it into a target rootfs and simply call "load_policy" to use it.

thanks.

-- 
Vikram Ambrose | Linux Products Division | WindRiver Corporation


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
