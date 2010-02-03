Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o13JluAk018782
	for <selinux@tycho.nsa.gov>; Wed, 3 Feb 2010 14:47:57 -0500
Received: from authsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o13Jlxak027744
	for <selinux@tycho.nsa.gov>; Wed, 3 Feb 2010 19:48:00 GMT
Subject: Re: Allowing MLS->non-MLS and vice versa upon policy reload
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1265221396.12805.70.camel@moss-pluto.epoch.ncsc.mil>
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
Content-Type: text/plain
Date: Wed, 03 Feb 2010 20:47:52 +0100
Message-Id: <1265226472.3013.158.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,

the openssh server issue is specific to Debian or at least specific to
version 5.1p1. The current version is 5.3p1 and it does not suffer that
problem, therefore the issue should not be considered any further.

Should I submit both patches to the kernel mailing list or what ?

Kind regards,

Guido Trentalancia


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
