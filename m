Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1MI85ZR017291
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 13:08:05 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1MI8529006928
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 18:08:05 GMT
Subject: Re: refpolicy: patch for ldconfig from glibc 2.7
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
In-Reply-To: <20080222152703.GA4163@bobek.pm.i.cz>
References: <20080222152703.GA4163@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 22 Feb 2008 13:05:39 -0500
Message-Id: <1203703539.32061.22.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-02-22 at 16:27 +0100, Václav Ovsík wrote:
> Hi,
> I had some denials for ldconfig on Debian Sid. I took changes from
> Fedora policy package - a patch attached. I grabed only things needed
> to suppress denials below from Fedora.
> 
> audit(1203580520.435:11): avc:  denied  { read } for  pid=3985 comm="ldconfig" name="aux-cache" dev=sda1 ino=294984 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=file
> audit(1203580520.435:12): avc:  denied  { getattr } for  pid=3985 comm="ldconfig" name="aux-cache" dev=sda1 ino=294984 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=file
> audit(1203580520.907:13): avc:  denied  { write } for  pid=3985 comm="ldconfig" name="ldconfig" dev=sda1 ino=294986 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=dir
> audit(1203580520.907:14): avc:  denied  { add_name } for  pid=3985 comm="ldconfig" name="aux-cache~" scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=dir
> audit(1203580520.907:15): avc:  denied  { create } for  pid=3985 comm="ldconfig" name="aux-cache~" scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=file

This is the right fix, and basically the same fix is queued up for
merging as part of Dan's patch set.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
