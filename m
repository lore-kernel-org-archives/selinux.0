Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBA2NbIi017823
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 21:23:37 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBA2NcEj018064
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 02:23:39 GMT
Subject: Re: Single home directory type for all roles.
From: Russell Coker <rcoker@redhat.com>
To: Colin Walters <walters@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   SE Linux list <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@snu.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <1102632223.10785.36.camel@nexus.verbum.private>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102613299.10785.21.camel@nexus.verbum.private>
	 <1102615344.4509.39.camel@aeon>
	 <1102632223.10785.36.camel@nexus.verbum.private>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 13:23:34 +1100
Message-Id: <1102645414.4509.105.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 17:43 -0500, Colin Walters wrote:
> On Fri, 2004-12-10 at 05:02 +1100, Russell Coker wrote:
> > Currently the default policy has /root labeled as staff_home_dir_t.
> > This significantly weakens the boundaries between staff_r and sysadm_r.
> 
> I don't see there as being an interesting boundary between staff_r and
> sysadm_r.  The reason I see staff_r as separated is because it has no
> interaction with user_r, which closes a lot of possible attacks.

Among other things a default configuration allows sshd to permit logins
as staff_r but not sysadm_r.  If a sshd was suspected to be compromised
then you could login at the console as sysadm_r to fix things IFF /root
was not writable to staff_r domains.  If a session launched by sshd can
directly modify files under /root then if you suspected a sshd
compromise then the only option would be to boot from recovery media.

Also note that many daemons look for configuration or data files
under /root, this is due to bugs in daemons but many of them are not
expected to be fixed for quite a while.  Until/unless we get the daemons
in question fixed staff_t can be used to modify the behavior of daemons
with the current labeling of /root (NB in most cases the daemon will
operate without permission to read files under the /root directory, but
even the existence of files can change the behavior).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
