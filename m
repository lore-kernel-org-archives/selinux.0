Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j17JfV53022370
	for <selinux@tycho.nsa.gov>; Mon, 7 Feb 2005 14:41:31 -0500 (EST)
Subject: Re: Latest diffs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Richard Hally <rhally@mindspring.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, ivg2@cornell.edu,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4207C27C.2090103@mindspring.com>
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9717.2000609@redhat.com>
	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>
	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>
	 <4200D68A.6030309@redhat.com> <1107478728.4065.3.camel@cobra.ivg2.net>
	 <42037FDC.9000908@redhat.com>
	 <1107526206.8078.55.camel@moss-spartans.epoch.ncsc.mil>
	 <4207C27C.2090103@mindspring.com>
Content-Type: text/plain
Message-Id: <1107804889.11907.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 07 Feb 2005 14:34:49 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-02-07 at 14:33, Richard Hally wrote:
> FWIW, It looks to me that the problem with X not starting is not just 
> with "legacy" (or third party) drivers or "old toolchains". I am 
> running  current rawhide(as of 2/5/05) with no other addons(like nvidia) 
> and X does not start  in enforcing(current strict policy1.21.8-4). If 
> it's an "old toolchain" problem then it is a Red Hat (Fedora) toolchain 
> that needs to be updated...

I think you misunderstood.  The particular execmod rule in question had
to do with the nvidia driver, and isn't always needed.  In any event,
you may need to enable the allow_execmem boolean for X to work, and you
will likely need to enable the allow_execmod boolean as well for the
desktop due to dependencies on libGL by many desktop applications.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
