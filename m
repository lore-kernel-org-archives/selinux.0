Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k97BxYsZ027314
	for <selinux@tycho.nsa.gov>; Sat, 7 Oct 2006 07:59:34 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k97BwHQC012084
	for <selinux@tycho.nsa.gov>; Sat, 7 Oct 2006 11:58:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: MMCS patch against subversion policy
Date: Sat, 7 Oct 2006 21:59:28 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200610062109.51031.russell@coker.com.au> <200610072113.18735.russell@coker.com.au> <45278F48.2040501@redhat.com>
In-Reply-To: <45278F48.2040501@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610072159.29644.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 07 October 2006 21:28, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Not fully.  I see it in a descretionary sence versus a Mandatory.  My
> thoughts are
> to prevent accidental leaks of information using MCS versus Malicious
> leaks of information.   So
> I see it as a tool to allow people to handle labeled documents.

Do we have anyone who wants such a feature?

Currently you can give users 8 or 32 supplementary groups (depending on the 
OSs in use on your network) and users can run chgrp on files to change them 
between those groups.  The groups can be given human readable names, and the 
user can easily restrict access (which can be achieved by default through the 
umask).

When comparing a discretionary version of MCS to supplementary groups the MCS 
option offers multiple categories and up to 256 or 1024 categories depending 
on the version.  Supplementary groups however allows enforcement in a way 
that you seem to not desire for MCS and supplementary groups are also 
supported in every Unix system that has been used for at least 10 years and 
works over NFS etc.

If labelling is desired on it's own then it would be easy to use user.label as 
an xattr name, create a labelling utility and an option to ls to display it.

> I am not stating a problem with your patches.  I am putting out a
> cautionary note, that we
> do not want an unexpected change in the OS, especially at this late
> time.

You don't want a change in what is about to become RHEL5.  But for general SE 
Linux development we want to keep moving regardless.  This isn't a problem, 
we can handle it through macros in the policy source.

> The admininstator, running su and not being able to see,stop, 
> debug a process was an unexpected side effect of MCS.  This
> problem has been fixed in current targeted policy.  And I don't think
> your patches will effect this.

How did you fix it?  It seems to me that any "fix" for this problem which 
doesn't involve modifying useradd (or something equivalent) will effectively 
turn off MCS.

> BTW.  I am hoping to begin confining user space in targeted policy
> starting in FC7.  Figuring out how to allow administrators in other
> domains then unconfined_t.  (webadm_t, bindadm_t).  Allowing booleans to
> turn on confinement of firefox and evolution/thunderbird.  So at this time
> we might want to look at making MCS more "Mandatory".

For that we have to remove the current unconfined_t domain and move to user 
roles, some of which may have a primary domain that is not confined.

I did some experiments with service specific administrator domains in about 
2002.  I'll have to try and see if it got archived somewhere.

One of the problems I had was the lack of cooperation from people writing 
init.d scripts.  When init.d scripts want to do unusual things (such as 
re-writing config files under /etc) you have to fix those scripts before 
trying to run them in a confined manner.

The first step in this direction will be to make initrc_t not be unconfined.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
