Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1KxQXZ000338
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 15:59:26 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1Kw5CC005724
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 20:58:06 GMT
Subject: RE: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: Darrel Goeddel <DGoeddel@TrustedCS.com>, selinux@tycho.nsa.gov,
   Frank Mayer <mayerf@tresys.com>
In-Reply-To: <36282A1733C57546BE392885C06185924D9100@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C06185924D9100@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Message-Id: <1099342548.21386.239.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Nov 2004 15:55:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-01 at 13:28, Chad Hanson wrote:
> Let me try to give some background.
> 
> The ability for a process to perform actions at multiple MLS labels exists
> whether dynamic transitions exist or not. Privilege bracketing does limit
> the use and permits removal of the ability from the process.
> 
> MLS level transitions will need to be controlled via new permissions on the 
> process class (mls_upgrade and mls_downgrade).  Similar permissions will be 
> implemented for objects.  Most processes will not have the ability to alter 
> their MLS level (just as most will not be able to alter their domain).  For 
> processes that have the ability to alter their mls level, they will need to
> be 
> regarded as having access to all levels of information within the process' 
> clearance.
> 
> I would assume this would along the lines of the trusted reader/writer
> concept. THe app is bounded to an MLS range. Instead of a process being
> ranged and running at unclass-confidential, it is bounded by confidential
> and effectively is running at either unclassfied or confidential and able to
> transition between the two levels.

I think I would need to see your MLS implementation to fully assess the
implications, but I'm not clear as to why this requires changing levels
dynamically vs. just giving the process the capability to write down
while remaining at a single level.  Also, I'd be a bit concerned about
what happens while the process is running at the lower level, e.g.
attempted access by untrusted processes running at that lower level.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
