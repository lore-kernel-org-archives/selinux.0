Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8GDYLrT024686
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 09:34:21 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8GDYKsh011735
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 13:34:20 GMT
Subject: Re: SELinux policy discussion.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Colin Walters <walters@redhat.com>, ivg2@cornell.edu,
   selinux@tycho.nsa.gov
In-Reply-To: <41498621.5090803@redhat.com>
References: <4148A003.6080309@redhat.com>
	 <1095295125.4231.127.camel@nexus.verbum.private>
	 <1095302625.28466.56.camel@localhost.localdomain>
	 <1095307503.4231.152.camel@nexus.verbum.private>
	 <1095308130.4231.159.camel@nexus.verbum.private>
	 <41498621.5090803@redhat.com>
Content-Type: text/plain
Message-Id: <1095341527.30684.90.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 16 Sep 2004 09:32:07 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-16 at 08:25, Daniel J Walsh wrote:
> If we added a tunable to allow users to read all sysadmfile files we 
> would get somewhere between
> strict policy and targeted.
> 
> bool user_read_adminfile false;
> 
> if (user_read_adminfiles) {
>     r_dir_file($1_t, sysadmfile)
> }

Vetoed.  This is far worse than just adding usercanread attribute to
specific types that you want to allow to be read by untrusted user
domains.

The bugzilla comments seem to flow from a fundamental misunderstanding
of mandatory access control; suggest reading
http://www.nsa.gov/selinux/papers/inevit-abs.cfm and
http://www.nsa.gov/selinux/papers/freenix01-abs.cfm.

If you don't want such protection, then use the targeted policy or
disable SELinux.  Don't water down the strict policy any further please,
it should be moving in the opposite direction.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
