Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1NFqumr000539
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 10:52:56 -0500 (EST)
Subject: Re: [RFC][PATCH] Pass requested protection to
	security_file_mmap/mprotect hooks
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: Colin Walters <walters@verbum.org>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Daniel J Walsh <dwalsh@redhat.com>, lsm <linux-security-module@wirex.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <20050222210113.GH15867@shell0.pdx.osdl.net>
References: <1109095368.15893.17.camel@moss-spartans.epoch.ncsc.mil>
	 <1109097647.3858.14.camel@nexus.verbum.private>
	 <1109097979.15893.52.camel@moss-spartans.epoch.ncsc.mil>
	 <20050222210113.GH15867@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 08:02:05 -0500
Message-Id: <1109163725.17298.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-22 at 13:01 -0800, Chris Wright wrote:
> By heuristics did you mean taking current->personality into account and
> trying to guess what the caller asked for?

Yes.  Even if current->personality has READ_IMPLIES_EXEC set, some of
the application (and ld.so) requests will explicitly include PROT_EXEC,
and we don't really want to suppress checking of those execute requests
as well.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
