Date: Mon, 26 Mar 2001 08:57:44 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Hubertus Franke <frankeh@us.ibm.com>
cc: SELinux@tycho.nsa.gov
Subject: Re: your mail
In-Reply-To: <OFC8827216.E70119F9-ON85256A18.007CF1F0@pok.ibm.com>
Message-ID: <Pine.SOL.3.95.1010326085159.1077B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


These header files should be automatically generated during
the build.  I just tried again with a clean copy of the release
on my RedHat 6.1 system, and it built without any problems.
Try expanding a clean copy of the release and building the
kernel by hand rather than using the build-kernel script, i.e.

tar xzf slinux-200103151617-release.tgz
cd slinux
ln -sf kernel-2.4 kernel
cd kernel
make xconfig or make menuconfig or make config
	(Configure the kernel appropriately.)
make dep
make 
make modules

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


On Fri, 23 Mar 2001, Hubertus Franke wrote:

> just downloaded the SELinux for 2.4.
> 
> I did the ./tools/build-kernel  and get the following errors.
> 
> 
> /home/frankeh/slinux/kernel/include/linux/flask/avc.h:13:31:
> linux/flask/flask.h: No such file or directory
> 
> 
> /home/frankeh/slinux/kernel/include/linux/flask/security.h:49:32:
> config/flask/audit.h: No such file or directory
> 
> Looks like various files are missing in the distribution.
> Any ideas ?
> 
> 
> Hubertus Franke
> Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
> , OS-PIC (Chair)
> email: frankeh@us.ibm.com
> (w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003
> 
> 
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
