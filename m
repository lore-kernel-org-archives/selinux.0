Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4LCbURb026757
	for <selinux@tycho.nsa.gov>; Fri, 21 May 2004 08:37:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4LCZ3B2001337
	for <selinux@tycho.nsa.gov>; Fri, 21 May 2004 12:35:04 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4LCZ3wi001334
	for <selinux@tycho.nsa.gov>; Fri, 21 May 2004 12:35:03 GMT
Subject: Re: Loadable Policy Modules and a Generic MAC Policy Language
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: K Vikram <vikramatiitkdotacdotin@yahoo.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040521035145.81148.qmail@web41013.mail.yahoo.com>
References: <20040521035145.81148.qmail@web41013.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1085143042.2789.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 21 May 2004 08:37:22 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-05-20 at 23:51, K Vikram wrote:
> The first mechanism is that of being able to associate arbitrary
> security related information, other than user:role:type, with each
> subject/object in the system. This would be useful, for instance, if
> we would want an MLS enforcement. Here we would simply associate the
> appropriate levels and categories with each subject/object.

Did you look at the existing optional MLS support available via
CONFIG_SECURITY_SELINUX_MLS?

> We would eager to have comments/suggestions/criticisms from the group
> about our work. If people are interested, we can share our code as
> well, but it would take a couple of days before we can package it
> well.

I'm sure people would be interested in seeing the code.

> Other than kernel code, relevant patches to userspace programs such as
> login, init, setfiles, etc. and loadable kernel modules for Biba, BLP
> and Lipner models are also included. These patches were required to
> fully implement and use the above mechanisms. 

This seems worrisome.  The SELinux/Flask architecture was designed to
support policy flexibility, so further patching of those programs
shouldn't be necessary, aside from allowing selection of new fields in
pam_selinux.  Most applications should be fine, as the security context
is already encapsulated.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
