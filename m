Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0SFRlRb005393
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 10:27:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0SFRjCa018898
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 15:27:45 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i0SFRiVC018887 for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 15:27:44 GMT
Subject: Re: Problem with selinux configuration
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: keen@internode.on.net
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4017be35.30f.6615.1100265729@internode.on.net>
References: <4017be35.30f.6615.1100265729@internode.on.net>
Content-Type: text/plain
Message-Id: <1075303660.19427.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 28 Jan 2004 10:27:40 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-01-28 at 08:50, keen@internode.on.net wrote:
> Hi,
> 
> I am trying to install selinux with a plain vanilla kernel
> 2.6.0 (released 18 Dec 2003) from kernel.org using RH9

As mentioned on the site, we are using Fedora Core 1 as our development
platform.  The packages in the last NSA release have dependencies on
newer packages than RH9.

Also, note that 2.6.2-rc2 would give you a much more up-to-date snapshot
of SELinux, and we will likely move to FC2/test1 once it becomes
available, as it has SELinux integrated.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
