Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2QEEFRb023556
	for <selinux@tycho.nsa.gov>; Fri, 26 Mar 2004 09:14:16 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2QECOdQ023780
	for <selinux@tycho.nsa.gov>; Fri, 26 Mar 2004 14:12:24 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i2QECNBL023777
	for <selinux@tycho.nsa.gov>; Fri, 26 Mar 2004 14:12:23 GMT
Subject: Re: status tool
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1080243007.12376.28.camel@gorn.pebenito.net>
References: <1080243007.12376.28.camel@gorn.pebenito.net>
Content-Type: text/plain
Message-Id: <1080310444.6559.81.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 26 Mar 2004 09:14:04 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-03-25 at 14:30, Chris PeBenito wrote:
> Over the last couple weeks I've been working on a SELinux status tool. 
> I originally intended it for use as a support tool, so we could get much
> of SELinux's status in one shot.  Since not being able to log in is a
> common problem, I aimed the tool to be helpful with figuring out the
> problem.  After some suggestions from Russell, the result is the
> attached sestatus.

Thanks, this seems like a good idea.  Did you consider readlink of
/proc/pid/exe rather than read of /proc/pid/cmdline when trying to find
the process for a given program?  I suppose that might be a problem if
they can't become root on the system, but it would offer a more reliable
path for the executable.  Another possibility would be to scan
/proc/pid/maps.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
