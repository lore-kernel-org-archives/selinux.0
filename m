Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4EJ92Rb013646
	for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 15:09:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4EJ8xMi002906
	for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 19:09:00 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4EJ8xpI002903 for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 19:08:59 GMT
Subject: Re: X policy classes
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: Joshua Brindle <jbrindle@snu.edu>,
   SELinux Mail List <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>, Eamon Walsh <ewalsh@epoch.ncsc.mil>
In-Reply-To: <1084561241.7518.222.camel@gorn.pebenito.net>
References: <40A464EB.5030008@snu.edu>
	 <1084536340.17741.15.camel@moss-spartans.epoch.ncsc.mil>
	 <40A5014A.9060400@snu.edu>
	 <1084556829.18592.5.camel@moss-spartans.epoch.ncsc.mil>
	 <1084561241.7518.222.camel@gorn.pebenito.net>
Content-Type: text/plain
Message-Id: <1084561713.18592.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 14 May 2004 15:08:33 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-05-14 at 15:00, Chris PeBenito wrote:
> One thing I noticed was that when I regenerated the headers from the
> policy flask dir, there were several differences between those, and the
> ones that are in the mainline kernel's security/selinux/include
> directory.  I'm not referring to the new devnull stuff, the SE-X, or our
> PaX stuff, but in the current classes.  I came up with:
> 
>  /etc/security/selinux/src/policy/flask/av_perm_to_string.h     |    7
>  /etc/security/selinux/src/policy/flask/av_permissions.h        |  467 +++++-----
>  /etc/security/selinux/src/policy/flask/flask.h                 |    3
>  /etc/security/selinux/src/policy/flask/initial_sid_to_string.h |    1
>  4 files changed, 242 insertions(+), 236 deletions(-)
> 
> Wouldn't these mismatches cause problems?

If you look at the diffs, you should see that it is just an ordering
issue, not a change in actual values.  The current scripts are just
walking a hash and emitting the definitions, so the order isn't
guaranteed to be stable.  Someone should likely change the scripts to
avoid spurious diffs.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
