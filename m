Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1AIGuL9013174
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 13:16:56 -0500 (EST)
Subject: Re: TTY question
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1108058666.3808.2.camel@cobra.ivg2.net>
References: <1107915334.6602.1.camel@cobra.ivg2.net>
	 <1107954368.17568.25.camel@moss-spartans.epoch.ncsc.mil>
	 <1108000939.5241.10.camel@cobra.ivg2.net>
	 <1108039573.22172.37.camel@moss-spartans.epoch.ncsc.mil>
	 <1108043320.326.1.camel@cobra.ivg2.net>
	 <1108058666.3808.2.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1108058989.22172.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 10 Feb 2005 13:09:49 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-10 at 13:04, Ivan Gyurdiev wrote:
> Should 
> allow $1 privfd:fd use;
> be in that macro? 
> 
> What does that do?
> I see it next to the other rules.

In order to inherit, receive or use an open descriptor, a domain must
have both use permission to the fd (which is labeled based on the domain
that performed the open) and appropriate read/write permissions
(depending on the fd flags) to the file itself.  The privfd attribute
was originally to allow marking of certain domains like login and sshd
that handled opening of the tty/pty for use in allow rules enabling many
other domains to inherit and use the descriptors from these domains. 
newrole actually closes and re-opens descriptors 0-2 in order to get
them into its domain so that subsequent programs only need to inherit
from it rather than from the original user domain.  However, this proved
problematic for su and sudo, and the current policy associates privfd
with the user domains as well so that programs run from su'd shells or
via sudo are able to inherit the descriptors as well.  It would be
preferable to introduce a proxy pty into su and sudo similar to what has
been done recently by Manoj for run_init in order to properly isolate
and protect the different domains.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
