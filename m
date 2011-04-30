Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3UAn5Ju026629
	for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2011 06:49:05 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3UAn391028849
	for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2011 10:49:04 GMT
In-Reply-To: <20110428200218.GB9186@hallyn.com>
References: <20110428200218.GB9186@hallyn.com> <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
To: Serge Hallyn <serge.hallyn@canonical.com>
Cc: dhowells@redhat.com, eparis@redhat.com,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        Oleg Nesterov <oleg@redhat.com>, casey@schaufler-ca.com
Subject: Re: [PATCH 0/9] Open loaders and interpreters with new creds during exec
Date: Sat, 30 Apr 2011 11:48:57 +0100
Message-ID: <21766.1304160537@redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serge Hallyn <serge.hallyn@canonical.com> wrote:

> Did you mean to add
> 
> 	chmod u+s /tmp/ls
> 
> to the recipe above?  If not, then I don't understand your point and think
> current behavior is right.
> 
> If so, then I think what you say makes sense.

I did post a correction saying I'd forgotten to add that line.

> > (2) Conversely, if the loader is not executable by the uid to which an SUID
> >     executable switches, should that execution succeed?
> 
> The crux of the matter, then, is: do we consider the interpreter to be
> executed by the caller, or the new task?

I guess that's a good way of stating the case.  I looked on it like this: The
interpreter, whether specified by a binary (eg. ELF's PT_INTERP) or a script
(eg. #!/bin/sh), is not specified by the user that called execve(), but is
rather built into the executable; indeed, the user may not be able to read the
executable and see what these details are (ie. they may only have execute
permission).

Of course, this may not apply to scripts, since we don't normally allow those
to effect SUID/SGID transitions.  Should set-security-label transitions be
ignored on scripts too (which I think was one of the points Casey was taking
about)?  Should the script interpreter simply reset the credentials to those
of the current user?

> I think what you're suggestion makes sense.  I'd like to get input
> from someone like Roland or Oleg, though.  Furthermore, while it
> seems to make sense, that does not mean that it'll be safe in a real
> system.  Have you run LTP and some real workloads like WAS or
> Oracle to make sure there were no regressions?

I've run the SELinux test suite.  That requires an extra rule or two to allow
its executables to access their loaders.

I'll look at running LTP too.  I'm not sure what 'WAS' is[1], and I don't have
access to Oracle.

> (With that out of the way, I'll start looking at the patches under
> the assumption that the semantics are correct.)

Thanks!

David

[1] Things named 'WAS' are a bit tricky to Google for...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
