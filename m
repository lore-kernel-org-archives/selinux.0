Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i44AuPRb011212
	for <selinux@tycho.nsa.gov>; Tue, 4 May 2004 06:56:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i44AuNYW003271
	for <selinux@tycho.nsa.gov>; Tue, 4 May 2004 10:56:23 GMT
Received: from mxlx1.surveysavvy.com (mxlx1.surveysavvy.com [63.108.92.46])
        by jazzband.ncsc.mil  with SMTP id i44AuMBf003264 for <selinux@tycho.nsa.gov>; Tue, 4 May 2004 10:56:22 GMT
Message-ID: <1982.68.6.187.64.1083667968.squirrel@mxlx1.surveysavvy.com>
In-Reply-To: <20040503143023.GB2163@rns-nis.co.yu>
References: <200405032042.48931.russell@coker.com.au>
    <4549.68.6.187.64.1083587612.squirrel@mxlx1.surveysavvy.com>
    <20040503143023.GB2163@rns-nis.co.yu>
Date: Tue, 4 May 2004 03:52:48 -0700 (PDT)
Subject: Re: Tinydns Policy Files
From: "Chris Babcock" <cbabcock@luthresearch.com>
To: "Milan P. Stanic" <mps@rns-nis.co.yu>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Mon, May 03, 2004 at 05:33:32AM -0700, Chris Babcock wrote:
>> Dan recommends that daemontools be installed into "/package".  After
>> some
>> dissection this appears to mostly be because the daemontools service
>> manager is launched from the inittab, and some pain can be caused by not
>> having the binaries for it on the root filesystem.  I have at times
>> installed daemontools in other places.  Other locations work fine,
>> however
>> filesystem repair tends to be annoying. <I can provide details if
>> anybody
>> cares...>
>
> I'd like hear why repair "tends to be annoying"?
>
Daemontools launches a set of processes from inittab something like the
following ps listing...
11203 ?        Ss     0:00 /bin/sh /command/svscanboot
11205 ?        S      0:06  \_ svscan /service
12445 ?        S      0:00  |   \_ supervise httpd
12446 ?        S      0:00  |   \_ supervise log
12449 ?        S      0:00  |   |   \_ multilog t ./main -* +* * status:
12447 ?        S      0:00  |   \_ supervise ftpd
12448 ?        S      0:00  |   \_ supervise log
12450 ?        S      0:00  |   |   \_ multilog t ./main -* +* * status:
15148 ?        S      0:00  |   \_ supervise dnscache
15149 ?        S      0:00  |   \_ supervise log
15151 ?        S      0:00  |   |   \_ multilog t /var/multilog/dnscache
15150 ?        S      0:00  |   \_ supervise tinydns
15152 ?        S      0:00  |   \_ supervise log
15153 ?        S      0:00  |       \_ multilog t /var/multilog/tinydns
11206 ?        S      0:00  \_ readproctitle service errors:.............

The way the system works is that svscanboot monitors readproctitle and
svscan.  Init launches and monitors svscanboot. Svscan monitors the
/service directory on the machine for linked directories for service
control.  When svscan finds a directory that needs a service controller,
it launches 2 supervise process.  Once supervise process controlls the
actual service process, another controls the logging subsystem for the
process.

In practice this monitoring tree provides a convenient (again, can detail
if anybody cares, but it is off topic for this list) ,if odd, way of
managing services and their logging.  However, unexpected death of the
bottom level svscan(boot) processes often causes dependent services to
exit as well.  If the supervise processes die, the services typically die
as well.  If svscanboot fails (or is killed), it will be restarted.

Under normal conditions I have _never_ had a svscan(boot) or supervise
process fail.  However, in order to to fsck /usr or /var, all of these
processes will have to be killed if the supervise binary is on the damaged
filesystem.  Unfortunately, there is pretty much no way to _keep_ them
dead, without editing inittab or shutting down to single user mode.  If
inittab is edited and the svscanboot process is removed, the entire
service tree dies.  At times this process death can be undesirable,
because process that are completely unrelated to the damage may have to be
stopped unnecessarily.  If the daemontools binaries are on the rootfs, the
only time a service stop is necessary is when the rootfs is damaged, or
when an individual service's resources are impacted.

Additionally, I dislike having direct dependencies in inittab on non
rootfs binaries.  Some part of me feels like I am inviting disaster.  This
reason may just be a reaction to pain from the Solaris /lib and /bin
symlink to /usr crap.  The following line from a debian inittab references
/sbin not /usr/sbin for a reason...

6:23:respawn:/sbin/getty 38400 tty6

-Chris


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
