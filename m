Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3UHhtI4005879
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 13:43:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3UHhs7R024296
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 17:43:54 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h3UHhrKP024293 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 17:43:53 GMT
Subject: Re: SUDO package
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3EAFEECA.1090107@redhat.com>
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com>
	 <200304181408.55003.russell@coker.com.au>  <3EA021A5.4020603@redhat.com>
	 <1051021175.14761.61.camel@moss-huskers.epoch.ncsc.mil>
	 <3EA5A040.40107@redhat.com>
	 <1051199603.20300.33.camel@moss-huskers.epoch.ncsc.mil>
	 <3EAFEECA.1090107@redhat.com>
Content-Type: text/plain
Message-Id: <1051724624.1028.65.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 30 Apr 2003 13:43:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-04-30 at 11:42, Daniel J Walsh wrote:
> I have a hard time with the previous two.  Just seems to me SELinux
> needs some sort
> of dontallow functionality to handle these situation.  Otherwise every
> time I add a policy 
> that has a somewhat global effect on files/dir, I need to change the
> all the file/directory attributes 
> in the policy.  Has this been discussed previously?

True.  The problem is more severe for exec_type than for the directory
access; IMHO, it isn't too much to ask you to enumerate the major
directory types in which binaries to be executed by sudo might live, and
most (all?) of those types should be part of the basic policy
definition, not package-specific, e.g. bin_t, sbin_t, etc.  You don't
even need to define an attribute for that purpose; you can just list
them in your allow rule, or pull them from a macro definition added to
the global macros.

> This is a problem since with Sudo you are sharing the same terminal
> between the process that rand sudo
> and the sudo process.  So if you change the privs of the terminal one
> process or the other could have 
> more privs.  I would prefer to leave the terminal with the current
> privs (Usually lower) and make the 
> application run by sudo change the terminal privs if it has to. 
> (probably seldom).  Any other ideas?

I'm not clear as to why you can't implement something akin to what
newrole does.  Otherwise, what prevents another process of lower
privilege from arbitrarily accessing the privileged process' terminal?
You can't rely on the DAC protections.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
