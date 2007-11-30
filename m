Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAUEdHOu029316
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 09:39:17 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id lAUEdEdh003585
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 14:39:14 GMT
Subject: Re: refpolicy HEAD, Debian, patch for udev.te
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: Martin Orr <martin@martinorr.name>, selinux@tycho.nsa.gov
In-Reply-To: <20071130134933.GA11780@bobek.pm.i.cz>
References: <20071126144547.GA334@bobek.pm.i.cz>
	 <1196189369.30997.6.camel@gorn> <474F1BD4.2010908@martinorr.name>
	 <20071130134933.GA11780@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 30 Nov 2007 09:38:33 -0500
Message-Id: <1196433514.4298.42.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-11-30 at 14:49 +0100, Václav Ovsík wrote:
> On Thu, Nov 29, 2007 at 08:06:44PM +0000, Martin Orr wrote:
> > On 27/11/07 18:49, Christopher J. PeBenito wrote:
> > > On Mon, 2007-11-26 at 15:45 +0100, Václav Ovsík wrote:
> > >> Hi,
> > >> Debian Etch, refpolicy HEAD, udev produces during startup (udevsettle)
> > >> wile creating symlinks into /dev/disk/by-uuid/...
> > >> following:
> > >>
> > >> audit(1195744042.060:3): avc:  denied  { relabelfrom } for  pid=836 comm="udevd" name="44517f56-2445-4330-bce7-5168aa534c1c" dev=tmpfs ino=1646 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=system_u:object_r:device_t:s0 tclass=lnk_file
> > >> audit(1195744042.060:4): avc:  denied  { relabelto } for  pid=836 comm="udevd" name="44517f56-2445-4330-bce7-5168aa534c1c" dev=tmpfs ino=1646 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=system_u:object_r:device_t:s0 tclass=lnk_file
> > >>
> > >> Attached patch solves this.
> > >> Can be merged into refpolicy please?
> > > 
> > > This is interesting, it isn't seen on other distros.  Perhaps it has to
> > > do with the way debian sets up tmpfs /dev before udev starts?
> > 
> > I get similar messages: note that the contexts being relabelled from and to
> > are the same.
> > 
> > I had a look, and the symlinks are created by udev running in the initramfs,
> > then the tmpfs /dev is mount --moved into the main root.  No labelling is
> > done yet because no policy has been loaded.  Then when the main udev starts
> > up it replays the coldplug events.  When it comes to create the symlink
> > again, it notices that it is already there and calls lsetfilecon.
> 
> Hmm, you hit the nail on its head :)

I thought that was the case, I was just surprised that it wasn't
short-circuited.  What is odd is that it makes the check for equality,
but then does the setfilecon anyway:

> Corresponding code is in udev_node.c, function node_symlink().

>     if (strcmp(target, buf) == 0) {
> 	    info("preserve already existing symlink '%s' to '%s'", slink,
> target);
> 	    selinux_setfilecon(slink, NULL, S_IFLNK);
> 	    goto exit;
>     }

I'll add the rule.  Perhaps someone should send up a patch to remove the
setfilecon, and update the info message.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
