Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7S4jFrT024608
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 00:45:16 -0400 (EDT)
Received: from europa.lunarpages.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7S4iSHc002337
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 04:44:29 GMT
Received: from adsl-68-21-245-74.dsl.bcvloh.ameritech.net ([68.21.245.74] helo=[10.0.0.26])
	by europa.lunarpages.com with asmtp (Exim 4.34)
	id 1C0v5V-0000Xn-BE
	for selinux@tycho.nsa.gov; Fri, 27 Aug 2004 21:45:13 -0700
Subject: Re: more policy patches
From: Stephen torri <storri@torri.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200408281204.22830.russell@coker.com.au>
References: <200408241937.04958.russell@coker.com.au>
	 <1093640718.24188.37.camel@moss-lions.epoch.ncsc.mil>
	 <200408281204.22830.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1093668326.22885.13.camel@base.torri.org>
Mime-Version: 1.0
Date: Sat, 28 Aug 2004 00:45:27 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-27 at 22:04, Russell Coker wrote:
> On Sat, 28 Aug 2004 07:05, James Carter <jwcart2@epoch.ncsc.mil> wrote:
> > I also, didn't merge the following:
> >
> > diff -ru /usr/src/se/policy/file_contexts/program/initrc.fc
> > ./file_contexts/program/initrc.fc
> > --- /usr/src/se/policy/file_contexts/program/initrc.fc  2004-07-15
> > 10:22:53.000000000 +1000
> > +++ ./file_contexts/program/initrc.fc   2004-07-08 21:22:51.000000000
> > +1000
> > @@ -16,5 +16,3 @@
> >  /usr/sbin/open_init_pty        --      system_u:object_r:initrc_exec_t
> >  /etc/nologin.*         --      system_u:object_r:etc_runtime_t
> >  /etc/nohotplug         --      system_u:object_r:etc_runtime_t
> > -/halt                  --      system_u:object_r:etc_runtime_t
> > -/\.autofsck            --      system_u:object_r:etc_runtime_t
> >
> > Why remove these?
> 
> I had moved them to rpm.fc.  But it would probably be more appropriate to have 
> ifdef(`distro_redhat' around those two lines and leave them in the same file.
> 
> Debian doesn't have such files, and I suspect that Gentoo doesn't either.  
> Those lines would be either Red Hat specific or Red Hat and SUSE specific.

Your are right. There is no binary called halt in the root directory /.
There were no files starting with .autofsck either. The only place I
found a binary called halt was in /sbin/halt.

Stephen
-- 
Email: storri@torri.org


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
