Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBEBptJV019310
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 06:51:56 -0500
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBEBpsBM008834
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 11:51:55 GMT
Date: Fri, 14 Dec 2007 12:51:53 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: refpolicy HEAD, Debian, ioctl on xconsole by syslogd
Message-ID: <20071214115153.GA21605@bobek.pm.i.cz>
References: <20071204111755.GB27359@bobek.pm.i.cz> <1196780661.5854.44.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <1196780661.5854.44.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Tue, Dec 04, 2007 at 10:04:21AM -0500, Christopher J. PeBenito wrote:
> On Tue, 2007-12-04 at 12:17 +0100, Václav Ovsík wrote:
> > Hi,
> > when starting syslogd by init script:
> > 
> > audit(1196761642.698:3): avc:  denied { ioctl } for  pid=1353
> > comm="syslogd" name="xconsole" dev=tmpfs ino=3703
> > scontext=system_u:system_r:syslogd_t:s0
> > tcontext=system_u:object_r:xconsole_device_t:s0 tclass=fifo_file 
> > 
> > attached patch, that xserver_rw_console() gives ioctl permission.
> > Can be merged?
> 
> I switched it to use rw_fifo_file_perms instead.

I found another problem in dependency of the logging module on the
xserver module. When the xserver module is not used (policy without this
module), access to xconsole is denied. Problem is, that pipe
/dev/xconsole is created by syslogd startup script, but it's type
(context) belongs to the xserver module. That is if no X Window System
is installed (thus no policy module for it), syslogd startup script
creates /dev/xconsole, but can't do labeling and access to
/dev/xconsole.

I have no idea what to write into optional-else block. Maybe to use some
dummy type, allow syslogd_t to rw to this dummy type. But how to write
context for /dev/xconsole with this dummy type optionaly? That is, entry
for /dev/xconsole, valid only when there is no entry from other
module (xserver). Impossible?

Move xconsole_device_t staff from xserver into logging?

Any idea how to solve this?
-- 
Zito

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
