Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Flood Randy Capt AFCA/TCAA" <randy.flood@scott.af.mil>,
        <SELinux@tycho.nsa.gov>
Subject: Re: setting up new test user domain?
Date: Thu, 20 Dec 2001 12:54:11 +0100
References: <1BF4DDD78DDA5D4EB0769BEA7F158E5A6F3893@amcw2ms812.amc.ds.af.mil>
In-Reply-To: <1BF4DDD78DDA5D4EB0769BEA7F158E5A6F3893@amcw2ms812.amc.ds.af.mil>
MIME-Version: 1.0
Message-Id: <20011220115411.C5C7017A6C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 Dec 2001 20:18, Flood Randy Capt AFCA/TCAA wrote:
> But, under certain circumstances, chrooted jails can be broken out of.
> Right?
>
> For example, see:
>
> http://www.bpfh.net/simes/computing/chroot-break.html
>
> Is this information dated?  Is chroot really more reliable now?  Isn't
> the whole concept of type enforcement to give an additional layer of
> security in such cases?

I think that information is still current.

However please note that only root can do chroot().  So if you have 
permissions to do chroot() then you can also mount the proc file system, use 
it to discover what the root device is, do an mknod of a matching device 
file, and then get raw access to the file system.

Or if you have devfs compiled in then you can mount it under the chroot and 
get access to the device nodes.

For good security programs in a chroot() environment should be blocked from 
mount() and chroot() system calls.

To get this use the GRSecurity patch for Linux 2.4.x 
http://www.grsecurity.net/ .  However please note that at this time it's 
incompatible with LSM...

I'm about to write a message to the author requesting that it work with LSM 
(but it'll be some significant coding for them and won't be done quickly).

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
