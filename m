Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA26593
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 15:08:46 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA10376
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 20:08:05 GMT
Received: from vorpal.mcs.drexel.edu (vorpal.mcs.drexel.edu [129.25.6.250])
	by jazzband.ncsc.mil  with ESMTP id UAA10372
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 20:08:05 GMT
Subject: Re: X windows with i810 chip
From: Justin Smith <jsmith@mcs.drexel.edu>
To: Stephen Smalley <sds@tislabs.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <Pine.GSO.4.33.0112031009550.4293-100000@raven>
References: <Pine.GSO.4.33.0112031009550.4293-100000@raven>
Content-Type: text/plain
Date: 03 Dec 2001 15:05:09 -0500
Message-Id: <1007409909.1588.0.camel@vorpal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2001-12-03 at 10:13, Stephen Smalley wrote:
> 
> indirectly through /usr/X11R6/bin/Xwrapper, which is labeled with the
> xserver_exec_t type.  This type causes a domain transition from user_t
> to user_xserver_t.  So I don't know why your X server is running in the
> wrong domain.
> 
Yes, I saw the reason for this problem. The file_contexts listing
only assigns xserver_t to /usr/X11R6/bin/Xwrapper when many systems name
the X server X or XFree86 (mine does the latter). I assigned  the
xserver_t type to both of these files and it solved the problem.

I am now able to run X windows and even gdm, although gdm has some
strange problems. When running under it, the newrole command gets the
error message: 'unable to find user in passwd'. I do not get this
message when running under ordinary X windows.

Another anomaly: in Redhat 7.1, /dev/hdc can be a hard drive OR a cdrom
(!). The gnome desktop wouldn't start initially because the system
thought it was trying to access a fixed disk.

In addition, MAKEDEV should be assigned a type that is some sort of
system script rather than a device_t.

Thanks very much for your comments. I'll create a domain for postgres.
> 
--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
