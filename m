Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB92k1Rb020485
	for <selinux@tycho.nsa.gov>; Mon, 8 Dec 2003 21:46:01 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB92jHlU015371
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 02:45:17 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hB92j0SX015268
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 02:45:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "M. Pender" <michael.pender@nanochron.com>, <selinux@tycho.nsa.gov>
Subject: Re: Installing SELinux under Debian
Date: Tue, 9 Dec 2003 13:44:15 +1100
References: <NGBBKNIIGLLHCHJICCDAIENMJCAA.michael.pender@nanochron.com>
In-Reply-To: <NGBBKNIIGLLHCHJICCDAIENMJCAA.michael.pender@nanochron.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312091344.15736.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 9 Dec 2003 09:57, "M. Pender" <michael.pender@nanochron.com> wrote:
> I know the NSA kernel was developed in parallel with Red Hat Linux and that
> another version is available for Debian.  I plan to do a workshop on either
> installing the Red Hat version on a Dell and another one installing with
> the Debian version on a Power Macintosh.  Does anyone have a preference as
> to which is conducted first?

No preference.  But Debian packages of SE Linux have not been tested for PPC, 
some of the Debian packages are not in Debian yet (patched cron, logrotate, 
and sysvinit) so they are only available in binary form for i386.

> Are there any "lessons learned" I should be aware of with the Debian
> version?  I'm under the impression that it is less mature than the Red Hat
> version.

The Debian version has been around for a lot longer than the Red Hat version.  
There is basic support via a modified dpkg for labelling files at package 
install time.  In Red Hat you have to manually relabel after package 
installation.

The Debian coreutils package has cp and mv that try to set the 
security.selinux xattr.  The Red Hat coreutils package does not have this 
problem.

There are several Debian SE Linux servers running live on the net, some have 
been running since before the new SE Linux was released.  So far there are no 
Red Hat SE Linux servers in production that I am aware of, and no play 
machines.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
