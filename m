Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA03918
	for <selinux@tycho.nsa.gov>; Wed, 21 Nov 2001 09:15:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA15369
	for <selinux@tycho.nsa.gov>; Wed, 21 Nov 2001 14:14:29 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id OAA15365
	for <selinux@tycho.nsa.gov>; Wed, 21 Nov 2001 14:14:28 GMT
Date: Wed, 21 Nov 2001 09:14:47 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Tracy R Reed <treed@ultraviolet.org>
cc: <selinux@tycho.nsa.gov>
Subject: Re: SELinux policy configuration tutorial?
In-Reply-To: <20011121013204.C6432@ultraviolet.org>
Message-ID: <Pine.GSO.4.33.0111210847450.3513-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 21 Nov 2001, Tracy R Reed wrote:

> Thanks. I am slowly making progress. Over the last few nights I've been
> going though "A Security Policy Configuration for the Security-Enhanced
> Linux" in the documentation section and I have noticed that I get a 404
> if I stop reading and pick it up again later. Looks like the url changes
> periodically. Odd.

Everything on the web site is updated for a new release, and the release
timestamp is appended to the technical report filenames, just like the
archive and patch filenames, so the URL changes with each release.  Not
sure if there is any point in timestamping these documents, since these
technical reports haven't been changed in quite a while.

> A policy question: I didn't have apache installed at the time I installed
> SELinux but now I want to install, make it run some useful web app, and
> try to secure it. SELinux seems to come with a policy for the stock apache
> install so I installed the rpm that normally comes with RH6.1.

Just a side note - we're using RH7.1 as our base platform currently for
the LSM-based SELinux prototype.  We are also investigating transitioning
to RH7.2 (but the latter is pending on 2.4.15 for ext3 support, upgrading
the modified utilities, and updating the policy).

> [root@tracy policy]# /etc/rc.d/init.d/httpd start
> Starting httpd: execvp: Permission denied
> [root@tracy init.d]# /usr/sbin/httpd
> bash: /usr/sbin/httpd: Permission denied

Right.  You need to be logged into the sysadm_t domain and you need to use
the run_init program to run init scripts.  Otherwise the script isn't run
in the proper security context and fails.

> Also, I notice that when I log in as the user "jdoe" and do an ls -la on /
> the jdoe user sees this:
>
> ls: lost+found: Permission denied
> ls: ...security: Permission denied
>
> Not much good for hiding files is it?

SELinux doesn't try to hide individual filenames within a directory.
If a process has read permission to a directory, it can see all names in
that directory.  But the process might not have getattr permission to
individual files, so it may not be able to stat the file for a 'ls -l'.
Filenames are part of the directory's state, not part of the file's
state.  Hiding filenames would be possible by filtering directory reads,
as is done in some other systems, but it isn't clear it is worth the cost.

Multi-Level Secure (MLS) systems frequently provide a partitioned
directory mechanism known as multi-level directories for things like
/tmp, where a process is transparently redirected to a dynamically
created subdirectory of /tmp based on its security level.  The SELinux
architecture includes support for a generalization of this idea, but we
haven't implemented the corresponding mechanism in the filesystem.  See
the discussion of polyinstantiation and security union directories in the
Flask paper.  This hasn't been a high priority for us yet.

> As a result of the ls I get this in the messages file:
>
> Nov 21 01:03:53 bench3 kernel: avc:  denied  { getattr } for  pid=9640 exe=/usr/local/selinux/bin/ls path=/...security dev=08:01 ino=38857
> Nov 21 01:03:53 bench3 kernel:    scontext=jdoe:user_r:user_t
> Nov 21 01:03:53 bench3 kernel:    tcontext=system_u:object_r:file_labels_t
> Nov 21 01:03:53 bench3 kernel:    tclass=dir
>
> I'm not sure if I would really want the ls of every user in / to set that off
> but even more of a problem is that the message takes up four lines in the
> messages file. I normally run logcheck once an hour which sends me
> anything interesting from the logfiles after filtering out the bits I have
> deemed non-interesting so it would be quite convenient to have it all on
> one line.

I suppose we could grant getattr permission to these types without any
real harm.  Alternatively, you can configure the policy to disable
auditing of specific permissions through the use of the auditdeny rules.
This is already done in several cases in the example policy.

With regard to putting the AVC messages into a single line, that was the
original format, but I think it was changed later at someone's request to
make it easier to read on the console.  Personally, I would tend to agree
that each AVC audit message belongs on a single line, so I'm ok with
changing it back, but I don't know if this will bother anyone else.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
