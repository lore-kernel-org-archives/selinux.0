From: gawain.lynch@felicity-consulting.com.au
To: SELinux@tycho.nsa.gov
Subject: Re: Problem in installation...
MIME-Version: 1.0
Message-ID: <OF47CED767.27D7E95D-ONCA256A1D.007D6A98@felicity.net.au>
Date: Thu, 29 Mar 2001 08:57:41 +1000
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I tracked one of the problems down.  A lot of people, myself included seem 
to be trying to compile with Red Hat 7. 

The RH7 install is missing egcs (provides 
/usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/), which I installed off 
my RH6.2 CD, _reinstalled_ the updated gcc and no more stddef.h error!

I still can't give anymore reasons as to the tools/build-kernel script 
fails, but it will work if you have run make dep and commented that action 
out of the script.

Cheers,

Gawain





Stephen Smalley <sds@tislabs.com>
Sent by: owner-selinux@tycho.nsa.gov
03/29/01 06:59 AM

 
        To:     Rajan Ravindran <rajancr@us.ibm.com>
        cc:     SELinux@tycho.nsa.gov
        Subject:        Re: Problem in installation...



Several people have reported problems using the build-kernel script,
but they haven't identified the exact nature of the problem, and
it doesn't seem to occur on our RedHat 6.1 systems.  Try expanding
a clean copy of the release and building the kernel by hand, e.g.

tar xzf slinux-200103151617-release.tgz
cd slinux
ln -sf kernel-2.4 kernel
cd kernel
make xconfig
                 (Configure the kernel appropriately for your hardware.)
make dep
make 
make modules

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


On Wed, 28 Mar 2001, Rajan Ravindran wrote:

> 
> Hi,
> I started installing the security-enchanced linux as per the
> procedure mentioned in
> 
> http://www.nsa.gov/selinux/doc/install.html
> 
> While building the kernel by running
> 
> ./tools/build-kernel
> 
> i'm getting an error "stddef.h not found", this
> happening while running make xconfig itself (stddef.h is present
> in kernel/linux/include directory). If anyone
> knows the solution for this problem, please let me know.




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
