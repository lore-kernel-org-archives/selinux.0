Subject: RE: Libsemanage dependency on version of Linux...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D03C0A78D@de01exm68.ds.mot.com>
References: <20070521095414.832619201@tresys.com>
	 <1180137749.10334.18.camel@localhost.localdomain>
	 <4677F1BC.2000201@tresys.com>
	 <1182443353.11527.50.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588D01904@exchange.columbia.tresys.com>
	 <1182449086.11527.80.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588D01920@exchange.columbia.tresys.com>
	 <1182449898.11527.83.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588D01928@exchange.columbia.tresys.com>
	 <1182450900.11527.88.camel@localhost.localdomain>
	 <467AE59E.2050501@tycho.nsa.gov>
	 <1182525734.3014.20.camel@localhost.localdomain>
	 <467BFF99.9000404@tycho.nsa.gov>
	 <1182540624.6599.5.camel@localhost.localdomain>
	 <467C3728.6070803@tycho.nsa.gov>  <468904FA.7030102@tresys.com>
	 <1183386217.16330.0.camel@localhost.locald! omain>
	 <46896D88.7060504@tresys.com> <1183425133.32465.16.camel@code.and.org>
	 <468A2FE2.5000903@aus-city.com>
	 <1183464455.12218.243.camel@moss-spartans.epoch.ncs! c.mil>
	 <468C2D9! ! 5.20108 01 @aus-city .co m>
	 <1183638838.12218.334.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D03C0A72F@de01exm68.ds.mot.com>
	 <1184269199.3392.338.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D03C0A78D@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Thu, 12 Jul 2007 15:57:56 -0400
Message-Id: <1184270276.3392.350.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-07-12 at 15:48 -0400, Hasan Rezaul-CHR010 wrote:
> Thanks Stephen,
> 
> So given the fact that I must use Linux Kernel 2.6.14  :
> 
> Are you saying that its okay for us to upgrade SELinux libs FROM  the
> versions listed below TO the versions listed below while continuing to
> use Linux Kernel 2.6.14 ?  In other words, the newer versions of the
> SELinux-related libs DON'T depend on the version of the Linux kernel ?
> I would like to upgrade the libs as described below, but I fear that the
> new libs versions may not work correctly with Linux 2.6.14.
> 
> Please confirm...
> 
> 
> libsemanage-1.6.17-1     =>  libsemanage-1.10.4
> checkpolicy-1.33.1-2     =>  checkpolicy-1.34.3-x
> libsepol-1.15.3-1        =>  libsepol-1.16.3-x
> libselinux-1.33.4-2      =>  libselinux-1.34.10-x
> policycoreutils-1.34.1-4 =>  policycoreutils-1.34.10-x 

AFAIK, there should be no problems from such an upgrade, and if there
are, that's a bug.

Naturally, trying it out on a test machine first considered a good idea.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
