Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j14Cv653006963
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 07:57:06 -0500 (EST)
Subject: Re: Latest diffs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1107520950.30939.6.camel@cobra.ivg2.net>
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9717.2000609@redhat.com>
	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>
	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>
	 <4200D68A.6030309@redhat.com>  <1107478728.4065.3.camel@cobra.ivg2.net>
	 <1107519821.8078.12.camel@moss-spartans.epoch.ncsc.mil>
	 <1107520950.30939.6.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1107521431.8078.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 04 Feb 2005 07:50:31 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-02-04 at 07:42, Ivan Gyurdiev wrote:
> > To be precise, X needs execmod when using nvidia, right?  Not everyone
> > using X needs it (I don't).  In any event, we want the execmod rules to
> > be added to the individual domain .te files, not put in a global macro
> > used by everything, and only allowed as needed.
> 
> Right. I was suggesting it be added to x_server_domain, not global.
> I think it's only needed for nvidia.

Yes, adding it to the xserver_domain macro would be reasonable, under a
boolean as usual.  Might be a candidate for its own boolean as well, as
it can also be exposed remotely and subversion of X is fatal.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
