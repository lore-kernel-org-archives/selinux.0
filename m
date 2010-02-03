Subject: Re: Allowing MLS->non-MLS and vice versa upon policy reload
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1265226472.3013.158.camel@tesla.lan>
References: <1265212634.3013.19.camel@tesla.lan>
	 <1265213477.12805.15.camel@moss-pluto.epoch.ncsc.mil>
	 <1265213884.3013.29.camel@tesla.lan>
	 <1265215473.12805.27.camel@moss-pluto.epoch.ncsc.mil>
	 <1265216018.3013.34.camel@tesla.lan>
	 <1265216578.12805.32.camel@moss-pluto.epoch.ncsc.mil>
	 <1265217052.3013.37.camel@tesla.lan>
	 <1265217802.12805.37.camel@moss-pluto.epoch.ncsc.mil>
	 <1265218159.3013.49.camel@tesla.lan>
	 <1265219173.12805.42.camel@moss-pluto.epoch.ncsc.mil>
	 <1265219272.3013.55.camel@tesla.lan>
	 <1265221396.12805.70.camel@moss-pluto.epoch.ncsc.mil>
	 <1265226472.3013.158.camel@tesla.lan>
Content-Type: text/plain
Date: Wed, 03 Feb 2010 14:57:52 -0500
Message-Id: <1265227072.12805.77.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-02-03 at 20:47 +0100, Guido Trentalancia wrote:
> Stephen,
> 
> the openssh server issue is specific to Debian or at least specific to
> version 5.1p1. The current version is 5.3p1 and it does not suffer that
> problem, therefore the issue should not be considered any further.
> 
> Should I submit both patches to the kernel mailing list or what ?

Not necessary; they should get taken into security-testing-2.6 in due
time, given that they were acked unless someone objects to them.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
