Subject: RE: [RFC] Install SELinux policies from rpm package header
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Joshua Brindle <method@manicmethod.com>,
        Chad Sellers <csellers@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>,
        Paul Howarth <paul@city-fan.org>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Lawrence <slawrence@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <1247496919.2588.91.camel@moss-lions.epoch.ncsc.mil>
References: <C67BD5B0.A89C1%csellers@tresys.com>
	 <4A575664.4040805@manicmethod.com>
	 <1247241489.30551.86.camel@moss-lions.epoch.ncsc.mil>
	 <06A6610D4F464D4EBEAFBF2C5F86911E012CD8FB@exchange2.columbia.tresys.com>
	 <1247496919.2588.91.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 13 Jul 2009 11:38:30 -0400
Message-Id: <1247499510.2588.98.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-07-13 at 10:55 -0400, James Carter wrote:
> 
> 2)
> So to keep systems running, there needs to be a way to do the steps
> required to translate between the two policies.  That could require
> loading additional policy, switching the system to permissive mode,
> setting the system up to relabel the filesystem, and requesting that the
> user reboots the system.

Or there needs to be a way to specify when RPM isn't capable of doing
the necessary translation, so the admin can be informed of what did and
did not happen and (ideally) what he needs to do.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
