Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0ND5rRb013900
	for <selinux@tycho.nsa.gov>; Fri, 23 Jan 2004 08:05:53 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0ND4dxr020981
	for <selinux@tycho.nsa.gov>; Fri, 23 Jan 2004 13:04:39 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i0ND4cYc020975
	for <selinux@tycho.nsa.gov>; Fri, 23 Jan 2004 13:04:38 GMT
Subject: Re: libselinux upgrade from 1.4-1 to 1.4-6 broke installwatch.so
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <20040123070039.GE11115051@niksula.cs.hut.fi>
References: <20040123070039.GE11115051@niksula.cs.hut.fi>
Content-Type: text/plain
Message-Id: <1074863138.4931.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 23 Jan 2004 08:05:38 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-01-23 at 02:00, Ville Herva wrote:
> Also, I added this bug to redhat bugzilla:
> http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=114067
> 
> So if anybody is interested enough, comments can be added there, too.

Yes, Dan Walsh brought this to my attention, and I looked into it and
sent him an explanation yesterday.  I used strace -f on installwatch to
see where it fails, and then did some further debugging.  The relevant
change to libselinux is the addition of the init_selinuxmnt()
constructor function, which does an open("/proc/mounts", O_RDONLY) to
find the selinuxfs mount point at runtime (RH asked that we add this
rather than hardcoding the path to the selinuxfs mount point, so that
they can change the mount point later without impacting existing code). 
installwatch intercepts the open, and then subsequently tries to call
true_open, which is supposed to refer to the real open function, but
true_open seems to be NULL at this point.  So installwatch doesn't seem
to be able to handle calls performed from library constructors, which
would seem to be a defect in installwatch.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
