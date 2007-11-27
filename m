Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lARIpXCA008952
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2007 13:51:33 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id lARIpQu2023422
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2007 18:51:26 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: refpolicy HEAD, Debian, patch for udev.te
Date: Tue, 27 Nov 2007 13:49:29 -0500
Message-ID: <1196189369.30997.6.camel@gorn>
In-Reply-To: <20071126144547.GA334@bobek.pm.i.cz>
References: <20071126144547.GA334@bobek.pm.i.cz>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?iso-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-11-26 at 15:45 +0100, Václav Ovsík wrote:
> Hi,
> Debian Etch, refpolicy HEAD, udev produces during startup (udevsettle)
> wile creating symlinks into /dev/disk/by-uuid/...
> following:
> 
> audit(1195744042.060:3): avc:  denied  { relabelfrom } for  pid=836 comm="udevd" name="44517f56-2445-4330-bce7-5168aa534c1c" dev=tmpfs ino=1646 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=system_u:object_r:device_t:s0 tclass=lnk_file
> audit(1195744042.060:4): avc:  denied  { relabelto } for  pid=836 comm="udevd" name="44517f56-2445-4330-bce7-5168aa534c1c" dev=tmpfs ino=1646 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=system_u:object_r:device_t:s0 tclass=lnk_file
> 
> Attached patch solves this.
> Can be merged into refpolicy please?

This is interesting, it isn't seen on other distros.  Perhaps it has to
do with the way debian sets up tmpfs /dev before udev starts?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
