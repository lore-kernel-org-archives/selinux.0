Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA02318
	for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 09:10:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0HEAcI29726
	for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 14:10:38 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h0HEAbf29722 for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 14:10:37 GMT
Message-Id: <200301171418.JAA00475@moss-shockers.ncsc.mil>
Date: Fri, 17 Jan 2003 09:18:06 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: KDM login trouble
To: selinux@tycho.nsa.gov, tom@lemuria.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> For the first time since I started working with SELinux I've done it to
> a desktop machine today.
> 
> Works fine, except for kdm. For one thing, run_init /etc/init.d/kdm
> exits immediately. doh.
> On boot, however, kdm fires up just right.
> 
> But, it doesn't let anyone log in. The logfile says
> UNABLE TO GET VALID SID for ...
> 
> Even though all users, including root, can log on just fine one the
> console, so they _do_ have valid SIDs. And I'm still running in
> permissive mode. No denied log entries, either.
> 
> What am I missing?

Offhand, I would guess that the SELinux patch for kdm was never updated
for the newer libsecure functions and default_contexts configuration,
so it is still looking for the old (and no longer existing)
default_context configuration.  See
http://marc.theaimsgroup.com/?l=selinux&m=103772416731711&w=2 for a
discussion of this change, which was introduced in the October 2002
release.  We updated the components in our tree (login, sshd, crond),
but not external components like the patched kdm.

Alternatively, if the kdm patch was updated, then I would guess that
kdm is not running the right domain.   Check the ps -e --context output
to see the domain on the kdm process.  If it isn't correct, check the
type on the executable.


--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
