Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB3DQjRb021139
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 08:26:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB3DQiqY014255
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 13:26:44 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hB3DQi0o014252 for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 13:26:44 GMT
Date: Wed, 3 Dec 2003 13:26:39 +0000
From: Dale Amon <amon@vnl.com>
To: Tom <tom@lemuria.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: the /etc/selinux problem
Message-ID: <20031203132639.GE25416@vnl.com>
References: <20031203111746.A27632@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031203111746.A27632@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Dec 03, 2003 at 11:17:47AM +0100, Tom wrote:
> Someone here had an install problem - sorry, I don't remember your
> name.
> 
> I stepped back through my install and found your solution:
> 
> 
> There is a hen-egg problem in /etc/dpkg/postinst.d/selinux when you
> upgrade (don't know about fresh installs). Here's what I did to get it
> solved:
> 
> dpkg --purge selinux-policy-default
> manually rm -r /etc/selinux and rm -r /usr/share/selinux/policy
> now vi /etc/dpkg/postinst.d/selinux and put an exit 0 right at the
> start.
> now dpkg -i selinux-policy-default_1.2.real-13_all.deb
> 
> should now work. Remove the exit 0 from the script. You may have to
> issue a make relabel, but that's a good idea anyways.

Might help the other fellow who is just trying to install, 
but don't see how this works for me. I'm installing
packages into a blank loopback (well, I instally my
custom base.tgz first) and I'm doing it on a non-selinux
'kernel factory' machine. The problem hits during the
mass package install phase of my build process and just 
simply torpedoes it.

When I get through a great deal of pain and agony of
upgrading my workstation to sarge (the dist that ate
galeon) I'll be looking into Stephen's suggestions.

PS: Has anyone else noticed that the galeon browswer
vanished without warning from the sarge dist? Not
even mentioned in the sarge main Package list now.
It really screwed me badly :-(

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
