Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6VCxArT002810
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 08:59:11 -0400 (EDT)
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6VCwcHs003952
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 12:58:39 GMT
Received: from localhost (shorty@debby [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11/Debian-5) with ESMTP id i6VCx58d002374
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 14:59:06 +0200
Subject: [Fwd: Re: Building SE-ssh. Result: fakeroot: Permission denied]
From: Wolfgang Pfeiffer <roto@gmx.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1091278744.1295.40.camel@debby>
Mime-Version: 1.0
Date: Sat, 31 Jul 2004 14:59:05 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry, 
I forgot to send the message below to this list, too ..

I slightly re-formatted the message headers below for readability
reasons .. 

Wolfgang

-----Forwarded Message-----
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, 
      Russell Coker <russell@coker.com.au>, Erich Schubert <erich@debian.org>, 
      Colin Walters <walters@verbum.org>
Subject: Re: Building SE-ssh. Result: fakeroot: Permission denied
Date: Sat, 31 Jul 2004 14:54:21 +0200

On Sat, 2004-07-31 at 00:08, Luke Kenneth Casson Leighton wrote: 
> typically what you should do when building a package is to to
> apt-get build-dep <packagename> before-hand.

I do this usually before a build, yes ...

> that will pull in any source building dependencies for you.
> 
> if the package DOESN'T compile when you do this, then you need to
> run (and install if you didn't have it) reportbug to report the
> problem, mentioning in this case (if it is actually true!) that
> a build dependency isn't included.

You're right: But the problem, IIRC, didn't show up with official
openssh sources from debian mirrors but with ssh sources from debian
*after* patching them with openssh-selinux.patch.gz and *after* running
"autoconf" before the actual build.

Running autoconf for a *successful default*, i.e. non-SE debian ssh
build  isn't necessary, IINM.

Remember my posting from July 28:
"SeLinux packages compiled smoothly on ppc (after some help ..)"?

I wrote there I had build successfully, amongst others, these packages:
openssh-client-udeb_3.8.1p1-7_powerpc.udeb
openssh-server-udeb_3.8.1p1-7_powerpc.udeb
ssh-askpass-gnome_3.8.1p1-7_powerpc.deb
ssh_3.8.1p1-7_powerpc.deb

For the built of the latter ecos, ecosconfig, libwxgtk2.4 were not
installed, IINM ...

 So what do I tell the openssh Debian maintainer: Your sources don't
work if I patch them with files that are not (yet ?) part of the Debian
system?

So for me it's not quite clear where the problem lies ... it doesn't
seem to be a bug in a debian package ... or did I miss something?

Tomorrow, Sunday, I will try to re-establish conditions for a failing
se-openssh build, i.e. I will try to first uninstall
ecos, ecosconfig, libwxgtk2.4
again and then rebuild ssh: the stock debian one and the other one
patched for SE-Linux, logging both builts, if possible --- I hope things
will become clear by that.

Please let me someone one if the latter procedure isn't worth the effort
... 

Please remember:
I'm running Debian only since about 12 months .. it's still possible I
make mistakes here ..

Thanks for any suggestions

Nice weekend
Wolfgang
-- 
Profile: http://profiles.yahoo.com/wolfgangpfeiffer

3 more reasons for Linux:
<http://uptime.netcraft.com/up/graph?site=http%3A%2F%2Fwww.whitehouse.gov%2F>
<http://uptime.netcraft.com/up/graph?site=http%3A%2F%2Fwww.fbi.gov%2F>
<http://uptime.netcraft.com/up/graph?site=http%3A%2F%2Fwww.defenselink.mil>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
