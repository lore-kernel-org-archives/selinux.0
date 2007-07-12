MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Libsemanage dependency on version of Linux...
Date: Thu, 12 Jul 2007 15:48:11 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D03C0A78D@de01exm68.ds.mot.com>
In-Reply-To: <1184269199.3392.338.camel@moss-spartans.epoch.ncsc.mil>
References: <20070521095414.832619201@tresys.com> <1180137749.10334.18.camel@localhost.localdomain> <4677F1BC.2000201@tresys.com> <1182443353.11527.50.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588D01904@exchange.columbia.tresys.com> <1182449086.11527.80.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588D01920@exchange.columbia.tresys.com> <1182449898.11527.83.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588D01928@exchange.columbia.tresys.com> <1182450900.11527.88.camel@localhost.localdomain> <467AE59E.2050501@tycho.nsa.gov> <1182525734.3014.20.camel@localhost.localdomain> <467BFF99.9000404@tycho.nsa.gov> <1182540624.6599.5.camel@localhost.localdomain> <467C3728.6070803@tycho.nsa.gov>  <468904FA.7030102@tresys.com> <1183386217.16330.0.camel@localhost.locald! omain> <46896D88.7060504@tresys.com> <1183425133.32465.16.camel@code.and.org> <468A2FE2.5000903@aus-city.com> <1183464455.12218.243.camel@moss-spartans.epoch.ncs! c.mil> <468C2D9!
 ! 5.20108
	01 @aus-city
	.co m> <1183638838.12218.334.camel@moss-spartans.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D03C0A72F@de01exm68.ds.mot.com> <1184269199.3392.338.camel@moss-spartans.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks Stephen,

So given the fact that I must use Linux Kernel 2.6.14  :

Are you saying that its okay for us to upgrade SELinux libs FROM  the
versions listed below TO the versions listed below while continuing to
use Linux Kernel 2.6.14 ?  In other words, the newer versions of the
SELinux-related libs DON'T depend on the version of the Linux kernel ?
I would like to upgrade the libs as described below, but I fear that the
new libs versions may not work correctly with Linux 2.6.14.

Please confirm...


libsemanage-1.6.17-1     =>  libsemanage-1.10.4
checkpolicy-1.33.1-2     =>  checkpolicy-1.34.3-x
libsepol-1.15.3-1        =>  libsepol-1.16.3-x
libselinux-1.33.4-2      =>  libselinux-1.34.10-x
policycoreutils-1.34.1-4 =>  policycoreutils-1.34.10-x 

Thanks,

- Rezaul.


-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Thursday, July 12, 2007 2:40 PM
To: Hasan Rezaul-CHR010
Cc: SE Linux
Subject: Re: Libsemanage dependency on version of Linux...

On Thu, 2007-07-12 at 15:03 -0400, Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> I currently am running on Linux 2.6.14,  and I have
> libsemanage-1.6.17-1
> 
> After discussing with Stephen Smalley, I learned that in order for
> semanage to NOT create a "/previous" directory, I need to upgrade my
> libsemanage library to version   1.9.2  or higher.
> 
> My question is:  is libsemanage version 1.9.2  dependent on a Linux
> version newer than Linux 2.6.14 ???
> 
> What is the latest version of libsemanage that is supported in Linux
> version 2.6.14 ?
> 
> Also, what are the latest versions of the following other libs
> supported by Linux 2.6.14 : ?
> 
> checkpolicy 
> libsepol 
> libselinux 
> Policycoreutils

Hi,

You should generally upgrade all of the core SELinux userland components
together to be safe, but newer versions of the SELinux core userland
should work fine on older kernels (at least for the stable branch).

You may wish to set the policy-version in
your /etc/selinux/semanage.conf file though to make sure that it is
generating the right policy version for your kernel (as reported by
cat /selinux/policyvers), especially if you are using an older SysVinit
that doesn't use the newer policy loading logic with automatic
downgrading.

-- 
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
