Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0LJmRFX014940
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 14:48:27 -0500 (EST)
Subject: Re: run_init and interactive scripts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <1106333491.28551.159.camel@moss-spartans.epoch.ncsc.mil>
References: <87acr4u57h.fsf@glaurung.internal.golden-gryphon.com>
	 <1106246926.26753.196.camel@moss-spartans.epoch.ncsc.mil>
	 <87fz0ufwz0.fsf@glaurung.internal.golden-gryphon.com>
	 <1106333491.28551.159.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1106336411.28551.171.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 21 Jan 2005 14:40:11 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

BTW, this also requires removing the ifdef(`distro_debian') conditional
in initrc.fc for open_init_pty to ensure proper labeling by
setfiles/restorecon/rpm.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
