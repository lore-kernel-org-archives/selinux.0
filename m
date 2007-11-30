Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAUFu6QP005148
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 10:56:06 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id lAUFu5UB016486
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 15:56:05 GMT
Subject: Re: refpolicy HEAD, Debian, patch for udev.te
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: Martin Orr <martin@martinorr.name>, selinux@tycho.nsa.gov
In-Reply-To: <20071130153024.GA13299@bobek.pm.i.cz>
References: <20071126144547.GA334@bobek.pm.i.cz>
	 <1196189369.30997.6.camel@gorn> <474F1BD4.2010908@martinorr.name>
	 <20071130134933.GA11780@bobek.pm.i.cz> <1196433514.4298.42.camel@gorn>
	 <20071130153024.GA13299@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 30 Nov 2007 10:55:49 -0500
Message-Id: <1196438149.4298.43.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-11-30 at 16:30 +0100, Václav Ovsík wrote:
> On Fri, Nov 30, 2007 at 09:38:33AM -0500, Christopher J. PeBenito wrote:
> > ...
> > I thought that was the case, I was just surprised that it wasn't
> > short-circuited.  What is odd is that it makes the check for equality,
> > but then does the setfilecon anyway:
> 
> Udev startup script /etc/init.d/udev does on several places restorecon
> and /sbin/restorecon -R /dev before starting udevd. Symlinks
> already have right context so.
> If there will be for some reason no symlink, udevd should probably
> create one and relabel it. Right?

I thought thats what it did.

> > > Corresponding code is in udev_node.c, function node_symlink().
> > 
> > >     if (strcmp(target, buf) == 0) {
> > > 	    info("preserve already existing symlink '%s' to '%s'", slink,
> > > target);
> > > 	    selinux_setfilecon(slink, NULL, S_IFLNK);
> > > 	    goto exit;
> > >     }
> > 
> > I'll add the rule.  Perhaps someone should send up a patch to remove the
> > setfilecon, and update the info message.
> 
> Mean you to compare the context of symlink and no setfilecon if it is
> ok?

Yes.  Unless there's a good reason to keep it as-is that I don't know
about.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
