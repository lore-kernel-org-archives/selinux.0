Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IDFFRb001107
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 09:15:15 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IDFCAR017866
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 13:15:12 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4IDFBHn017858 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 13:15:11 GMT
Subject: Re: list of permissions created by allow2audit: what do i do now?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040518125633.GA24917@lkcl.net>
References: <20040518104026.GC24333@lkcl.net>
	 <20040518125633.GA24917@lkcl.net>
Content-Type: text/plain
Message-Id: <1084886079.28966.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 18 May 2004 09:14:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-05-18 at 08:56, Luke Kenneth Casson Leighton wrote:
> well i tried the bung-it-in-and-see approach, and i got a build error
> due to some global policy violations at make policy time because
> of this (and one other):
> 
> > allow hotplug_t etc_runtime_t:file { relabelfrom relabelto };
> 
> ... but what is even stranger is that even though i add in these
> things into a new package (i called it domains/programs/localstuff.te)
> the avc messages _still don't go away_.
> 
> i watched the make policy, it read the newly created file
> (localstuff.te) and the stuff is in policy.conf.
> 
> what am i doing wrong?

Did you successfully perform a make load with the new policy?
To do that, you obviously would have to address the assertion failures;
otherwise, checkpolicy won't compile policy.conf to a binary policy that
can be loaded.

Also, denials can occur for reasons other than missing TE allow rules,
as noted in the Configuring the SELinux policy report, e.g.:
- violation of a constraint from policy/constraints
- type not authorized for role
- role not authorized for user
- role transition not authorized

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
