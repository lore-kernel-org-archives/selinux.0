Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j14Cgp53006771
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 07:42:51 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j14CeV3q023235
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 12:40:42 GMT
Subject: Re: Latest diffs
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1107519821.8078.12.camel@moss-spartans.epoch.ncsc.mil>
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9717.2000609@redhat.com>
	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>
	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>
	 <4200D68A.6030309@redhat.com>  <1107478728.4065.3.camel@cobra.ivg2.net>
	 <1107519821.8078.12.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 04 Feb 2005 07:42:30 -0500
Message-Id: <1107520950.30939.6.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> To be precise, X needs execmod when using nvidia, right?  Not everyone
> using X needs it (I don't).  In any event, we want the execmod rules to
> be added to the individual domain .te files, not put in a global macro
> used by everything, and only allowed as needed.

Right. I was suggesting it be added to x_server_domain, not global.
I think it's only needed for nvidia.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
