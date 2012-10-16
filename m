Message-ID: <1350406303.13615.7.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: First attempt for the patch on extending the plugin interface
 for rpm
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: Panu Matilainen <pmatilai@laiskiainen.org>,
        "tero.aho@nixu.com"
 <tero.aho@nixu.com>,
        "rpm-maint@lists.rpm.org" <rpm-maint@lists.rpm.org>,
        "Ware, Ryan R" <ryan.r.ware@intel.com>,
        "SELinux@tycho.nsa.gov"
 <SELinux@tycho.nsa.gov>
Date: Tue, 16 Oct 2012 12:51:43 -0400
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B1944CA4E@IRSMSX102.ger.corp.intel.com>
References: 
	<2236FBA76BA1254E88B949DDB74E612B19449DCA@IRSMSX102.ger.corp.intel.com>
	 <5073D8D8.2010602@laiskiainen.org>
	 <2236FBA76BA1254E88B949DDB74E612B1944A502@IRSMSX102.ger.corp.intel.com>
	 <5075845F.9020102@laiskiainen.org>
	 <2236FBA76BA1254E88B949DDB74E612B1944C1BE@IRSMSX102.ger.corp.intel.com>
	 <507D3F47.4090100@laiskiainen.org>
	 <2236FBA76BA1254E88B949DDB74E612B1944CA4E@IRSMSX102.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-10-16 at 16:31 +0000, Reshetova, Elena wrote:
> >The script setup hook is fairly obvious too, just forgot to mention it.
> >The one question with that is (again) the argument(s) it receives:
> >currently its ARGV_t, but does it actually need the entire argv or would just 
> >the actual executable path suffice for the setup?
> 
> I am fine with just the path, but looking to SELinux code, the rpm_execcon() 
> func needs the whole argv struct.
> 
> @ Stephen, do you know how mandatory for SELinux is to have the whole argv 
> struct? Is it just because of rpm_execcon() API or?

It is because presently rpm_execcon() performs the exec call.  If the
exec call is handled by the caller, then we only need the executable
path.  Likewise with envp; we do not need it if the caller performs the
exec.  We would just move the remaining logic to set up the exec context
from libselinux rpm_execcon() into the rpm selinux plugin code; as rpm
is the only user of it, there is no real reason for it to live in
libselinux vs being part of an rpm plugin.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
