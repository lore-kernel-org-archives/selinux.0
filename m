Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j07CGlIi014780
	for <selinux@tycho.nsa.gov>; Fri, 7 Jan 2005 07:16:47 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j07CGoMn014910
	for <selinux@tycho.nsa.gov>; Fri, 7 Jan 2005 12:16:50 GMT
Subject: Re: Architectural doubts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Juan =?ISO-8859-1?Q?Gonz=E1lez?= <jgonzale@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <fd0153ad05010614044e6b7c75@mail.gmail.com>
References: <fd0153ad05010612546d5c87e9@mail.gmail.com>
	 <1105045386.24438.176.camel@moss-spartans.epoch.ncsc.mil>
	 <fd0153ad05010614044e6b7c75@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1105099866.28680.0.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 07 Jan 2005 07:11:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-01-06 at 17:04, Juan González wrote:
> Me question is, SELinux and LSM share the method to catch system
> entry, via hooks.
> I'm right?

LSM defines the hook interfaces and locations, and SELinux implements
the hook functions with its own processing.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
