Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5FwSIi000296
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 10:58:30 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5Fv9gk028706
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 15:57:09 GMT
Subject: Re: Updated SELinux Release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov,
   debian-devel@lists.debian.org
In-Reply-To: <1099667461.25416.27.camel@nexus.verbum.private>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.58.0411031908500.12297@d10systems.homelinux.com>
	 <1099534538.3875.6.camel@nexus.verbum.private>
	 <87k6t2qepg.fsf@glaurung.internal.golden-gryphon.com>
	 <20041104131544.GC5461@lkcl.net>
	 <1099627566.25416.6.camel@nexus.verbum.private>
	 <20041105102853.GA5565@lkcl.net>
	 <1099667461.25416.27.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1099669891.6373.139.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 10:51:31 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-05 at 10:11, Colin Walters wrote:
> On Fri, 2004-11-05 at 10:28 +0000, Luke Kenneth Casson Leighton wrote:
> >  i would agree with stephen that it should be compiled in,
> >  default options "selinux=no".
> 
> I don't believe Stephen said that.  He said that the performance hit in
> that case is just the LSM hooks.

Obviously, I'd prefer the default to be selinux=1, but as a temporary
measure to getting SELinux compiled into the Debian kernel at all, I
think it is reasonable to make the boot-time default selinux=0 in their
kernel, as SuSE did with their kernel.  You can change the default via a
config option, no patch required anymore.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
