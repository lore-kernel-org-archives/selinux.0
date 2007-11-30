Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAUFUhTB002061
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 10:30:44 -0500
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAUFUeUB004924
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 15:30:41 GMT
Date: Fri, 30 Nov 2007 16:30:24 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Martin Orr <martin@martinorr.name>, selinux@tycho.nsa.gov
Subject: Re: refpolicy HEAD, Debian, patch for udev.te
Message-ID: <20071130153024.GA13299@bobek.pm.i.cz>
References: <20071126144547.GA334@bobek.pm.i.cz> <1196189369.30997.6.camel@gorn> <474F1BD4.2010908@martinorr.name> <20071130134933.GA11780@bobek.pm.i.cz> <1196433514.4298.42.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196433514.4298.42.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Nov 30, 2007 at 09:38:33AM -0500, Christopher J. PeBenito wrote:
> ...
> I thought that was the case, I was just surprised that it wasn't
> short-circuited.  What is odd is that it makes the check for equality,
> but then does the setfilecon anyway:

Udev startup script /etc/init.d/udev does on several places restorecon
and /sbin/restorecon -R /dev before starting udevd. Symlinks
already have right context so.
If there will be for some reason no symlink, udevd should probably
create one and relabel it. Right?

> 
> > Corresponding code is in udev_node.c, function node_symlink().
> 
> >     if (strcmp(target, buf) == 0) {
> > 	    info("preserve already existing symlink '%s' to '%s'", slink,
> > target);
> > 	    selinux_setfilecon(slink, NULL, S_IFLNK);
> > 	    goto exit;
> >     }
> 
> I'll add the rule.  Perhaps someone should send up a patch to remove the
> setfilecon, and update the info message.

Mean you to compare the context of symlink and no setfilecon if it is
ok?
-- 
Zito

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
