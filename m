Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0IFSTIi020380
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 10:28:29 -0500 (EST)
Received: from hotmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0IFQS9K000033
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 15:26:29 GMT
Message-ID: <BAY101-DAV87378BEDD57CECB9AD2C1B48F0@phx.gbl>
From: "Albretch Mueller" <lbrtchx@hotmail.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: <selinux@tycho.nsa.gov>
References: <BAY101-F18255CE2DCD9B803428707B48D0@phx.gbl> <1106055488.18274.65.camel@moss-spartans.epoch.ncsc.mil>
Subject: Re: Java and SELinux
Date: Tue, 18 Jan 2005 10:29:25 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry, but I think that was not my point. I wasn't talking about a JavaOS or
anything extra/fancy

I was actually refering to the implementation of a pretty flexible and
robust security manager within the JVM.

Using it and declaring 'permissions' through 'grant' segments and combining
them in policy files, you can pretty much customize the security of an
application methods to your hearts content, e.g.:

Loaded application may write and read to the /tmp/ dir and subdirs

grant {

permission java.io.FilePermission "/tmp/*", "read, write";

permission java.lang.RuntimePermission "exitVM", "true";

}

Fine Socket permissions

grant {

permission java.net.SocketPermission "224.0.1.85", "connect,accept";

permission java.net.SocketPermission "*.edu.au:80", "connect";

}

Grant access only to particular hosts, subdomains or domains

grant codebase "http://sunshade.dstc.edu.au/classes/" {

permission java.security.AllPermission "", "";

}

Require digital signatures attached to code

grant signedBy "sysadmin" {

permission java.security.AllPermission "", "";

}

I think the basic idea of SELinux, as I see it, a bus that includes the sec
context. Is implemented in the JVK already.

So, as I had said already, by letting the JVM do her thing and picking up OS
stuff on the native calls with SELinux you would get the best of both
worlds.

Or?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
