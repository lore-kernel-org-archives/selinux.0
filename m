Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA04464
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 14:42:44 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA27401
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 19:42:37 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id TAA27397
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 19:42:36 GMT
Date: Thu, 22 Feb 2001 14:41:33 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Casey Schaufler <casey@sgi.com>
cc: selinux@tycho.nsa.gov
Subject: Re: questions...
In-Reply-To: <3A9558A6.DC8A5E30@sgi.com>
Message-ID: <Pine.SOL.3.95.1010222142757.25226A-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Thu, 22 Feb 2001, Casey Schaufler wrote:

> I guess I'm a little slow today. How would having MAC access
> superceding DAC access be anything like the capabilities scheme?

See Spence Minear's paper at
http://www.bsdcon.org/proceedings/spencer_minear/example_of_secure_bsd_os.ps
for a discussion of the parallels between Type Enforcement and POSIX.1e
capabilities.  In the DTOS system, Type Enforcement was used both
to identify subjects that could override MLS restrictions and to
identify subjects that could override Unix DAC restrictions.  At the
same time, Type Enforcement was used to strictly limit such subjects
to least privilege.  Their ability to override such restrictions
could be limited to a particular set of objects since the rules
are based on domain-type pairs.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
