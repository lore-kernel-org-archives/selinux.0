Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8FIf0rT019715
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 14:41:00 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8FIe4HF004645
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 18:40:05 GMT
Subject: Re: [patch] don't relabel sub-subdirectories of /mnt, /media by
	default
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@redhat.com>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>, Russell Coker <rcoker@redhat.com>
In-Reply-To: <1095272723.4231.38.camel@nexus.verbum.private>
References: <1094828936.7061.20.camel@nexus.verbum.private>
	 <1095106896.2161.21.camel@moss-lions.epoch.ncsc.mil>
	 <20040913232841.GB30524@lkcl.net>
	 <1095272723.4231.38.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1095273509.28981.230.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 15 Sep 2004 14:38:29 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-15 at 14:25, Colin Walters wrote:
> Dan, John Palmieri and I talked about this, and we agreed that it is bad
> that currently file contexts on removable ext3 media is trusted. 
> 
> Right now when a device is inserted HAL generates an fstab entry for it,
> and includes "nosuid, noexec, nodev" (actually these are implied by the
> "user" option).

Just as a side note, nosuid also disables domain transitions for any
programs on the filesystem, so at least you can't provide arbitrary
entrypoint programs on the removable media.  I suppose the noexec makes
this moot anyway.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
