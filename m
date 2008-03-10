Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2AIX4cq027744
	for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2008 14:33:04 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m2AIWo0u028375
	for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2008 18:32:51 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: refpolicy: domains need access to the apt's pty and fifos
Date: Mon, 10 Mar 2008 13:39:49 -0400
Message-ID: <1205170789.25555.20.camel@gorn>
In-Reply-To: <1204925012.2788.5.camel@vogon>
References: <20080305152322.GA9988@bobek.pm.i.cz> <1204925012.2788.5.camel@vogon>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Stefan Schulze Frielinghaus" <stefan@seekline.net>
Cc: =?iso-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>,
        <selinux@tycho.nsa.gov>, <selinux-devel@lists.alioth.debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-03-07 at 22:23 +0100, Stefan Schulze Frielinghaus wrote:
> On Wed, 2008-03-05 at 16:23 +0100, Václav Ovsík wrote:
> > Hi,
> > running Debian Sid with HEAD refpolicy...
> > I tried to install bind9 and got some further denials for access to pty
> > and pipe of apt_t domain. This is a continuation of the patch from
> > Martin Orr in thread "refpolicy: patch for ldconfig from glibc 2.7...",
> > witch was about apt finally.
> > 
> > sid:/var/lib/dpkg/info# se_apt-get install bind9
> > Authenticating root.
> > Password: 
> > Reading package lists... Done
> > Building dependency tree       
> > Reading state information... Done
> > The following extra packages will be installed:
> >   libbind9-30 libdns32 libisc32 libisccc30 libisccfg30 liblwres30
> > Suggested packages:
> >   bind9-doc dnsutils resolvconf
> > The following NEW packages will be installed:
> >   bind9 libbind9-30 libdns32 libisc32 libisccc30 libisccfg30 liblwres30
> > 0 upgraded, 7 newly installed, 0 to remove and 0 not upgraded.
> > Need to get 1005kB of archives.
> > After this operation, 2789kB of additional disk space will be used.
> > Get:1 http://xenbr0.localdomain sid/main libisc32 1:9.4.2-4 [126kB]
> > Get:2 http://xenbr0.localdomain sid/main libdns32 1:9.4.2-4 [491kB]
> > Get:3 http://xenbr0.localdomain sid/main libisccc30 1:9.4.2-4 [22.3kB]
> > Get:4 http://xenbr0.localdomain sid/main libisccfg30 1:9.4.2-4 [37.8kB]
> > Get:5 http://xenbr0.localdomain sid/main libbind9-30 1:9.4.2-4 [26.1kB]
> > Get:6 http://xenbr0.localdomain sid/main liblwres30 1:9.4.2-4 [39.5kB]
> > Get:7 http://xenbr0.localdomain sid/main bind9 1:9.4.2-4 [262kB]
> > Fetched 1005kB in 0s (3524kB/s)
> > Selecting previously deselected package libisc32.
> > (Reading database ... 68006 files and directories currently installed.)
> > Unpacking libisc32 (from .../libisc32_1%3a9.4.2-4_i386.deb) ...
> > Selecting previously deselected package libdns32.
> > Unpacking libdns32 (from .../libdns32_1%3a9.4.2-4_i386.deb) ...
> > Selecting previously deselected package libisccc30.
> > Unpacking libisccc30 (from .../libisccc30_1%3a9.4.2-4_i386.deb) ...
> > Selecting previously deselected package libisccfg30.
> > Unpacking libisccfg30 (from .../libisccfg30_1%3a9.4.2-4_i386.deb) ...
> > Selecting previously deselected package libbind9-30.
> > Unpacking libbind9-30 (from .../libbind9-30_1%3a9.4.2-4_i386.deb) ...
> > Selecting previously deselected package liblwres30.
> > Unpacking liblwres30 (from .../liblwres30_1%3a9.4.2-4_i386.deb) ...
> > Selecting previously deselected package bind9.
> > Unpacking bind9 (from .../bind9_1%3a9.4.2-4_i386.deb) ...
> > Setting up libisc32 (1:9.4.2-4) ...
> > Setting up libdns32 (1:9.4.2-4) ...
> > Setting up libisccc30 (1:9.4.2-4) ...
> > Setting up libisccfg30 (1:9.4.2-4) ...
> > Setting up libbind9-30 (1:9.4.2-4) ...
> > Setting up liblwres30 (1:9.4.2-4) ...
> > Setting up bind9 (1:9.4.2-4) ...
> > Adding group `bind' (GID 116) ...
> > Done.
> > Adding system user `bind' (UID 110) ...
> > Adding new user `bind' (UID 110) with group `bind' ...
> > Not creating home directory `/var/cache/bind'.
> > wrote key file "/etc/bind/rndc.key"
> > Starting domain name service...: bind.
> > 
> > and denials:
> > 
> > audit(1204723888.180:9): avc:  denied  { use } for  pid=2164 comm="groupadd" name="3" dev=devpts ino=5 scontext=system_u:system_r:groupadd_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fd
> > audit(1204723888.180:10): avc:  denied  { write } for  pid=2164 comm="groupadd" name="[96277]" dev=pipefs ino=96277 scontext=system_u:system_r:groupadd_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fifo_file
> > audit(1204723888.428:11): avc:  denied  { use } for  pid=2170 comm="useradd" name="3" dev=devpts ino=5 scontext=system_u:system_r:useradd_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fd
> > audit(1204723888.428:12): avc:  denied  { write } for  pid=2170 comm="useradd" name="[96277]" dev=pipefs ino=96277 scontext=system_u:system_r:useradd_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fifo_file
> > audit(1204723890.340:13): avc:  denied  { read write } for  pid=2235 comm="modprobe" name="3" dev=devpts ino=5 scontext=system_u:system_r:insmod_t:s0 tcontext=system_u:object_r:apt_devpts_t:s0 tclass=chr_file
> > audit(1204723890.340:14): avc:  denied  { use } for  pid=2235 comm="modprobe" name="3" dev=devpts ino=5 scontext=system_u:system_r:insmod_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fd
> > audit(1204723890.340:15): avc:  denied  { write } for  pid=2235 comm="modprobe" name="[96277]" dev=pipefs ino=96277 scontext=system_u:system_r:insmod_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fifo_file
> > audit(1204723890.588:16): avc:  denied  { use } for  pid=2239 comm="ifconfig" name="3" dev=devpts ino=5 scontext=system_u:system_r:ifconfig_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fd
> > audit(1204723890.588:17): avc:  denied  { write } for  pid=2239 comm="ifconfig" name="[96277]" dev=pipefs ino=96277 scontext=system_u:system_r:ifconfig_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fifo_file
> > audit(1204723890.620:18): avc:  denied  { read write } for  pid=2240 comm="named" name="3" dev=devpts ino=5 scontext=system_u:system_r:named_t:s0 tcontext=system_u:object_r:apt_devpts_t:s0 tclass=chr_file
> > audit(1204723890.620:19): avc:  denied  { use } for  pid=2240 comm="named" name="3" dev=devpts ino=5 scontext=system_u:system_r:named_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fd
> > audit(1204723890.620:20): avc:  denied  { write } for  pid=2240 comm="named" name="[96277]" dev=pipefs ino=96277 scontext=system_u:system_r:named_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fifo_file
> > 
> > 
> > I tried also to install kernel image and got denials:
> > 
> > audit(1204727223.717:45): avc:  denied  { read write } for  pid=2844 comm="depmod" name="3" dev=devpts ino=5 scontext=system_u:system_r:depmod_t:s0 tcontext=system_u:object_r:apt_devpts_t:s0 tclass=chr_file
> > audit(1204727223.717:46): avc:  denied  { use } for  pid=2844 comm="depmod" name="3" dev=devpts ino=5 scontext=system_u:system_r:depmod_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fd
> > audit(1204727223.717:47): avc:  denied  { write } for  pid=2844 comm="depmod" name="[99536]" dev=pipefs ino=99536 scontext=system_u:system_r:depmod_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fifo_file
> > 
> > 
> > Attached patch solves the most of this denials, but I doubt this is the
> > right way.  Should be used some attribute for this?  I noticed attribute
> > privfd and macro domain_interactive_fd(), what about it?  Rpm already
> > has such macro calls
> > ./policy/modules/admin/rpm.te:domain_interactive_fd(rpm_t)
> > ./policy/modules/admin/rpm.te:domain_interactive_fd(rpm_script_t)
> > 
> > I tried to use this macro for apt_t, and all use fd denials above are
> > solved with it. Should be things done in this way?
> > 
> > Thanks for comments.
> 
> I think it is not really nice to have all these allow rules directly in
> the modules. A similar discussion can be found here:
> http://marc.info/?l=selinux&m=118707242005853&w=2
> 
> Especially the first replay of Stephen Smalley pointing out how rpm
> solves this via domain.if: rpm_use_fds($1) and rpm_read_pipes($1)
> 
> If I had to choose between the several fixes for every module or the
> "rpm-way" to allow all usage of file descriptors and read permissions
> then I would vote for the latter.

A better option might be to mimic the inheritance of fds and pipes.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
