Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAHKwuRb008453
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 15:58:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAHKwtqY013743
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 20:58:55 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hAHKwt0o013740 for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 20:58:55 GMT
Subject: Re: relabelling processes
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Reisse <areisse@nailabs.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20031117144655.A25938@raven.rv.nailabs.com>
References: <20031117144655.A25938@raven.rv.nailabs.com>
Content-Type: text/plain
Message-Id: <1069102734.4662.441.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 17 Nov 2003 15:58:54 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-11-17 at 14:46, Andrew Reisse wrote:
> For the SEdarwin project, we need a process to change its label during 
> execution, because it acts as both a system service and a user session
> manager. (Apple does not release the source). Is there a security risk
> in allowing this for other processes as well, performing the relabelfrom/
> relabelto checks as with file relabelling? If so, we will probably need
> to introduce a new permission so that the window server can change its
> label, but no user process can.

I think that this is noted in the early SELinux documentation, and has
come up a few times before on the list.  Limiting label transitions to
execve allows the inheritance of state and the initialization of the
process in the new label to be controlled.  setuid(2)-like label
transitions lack such controls and enforce no real separation between
the two labels.  Introducing such an operation will create an internal
inconsistency in your security model, with domain transitions sometimes
being subjected to one set of controls and behaviors and sometimes to
another.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
