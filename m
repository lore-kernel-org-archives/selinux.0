Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0GImTRb011443
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 13:48:29 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0GIlJxr015159
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 18:47:19 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i0GIlIYc015156
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 18:47:18 GMT
Subject: Re: specifying groups of types
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: david caplan <dac@tresys.com>, Chris PeBenito <pebenito@gentoo.org>,
   Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1074278194.23661.134.camel@colossus.columbia.tresys.com>
References: <200310111435.46684.russell@coker.com.au>
	 <1066134168.5054.11.camel@moss-spartans.epoch.ncsc.mil>
	 <3F8C46E4.1030403@tresys.com>
	 <1074177115.17320.32.camel@moss-spartans.epoch.ncsc.mil>
	 <1074271807.23661.119.camel@colossus.columbia.tresys.com>
	 <1074277054.24719.113.camel@moss-spartans.epoch.ncsc.mil>
	 <1074278194.23661.134.camel@colossus.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1074278887.24719.136.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 16 Jan 2004 13:48:07 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-01-16 at 13:36, Karl MacMillan wrote:
> Exactly. I don't think that we want to prevent other rules from adding
> back the type, just consider the list of types within a rule as a whole.
> The patch looks correct to me at first glance, but I didn't test it
> either. After testing, will this change go in? I'm working on supporting
> this in our tools and need to know the final semantics.

I would expect so, barring a significant objection to it.  Assuming that
it does go in, I expect we'll drop the warnings when a type is not added
due to a prior negation, as that may occur naturally due to combinations
of type attributes and types.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
