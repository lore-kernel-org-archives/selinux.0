Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA11313
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 13:30:44 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA11744
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 18:29:54 GMT
Received: from khaipur.xiat.org ([66.125.68.98])
        by jazzband.ncsc.mil  with ESMTP id SAA11735 for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 18:29:53 GMT
Date: Fri, 18 Jan 2002 10:25:12 -0800
From: Paul Krumviede <pwk@acm.org>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: RE: 2.4.16 release, ipsec, roles and ECHILD errors
Message-ID: <485645491.1011349512@localhost>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A1015242A0@csoc-mail-box.csoconline.com>
References: <72222DC86846D411ABD300A0C9EB08A1015242A0@csoc-mail-box.csoconli
 ne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--On Friday, 18 January, 2002 07:39 -0600 "Westerman, Mark" 
<Mark.Westerman@csoconline.com> wrote:

> The 1.94 version  has bugs that make non-usable

that is a bit of an overstatement. i've patched the 1.94
version to fix the most egregious bug (the one that
could leave a connection in %hold). and it does work
with kernels that don't have selinux compiled in and
earlier versions of selinux: i can see the IKE exchanges
take place and instantiate the desired tunnel and eroute.
traffic between machines does get routed through the
tunnel (as determined with a sniffer).

> From: freeswan web page
> "While freeswan-1.94 has shipped, there are serious known bugs
> in it that make it unsuitable for use. You have two choices,
> use the latest snapshot (snap2001dec25b seems ok) where the
> show stopper bugs seem fixed or use an older 'stable' release
> like 1.91 or maybe 1.92 from this "
>
> Try a different version and see if you have the same problem

i already tried it with 1.91: same symptoms.

and the failure mode i'm seeing when i login with the
user_r role, use newrole to change to the sysadm_r role,
su to root, and start the ipsec processes is a failure mode
independent of recent frees/wan versions: they all attempt
to invoke the _updown script using popen() and use pclose()
to get the status. the serious bug with 1.94 is in klips, the
kernel stuff, the pclose failure is with pluto.

and the fact that it (pclose) doesn't fail if i login with the
sysadm_r role, then su to root and proceed, implies a
problem somewhere other than in the frees/wan stuff.

-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
