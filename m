Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m26AHeCs020918
	for <selinux@tycho.nsa.gov>; Thu, 6 Mar 2008 05:17:40 -0500
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m26AHQun015241
	for <selinux@tycho.nsa.gov>; Thu, 6 Mar 2008 10:17:37 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: [DSE-Dev] refpolicy: domains need access to the apt's pty and fifos
Date: Thu, 6 Mar 2008 21:17:16 +1100
Cc: =?utf-8?q?V=C3=A1clav_Ovs=C3=ADk?= <vaclav.ovsik@i.cz>,
        selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
References: <20080305152322.GA9988@bobek.pm.i.cz> <1204734268.12784.124.camel@hepcat.vitavonni.de>
In-Reply-To: <1204734268.12784.124.camel@hepcat.vitavonni.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803062117.20441.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 06 March 2008 03:24, Erich Schubert <erich@debian.org> wrote:
> Back when I did the initial apt_t policy, I was considering to setup
> domains such as apt_script_t and run the package installation scripts in
> this domain. This would have been similar to the rpm_script_t domain.

I don't believe that it is possible to gain any security benefit from 
splitting dpkg_t, apt_t, and a domain for the scripts.

If apt decides that a certain package is to be installed then dpkg will not 
object, therefore granting apt less privileges than dpkg will not give any 
real benefit.

Pre/post install/remove scripts in Debian packages may do almost anything - 
and often do.  Any restrictions on what such scripts may do will break large 
numbers of packages.  Unless we can get changes to Debian policy relating to 
what such scripts may do (which seems quite unlikely) then we have to allow 
writing to almost all files in the system.

> The amount of things done in postinst scripts is one of the things that
> really scares me from a security point of view. It might be very
> valuable to use a tight SELinux policy to restrict these scripts,
> however when it comes down to having a SELinux policy package update it
> becomes a Catch-22 somewhat.
> It would definitely help to have separate apt_t and apt_script_t
> domains, though, to be able to differentiate access for installation
> scripts and the package manager itself.

What meaningful restrictions can be applied to one but not the other?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
