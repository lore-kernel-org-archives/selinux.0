Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBADGuIi020068
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 08:16:56 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBADFJwg021604
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 13:15:19 GMT
Subject: Re: Single home directory type for all roles.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Russell Coker <rcoker@redhat.com>,
   SE Linux list <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@snu.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <1102631395.10785.25.camel@nexus.verbum.private>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102613299.10785.21.camel@nexus.verbum.private>
	 <1102615344.4509.39.camel@aeon>  <41B8AB69.1060805@redhat.com>
	 <1102623195.4509.86.camel@aeon>  <41B8B409.4070807@redhat.com>
	 <1102631395.10785.25.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1102684310.1628.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 10 Dec 2004 08:11:50 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 17:29, Colin Walters wrote:
> On Thu, 2004-12-09 at 15:22 -0500, Daniel J Walsh wrote:
> 
> > BTW I like the idea of defaulting to staff_r.  I think we should do that 
> > and turn off user_canbe_sysadm.
> 
> Fully agreed on this btw.

I'm not sure about this proposal.  Remember that I reworked user.te so
that user_canbe_sysadm does not convey all of the permissions of staff_t
to user_t (i.e. the full priv_user macro); it only conveys the
reach_sysadm permissions for using su/sudo/userhelper to reach sysadm. 
Also, if you have everyone default to staff_r, including user_u, then if
you ever want to enable the user/staff separation, you have to relabel
all of the home directories for people you want to put back into user_r,
which is likely a larger set than the ones you want to put into
staff_r.  Or am I missing something?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
