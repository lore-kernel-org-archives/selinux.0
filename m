From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux@tycho.nsa.gov
Subject: Re: Another small SE presentation
Date: Thu, 11 Sep 2003 09:07:17 +1000
References: <20030909215414.K6475@lemuria.org> <3F5ED720.3090206@hotmail.com>
In-Reply-To: <3F5ED720.3090206@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309110907.17495.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 10 Sep 2003 17:47, James de Lurker wrote:
> Making each patch "self documenting", and a periodic "patch FAQ" that
> listed everything necessary in simple steps from the last kernel.org
> reference kernels ought to be posted to the list for folk that don't
> work from CVS. Where patches are distro dedicated ( Debian, SuSe, whatever)
> make that obvious at a glance. I've just downloaded Russell's patches
> to 2.4.22 and 2.6.0-test5 UML but am clueless if they will work with
> the RedHat base distributions, or are Debian dedicated, only. Obvious
> to Russell and other leading developers perhaps, but not to me!

I am employed by Red Hat and am making Red Hat policy a priority.

My policy always worked with Red Hat at least as well as the NSA policy, I 
only add features.

> I am dismayed by all the distribution forks. I've been a RedHat distro
> person (only) from 1998. Maybe their ought to be distro dedicated
> subscriber lists to carry regular HOWTO postings and distro dedicated
> traffic.

Currently there are Debian package repositories, so if you want to install SE 
Linux on Debian it's not too difficult.  Faye has written a HOWTO which 
explains this among other issues.

Red Hat work is progressing well.  I hope that soon we will have some official 
RPMs that we can release.

> testing stuff on older kit - XFree86 driver rewrites have rendered (sic)
> graphical interfaces useless on many of my legacy PCI video boxes, so all
> my software development and building is still done on RedHat 7.x desktops.

If you use the fbdev X server and VESAFB then it should work on all PCI 
machines.  The VESA interface came in at about the same time as PCI.

> The issue on the list recently of segfaulting due to weird sub-arch
> glibc updating issues is a case in point. How many people ( like me )
> will call it a day when they end up with a dead end broken system;
> repeating the same mistakes that others have already unwittingly made?

At the moment the modified libc6 is an optional feature, especially if you 
don't give root access to hostile users.

> Currently, I am just putting the finishing touches to a RedHat 9 command
> line only full updated base system ready to put on the latest 2.6.0-t5
> kernel with Russell's one liner patch... Hope that it works!! Wish it

My 2.6.0-test5 patch is only needed for UML.  I've never booted a 2.6 kernel 
on a non-UML system...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
