Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3UJKQI4006503
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 15:20:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3UJKP7R000959
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 19:20:25 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h3UJKPKP000953 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 19:20:25 GMT
Subject: Re: SUDO package
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3EB01EC8.7070602@redhat.com>
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com>
	 <200304181408.55003.russell@coker.com.au>  <3EA021A5.4020603@redhat.com>
	 <1051021175.14761.61.camel@moss-huskers.epoch.ncsc.mil>
	 <3EA5A040.40107@redhat.com>
	 <1051199603.20300.33.camel@moss-huskers.epoch.ncsc.mil>
	 <3EAFEECA.1090107@redhat.com>
	 <1051724624.1028.65.camel@moss-huskers.epoch.ncsc.mil>
	 <3EB01EC8.7070602@redhat.com>
Content-Type: text/plain
Message-Id: <1051730417.1028.78.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 30 Apr 2003 15:20:18 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-04-30 at 15:06, Daniel J Walsh wrote:
> I am still not sure I can do this.  Are you are stating that I would
> have to have an allow rule for
> each *exec_t?

No, I'm talking about your allow rule for directory access.  An *exec_t
type should never be applied to a directory; it is supposed to be the
type of an entrypoint executable for a domain.  For allowing sudo to
search directories containing binaries, you should just be able to
enumerate the set of directory types, e.g. bin_t, sbin_t, lib_t, etc_t,
etc.  There is no valid reason to use file_type.  Just define a macro in
global macros that enumerates the list of system directories with
authorized programs, and use that macro in your rule.

> So sudo needs all the rights that su/newrole has for a particular
role.  

Right, but we would ultimately like to see the roles pruned down to
least privilege, e.g. you don't really want sysadm_t running arbitrary
executables directly, as that can easily lead to a compromise.

> Ok I just went back and read the code again and it looks like I can
> implement the terminal stuff.
> There is a -b option on the sudo command that allows sudo to run in
> background.  Or using job
> control you could run the command in background.
> 
> sudo -r sysadm_r /usr/bin/PROGRAM &
> 
> So what happens to control over the terminal in this situation?

In that case, the program shouldn't be accessing the terminal, and you
should redirect input and/or output to a file if the program wants to
read any input or write any output.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
