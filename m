Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA24168
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 14:14:12 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA24972
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 19:12:58 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA24968
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 19:12:58 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id OAA02269
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 14:12:55 -0500 (EST)
Date: Tue, 26 Dec 2000 14:12:54 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: Using other Linux distributions
Message-ID: <Pine.SOL.3.95.1001226130657.29240D-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


I received an email asking about a problem a user had
in installing SELinux on a SuSE 7.0 box.  I'll summarize
the discussion here for others on the list.  As mentioned
on the web pages, we currently only support RedHat 6.1
and the x86 architecture.

The SuSE user had tried installing just the SELinux kernel 
on his machine and booting it.  He received a series of
"ID N respawning too fast" messages and then the system
froze.  These messages were preceeded by a series of
"invalid SID" messages.

The NSA saw similar behavior when they tried booting the SELinux
kernel on a RedHat 6.2 system shortly before the release.
After some investigation, we found that the problem was
due to a set of new system calls that were added to the standard 
Linux 2.2 kernel by the RedHat 6.2 distribution.  These new
system calls were missing from the SELinux kernel (which
is based on the stock kernel from kernel.org) and their
system call numbers conflicted with the numbers used
for the new SELinux system calls.

To solve this problem, you can try applying the SELinux kernel
patch to the kernel sources that come with your Linux distribution.
Or you can try applying some or all of the distribution-specific
kernel patches to the SELinux kernel sources.

The SuSE user also wanted to know if it was reasonable to try
just installing the SELinux kernel without installing the rest of
the SELinux distribution.  Of course, you definitely need to 
install the policy configuration as well.  For distributions other 
than RedHat 6.1, you will almost certainly need to edit
policy/file_contexts to fit your file system layout before relabeling your
file systems.   You will also need to apply the login modifications from
the util-linux package to the login program provided with your
distribution so that the login program will transition to
an appropriate security context for the user session.  At that
point, I would expect that you could boot a SELinux kernel
and login.  It is likely that you would experience some
permission denials, but that will not be a problem if you
are using the development mode.  

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com








You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
