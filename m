Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8DKMTrT005853
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 16:22:29 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8DKLXHC007866
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 20:21:33 GMT
Subject: Re: [patch] don't relabel sub-subdirectories of /mnt, /media by
	default
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Colin Walters <walters@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   rcoker@redhat.com
In-Reply-To: <1094828936.7061.20.camel@nexus.verbum.private>
References: <1094828936.7061.20.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1095106896.2161.21.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 13 Sep 2004 16:21:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Fri, 2004-09-10 at 11:08, Colin Walters wrote:
> Hi,
> 
> The attached patch ensures we don't try to relabel files from arbitrary
> mounts, like /media/usbkey/*.  One person pointed out on fedora-devel
> that setting extended attributes on ext3 causes older kernels not to be
> able to mount them.  It seems safest to have the default behavior be the
> least invasive.  People who want to label their mount points can do so
> manually.  
> 
> One thing that might be nice is to have a "removable_context" config
> file.  Then we modify HAL to automatically mount removable media with -o
> context=$(cat $SELINUXROOT/contexts/removable_context).  (Really getting
> the context via libselinux of course).  People who want to override that
> behavior can simply add the device manually to fstab, that will cause
> HAL not to create a new entry.
> 
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
