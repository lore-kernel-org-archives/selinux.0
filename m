Date: Fri, 23 Mar 2001 20:53:35 -0500 (EST)
From: Chris Crowther <shadow@shad0w.org>
To: SELinux@tycho.nsa.gov
Subject: Re: your mail
In-Reply-To: <OFC8827216.E70119F9-ON85256A18.007CF1F0@pok.ibm.com>
Message-ID: <Pine.LNX.4.21.0103232050440.28046-100000@monolith.sanctum.shad0w.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 23 Mar 2001, Hubertus Franke wrote:

> /home/frankeh/slinux/kernel/include/linux/flask/avc.h:13:31:
> linux/flask/flask.h: No such file or directory
> /home/frankeh/slinux/kernel/include/linux/flask/security.h:49:32:
> config/flask/audit.h: No such file or directory
> 
> Looks like various files are missing in the distribution.
> Any ideas ?

	The header files get auto-created by the build, but they're not
there when make dep is run, so you get all the errors, but the Kernel does
compile.

-- 
Chris "_Shad0w_" Crowther
shad0w@shad0w.org
http://www.shad0w.org.uk/



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
