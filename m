Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7CJds2f011219
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 15:39:54 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m7CJdscG008952
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 19:39:54 GMT
Subject: Re: refpolicy: patch for ldconfig from glibc 2.7
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080812153051.GA25561@bobek.pm.i.cz>
References: <20080222152703.GA4163@bobek.pm.i.cz>
	 <1203703539.32061.22.camel@gorn> <20080222152703.GA4163@bobek.pm.i.cz>
	 <20080812153051.GA25561@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 12 Aug 2008 15:38:52 -0400
Message-Id: <1218569932.8095.18.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-08-12 at 17:30 +0200, Václav Ovsík wrote:
> Hi,
> there is a message with a patch
> http://marc.info/?l=selinux&m=120369420620609&w=2
> in February 2008.

Merged.

> On Fri, Feb 22, 2008 at 01:05:39PM -0500, Christopher J. PeBenito wrote:
> > On Fri, 2008-02-22 at 16:27 +0100, Václav Ovsík wrote:
> > > Hi,
> > > I had some denials for ldconfig on Debian Sid. I took changes from
> > > Fedora policy package - a patch attached. I grabed only things needed
> > > to suppress denials below from Fedora.
> > > 
> > > audit(1203580520.435:11): avc:  denied  { read } for  pid=3985 comm="ldconfig" name="aux-cache" dev=sda1 ino=294984 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=file
> > > audit(1203580520.435:12): avc:  denied  { getattr } for  pid=3985 comm="ldconfig" name="aux-cache" dev=sda1 ino=294984 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=file
> > > audit(1203580520.907:13): avc:  denied  { write } for  pid=3985 comm="ldconfig" name="ldconfig" dev=sda1 ino=294986 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=dir
> > > audit(1203580520.907:14): avc:  denied  { add_name } for  pid=3985 comm="ldconfig" name="aux-cache~" scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=dir
> > > audit(1203580520.907:15): avc:  denied  { create } for  pid=3985 comm="ldconfig" name="aux-cache~" scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=file
> > 
> > This is the right fix, and basically the same fix is queued up for
> > merging as part of Dan's patch set.
> 
> Can be this patch merged as-is?
> (Attached again.)
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
