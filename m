Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBA2wVIi017989
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 21:58:31 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBA2uoPS009498
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 02:56:52 GMT
Subject: Re: Single home directory type for all roles.
From: Russell Coker <rcoker@redhat.com>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Colin Walters <walters@redhat.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux list <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <20041209211618.GG8179@jmh.mhn.de>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102613299.10785.21.camel@nexus.verbum.private>
	 <1102615344.4509.39.camel@aeon> <41B8AB69.1060805@redhat.com>
	 <20041209211618.GG8179@jmh.mhn.de>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 13:58:26 +1100
Message-Id: <1102647507.4509.119.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 22:16 +0100, Thomas Bleher wrote:
> Maybe we need to build some higher order macros, to make creating new
> roles easier, so a full user role looks something like this:
> 
> # type for home dir, access to tty
> base_permissions(student)
> can_mount(student)
> # can see all processes
> dnl can_ps(student, domain)
> can_network_server(student)
> 
> # professor can read temporary files of students
> read_tmp_files(professor, student)

This is the general direction that things are going in.  It's just that
progress on changes to user role definitions has been slow.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
