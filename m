Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TEQJrT019254
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 10:26:20 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6TEPnbB022321
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 14:25:49 GMT
Subject: Re: temporary hack to use udev in selinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Joshua Brindle <method@gentoo.org>, SE-Linux <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <20040729135312.GA8858@lkcl.net>
References: <20040728232043.GF18711@lkcl.net> <410844F9.3010203@gentoo.org>
	 <1091105008.21971.17.camel@moss-spartans.epoch.ncsc.mil>
	 <20040729135312.GA8858@lkcl.net>
Content-Type: text/plain
Message-Id: <1091111138.21971.90.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 29 Jul 2004 10:25:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-07-29 at 09:53, Luke Kenneth Casson Leighton wrote:
>  i don't know what the default is.

Unless there is a file_type_auto_trans() rule, the default is to inherit
the type from the parent directory, i.e. device_t.  Access to
device_t:{chr_file blk_file} should be quite restricted, so this should
be safe.

>  so, when that matchpathcon() and setfscreatecon() is called,
>  does it:
>  
>  a ) guarantee that the device node "to be created" will be set with
>      the correct se/linux permissions

Yes.  setfscreatecon() tells the kernel to create new files in a given
security context, as opposed to having to relabel afterward.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
