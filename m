Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0IFg7Ii020538
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 10:42:07 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0IFg9Y7027384
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 15:42:09 GMT
Subject: Re: Java and SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Albretch Mueller <lbrtchx@hotmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BAY101-DAV87378BEDD57CECB9AD2C1B48F0@phx.gbl>
References: <BAY101-F18255CE2DCD9B803428707B48D0@phx.gbl>
	 <1106055488.18274.65.camel@moss-spartans.epoch.ncsc.mil>
	 <BAY101-DAV87378BEDD57CECB9AD2C1B48F0@phx.gbl>
Content-Type: text/plain
Message-Id: <1106062361.18274.197.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 18 Jan 2005 10:32:42 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-18 at 10:29, Albretch Mueller wrote:
> I think the basic idea of SELinux, as I see it, a bus that includes the sec
> context. Is implemented in the JVK already.
> 
> So, as I had said already, by letting the JVM do her thing and picking up OS
> stuff on the native calls with SELinux you would get the best of both
> worlds.
> 
> Or?

No.  JVM lacks a MAC security model, and doesn't allow you to specify
policy that governs information flow in order to enforce confidentiality
and/or integrity properties.  It would need to be enhanced, and SELinux
provides an API to userspace for getting MAC decisions that is already
used by programs like dbus-daemon and security-enhanced X.  Further,
ability of the JVM to properly isolate and protect is weak, so
restructuring along the lines of JANOS has benefit...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
