Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9KUHIi015927
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 15:30:18 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9KUJEj008822
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 20:30:20 GMT
Subject: Re: Single home directory type for all roles.
From: Russell Coker <rcoker@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Colin Walters <walters@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   SE Linux list <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@snu.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <41B8B409.4070807@redhat.com>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102613299.10785.21.camel@nexus.verbum.private>
	 <1102615344.4509.39.camel@aeon>  <41B8AB69.1060805@redhat.com>
	 <1102623195.4509.86.camel@aeon>  <41B8B409.4070807@redhat.com>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 07:30:17 +1100
Message-Id: <1102624217.4509.95.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 15:22 -0500, Daniel J Walsh wrote:
> Roles can be used to govern which applications can be run.  So I could 
> have a student role where only
> student applications could be run. 

That doesn't require multiple default domains.  You could have two roles
user_r and user_student_r that only differ in whether
user_student_exec_t can be executed to enter domain user_student_t.

I think that the real solution to the issues you raise are in using
roles more and different login domains less.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
