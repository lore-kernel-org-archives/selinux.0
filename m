Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IFMKRb002417
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 11:22:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4IFJsB4023887
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 15:19:56 GMT
Date: Tue, 18 May 2004 15:19:40 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: list of permissions created by allow2audit: what do i do now?
Message-ID: <20040518151940.GG24917@lkcl.net>
References: <20040518104026.GC24333@lkcl.net> <20040518125633.GA24917@lkcl.net> <1084886079.28966.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1084886079.28966.71.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 18, 2004 at 09:14:39AM -0400, Stephen Smalley wrote:
> On Tue, 2004-05-18 at 08:56, Luke Kenneth Casson Leighton wrote:
> > well i tried the bung-it-in-and-see approach, and i got a build error
> > due to some global policy violations at make policy time because
> > of this (and one other):
> > 
> > > allow hotplug_t etc_runtime_t:file { relabelfrom relabelto };
> > 
> > ... but what is even stranger is that even though i add in these
> > things into a new package (i called it domains/programs/localstuff.te)
> > the avc messages _still don't go away_.
> > 
> > i watched the make policy, it read the newly created file
> > (localstuff.te) and the stuff is in policy.conf.
> > 
> > what am i doing wrong?
> 
> Did you successfully perform a make load with the new policy?

 yes.

> To do that, you obviously would have to address the assertion failures;
> otherwise, checkpolicy won't compile policy.conf to a binary policy that
> can be loaded.

 yes, i did address the assertions by removing things from
 localstuff.te, in the hope that i can address them later or
 perhaps investigate them.

> Also, denials can occur for reasons other than missing TE allow rules,
> as noted in the Configuring the SELinux policy report, e.g.:
> - violation of a constraint from policy/constraints
> - type not authorized for role
> - role not authorized for user
> - role transition not authorized
 
 hm: this is system context (boot time), and i have a bog-standard
 debian / unstable install, so i don't believe i have done anything
 to cause, say XFree86 to continue to not play ball.

 i _have_ noticed that /var/lib/wdm/authfiles is accessed and have
 changed file_contexts/program/xserver.fc the line that mentions
 /var/lib(64)?/kdm to /var/lib(64)?/[kw]dm.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
