MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch] libselinux:  disable setlocaldefs if no local boolean oruser files exist
Date: Wed, 6 Feb 2008 11:03:45 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880181F165@exchange.columbia.tresys.com>
In-Reply-To: <1202311592.27371.150.camel@moss-spartans.epoch.ncsc.mil>
References: <1202311592.27371.150.camel@moss-spartans.epoch.ncsc.mil>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Cc: "Joshua Brindle" <method@manicmethod.com>,
        "Chad Sellers" <csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> If there are no local boolean or user files present, then the
> libselinux load policy logic can disable setlocaldefs early and thus
> avoid creating a writable mapping of the policy as well as avoiding
> the overhead of calling the sepol functions for manipulating local
> boolean and user files altogether.  This is cleaner than changing
> the default for the config option, as it will fall back to
compatibility
> behavior for older distributions.  Thus, this change should not change
> behavior for RHEL 4. 
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

That does seem like a cleaner solution and will simplify things for
people using newer toolchains on RHEL 4.

Acked-by: Todd C. Miller <tmiller@tresys.com>

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
