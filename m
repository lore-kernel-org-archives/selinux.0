Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6NF5pHa025855
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 11:05:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6NF4jFB022959
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 15:04:45 GMT
Received: from prometheus.epoch.ncsc.mil (prometheus.epoch.ncsc.mil [144.51.25.40])
	by jazzswing.ncsc.mil  with ESMTP id h6NF4jGD022956
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 15:04:45 GMT
Received: from prometheus.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6NF5oxH014095
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 11:05:50 -0400
Received: (from jwcart2@localhost)
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h6NF5oVB014093
	for selinux@tycho.nsa.gov; Wed, 23 Jul 2003 11:05:50 -0400
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6NEwCHa025805
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 10:58:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6NEv3FB022281
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 14:57:03 GMT
Received: from mail.rollinghorse.com (dsl093-033-002.snd1.dsl.speakeasy.net [66.93.33.2])
	by jazzswing.ncsc.mil  with ESMTP id h6NEv1GD022276
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 14:57:02 GMT
Message-Id: <5.1.1.6.2.20030723080629.0a198680@Shire>
Date: Wed, 23 Jul 2003 08:09:49 -0700
To: Dean Anderson <dean@av8.com>, Russell Coker <russell@coker.com.au>
From: "Carsten P. Gehrke" <Carsten@rollinghorse.com>
Subject: Re: Linuxfromscratch.org
Cc: Charlie Watts <st_possenti@yahoo.com>, <selinux@tycho.nsa.gov>
In-Reply-To: <Pine.LNX.4.44.0307221644010.21542-100000@vista.av8.net>
References: <200307221606.42540.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At 13:49 22-07-03, Dean Anderson wrote:
>if you are looking for integrity, Linuxfromscratch is just the start.
>
>You have to come up with a way to exclude Kerningan-style compiler hacks,
>and similar OS hacks from being inserted into the "clean" source build.
>
>Kernigan, as some will remember, early in Unix days (70s), altered the
>compiler to include a backdoor in login when it compiled login.c, and
>altered the compiler to insert the backdoor-inserter whenever it compiled
>itself.  So even if you recompiled Unix from scratch from clean source,
>you still had a backdoor.  I think even if you retargeted the compiler, it
>still inserted to the apprpropriate backdoor-inserter.  A similar hack can
>be done at the OS level.
>
>                 --Dean

Is this true of the GNU C compiler suite as well?  And if so, would it not 
be possible to remove it from the compiler?  How does it work?  Does it 
look at the code, or is anything called login.c susceptible?  Why has this 
not been removed in the open-source code?  How can I check to see if this 
backdoor exists?

TIA,
Carsten


--
========================================================================
                             Carsten P. Gehrke
                      mailto:Carsten@RollingHorse.com
========================================================================


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
