Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2EoOXZ006032
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 09:50:24 -0500 (EST)
Message-ID: <41879EAB.5070300@redhat.com>
Date: Tue, 02 Nov 2004 09:50:19 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Russell Coker <russell@coker.com.au>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: Patch to make can_network stronger and remove nscd tunable.
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de>	 <1099078308.12321.96.camel@moss-lions.epoch.ncsc.mil>	 <418661C8.8000801@redhat.com> <200411030027.28875.russell@coker.com.au>	 <41879A1B.40103@redhat.com> <1099406385.31739.77.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1099406385.31739.77.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I can change daemon_core_domain to define domain types with
nscd_client_domain,

Does anyone have a problem with that?

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
