Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6EGUCHa013202
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 12:30:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6EGUBH5017796
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 16:30:11 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h6EGUBRX017793 for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 16:30:11 GMT
Subject: Re: another patch for the new release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200307122201.06936.russell@coker.com.au>
References: <200307122201.06936.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1058200198.13738.652.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 14 Jul 2003 12:29:59 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-07-12 at 08:01, Russell Coker wrote:
> I think that it is desirable that when a user is authorized for user_r and 
> staff_r that staff_r is the default.

It doesn't really work to authorize a user for user_r and staff_r;
expected role declarations would be either user_r for ordinary users
(using user_home_*_t on the home directory) or { staff_r sysadm_r } for
admins (using staff_home_*_t on the home directory).  An admin won't be
able to access his home directory if logged in as user_r, and will be
vulnerable to attack by ordinary users.

> xstat_conv.h doesn't work for me, it seems that struct kern_stat not struct 
> stat is required.  Haven't fully tested this yet but at least it makes it 
> compile.

I don't think that this is what you want.  If you are using older glibc
with the old stat definitions, try using the older libsecure, i.e. the
one prior to this release.  In any event, this will be obsoleted by the
new API.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
