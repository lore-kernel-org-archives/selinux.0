Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9H121rT014527
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 21:02:02 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9H11ulX015876
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 01:02:00 GMT
Subject: Re: SELinux Testing Software/Scripts
From: Erich Schubert <erich@debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Alex Ackerman <alex@darkhonor.com>, fedora-selinux-list@redhat.com,
   selinux@tycho.nsa.gov, ackermal@jmu.edu
In-Reply-To: <20041016180414.GB19398@lkcl.net>
References: <A52BEA1D8EE8634B9196A136333637B130F1@maat.darkhonor.net>
	 <20041016180414.GB19398@lkcl.net>
Content-Type: text/plain
Date: Sun, 17 Oct 2004 03:01:54 +0200
Message-Id: <1097974915.21919.5.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

>  as i understand it, there is no "escalation" present in SE/Linux,
>  only that assigned in the minds of us humans.
[...]
>  that's a bit different from "escalating privilege" because that implies
>  hierarchy, which SE/Linux doesn't have, per-se.

As long as you have roles with certain higher privileges (for example
writing to configuration files, binding to arbitrary ports, loading a
new policy...) there is privilege escalation.

Privilege escalation just means getting more rights than you were
supposed to get. You usually don't care about losing access rights,
because you could have done things there earlier. Its only about getting
a privilege you want to have.

Even in normal Linux, becoming root might give you less access rights in
some specific cases. For example with NFS mounts that do root_squash.
(Of course there may be ways of circumventing this, these may exist in
SELinux, too)

Another important aspect in the use of the term "privilege escalation"
is doing multiple steps to get the privileges you really want. A typical
theoretical example is using a game as nobody to get group access to
games, then using this to exploit some game and finally get access to a
user account (which could then be used to get futher access rights)
- referring to the problem that by itself you wouldn't mind for the
"games" group rights, still this may open new points of entry for an
attacker.

Greetings,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
 A man doesn't know what he knows until he knows what he doesn't know. //\
    Wer keine Zeit mehr mit echten Freunden verbringt, der wird bald   V_/_
            sein Gleichgewicht verlieren. --- Michael Levine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
