Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1AJcWL9013768
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 14:38:32 -0500 (EST)
Subject: Re: TTY question
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1108062931.4443.3.camel@cobra.ivg2.net>
References: <1107915334.6602.1.camel@cobra.ivg2.net>
	 <1107954368.17568.25.camel@moss-spartans.epoch.ncsc.mil>
	 <1108000939.5241.10.camel@cobra.ivg2.net>
	 <1108039573.22172.37.camel@moss-spartans.epoch.ncsc.mil>
	 <1108043320.326.1.camel@cobra.ivg2.net>
	 <1108058666.3808.2.camel@cobra.ivg2.net>
	 <1108062931.4443.3.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1108063884.22172.231.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 10 Feb 2005 14:31:24 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-10 at 14:15, Ivan Gyurdiev wrote:
> Does this look reasonable?

- The patch removes a rule giving $1_su_t certain permissions to sysadm
tty/pty types, likely requires testing to verify that this doesn't
present a problem for proper handling and subsequent restoration of the
label when the su'd shell exits.
- It might be desirable to reduce the permissions allowed by the macro
from rw_file_perms to just { read write getattr }, as I see that many
domains were only being given those permissions previously.  Likewise,
might want to reduce r_dir_perms down to just { read search getattr }.

Otherwise, looks sane to me (subject to testing, of course).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
