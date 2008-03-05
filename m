Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m25GOaA9025909
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 11:24:36 -0500
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m25GOXUA014929
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 16:24:34 GMT
Subject: Re: [DSE-Dev] refpolicy: domains need access to the apt's pty and
	fifos
From: Erich Schubert <erich@debian.org>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
In-Reply-To: <20080305152322.GA9988@bobek.pm.i.cz>
References: <20080305152322.GA9988@bobek.pm.i.cz>
Content-Type: text/plain
Date: Wed, 05 Mar 2008 17:24:28 +0100
Message-Id: <1204734268.12784.124.camel@hepcat.vitavonni.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
Back when I did the initial apt_t policy, I was considering to setup
domains such as apt_script_t and run the package installation scripts in
this domain. This would have been similar to the rpm_script_t domain.
However getting the files in /var/lib/dpkg/info/ labeled correctly would
probably have required some patches to dpkg. There are non-executable
files in there as well, and I'm not sure if you'd want to mix them up.
For example, there are files there storing reference md5sums, or listing
package contents. apt_script_exec_t doesn't sound appropriate for them.
But having them in the same directory means we can't use automatic file
type transitions.

The amount of things done in postinst scripts is one of the things that
really scares me from a security point of view. It might be very
valuable to use a tight SELinux policy to restrict these scripts,
however when it comes down to having a SELinux policy package update it
becomes a Catch-22 somewhat.
It would definitely help to have separate apt_t and apt_script_t
domains, though, to be able to differentiate access for installation
scripts and the package manager itself.

P.S. Thanks for the great work you've been doing on the SELinux policy
for Debian these days! THANKS!

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C   (o_
   There was never a good war or a bad peace. - Benjamin Franklin   //\
          Liebe ist eine schwere Geisteskrankheit (Platon)          V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
