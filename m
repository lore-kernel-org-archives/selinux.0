Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82JOLrT002339
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 15:24:21 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82JNV3w006899
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 19:23:31 GMT
Date: Thu, 2 Sep 2004 18:15:44 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Russell Coker <russell@coker.com.au>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Latest Patches
Message-ID: <20040902171544.GG5745@lkcl.net>
References: <200408241818.40064.russell@coker.com.au> <1093640295.24188.29.camel@moss-lions.epoch.ncsc.mil> <200408282346.05926.russell@coker.com.au> <1093897455.3227.6.camel@moss-lions.epoch.ncsc.mil> <41371628.2020408@redhat.com> <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 02, 2004 at 09:10:07AM -0400, Stephen Smalley wrote:

> > @@ -127,7 +130,9 @@
> >  allow $1_xserver_t mtrr_device_t:file rw_file_perms;
> >  allow $1_xserver_t apm_bios_t:chr_file rw_file_perms;
> >  allow $1_xserver_t framebuf_device_t:chr_file rw_file_perms;
> > +ifdef(`redhat', `
> >  allow $1_xserver_t device_t:lnk_file { getattr read };
> > +')
> >  allow $1_xserver_t devtty_t:chr_file rw_file_perms;
> >  allow $1_xserver_t devtty_t:lnk_file read;
> >  
> 
> Wrapping such a trivial rule with a distro-specific ifdef is pointless,
> IMHO, and makes maintenance a pain.

 it's also, istrc, needed for debian.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
