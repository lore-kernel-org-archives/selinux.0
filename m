Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TCiDrT018141
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 08:44:13 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6TChgbB015280
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 12:43:42 GMT
Subject: Re: temporary hack to use udev in selinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <method@gentoo.org>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <410844F9.3010203@gentoo.org>
References: <20040728232043.GF18711@lkcl.net>  <410844F9.3010203@gentoo.org>
Content-Type: text/plain
Message-Id: <1091105008.21971.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 29 Jul 2004 08:43:28 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-07-28 at 20:29, Joshua Brindle wrote:
> Chris PeBenito made this patch for Gentoo when we were evalutating udev 
> on selinux
> 
> http://dev.gentoo.org/~method/1330_linux-2.6.5-ramfs-xattr.patch

Why wasn't this submitted upstream?  ramfs xattr support (and likewise
for other pseudo fs's like tmpfs) has been on our todo list for some
time.

> that should patch cleanly into 2.6.7, but I'd like to note that at this 
> point udev is braindead wrt SELinux.
> Once upon a time udev had selinux support integrated so that setfscreate 
> was called to set the context of the devices being written however it 
> was changed at some point to make SELinux an after device creation addon 
> script which makes it label the devices after they are created. Because 
> of this Hardened Gentoo has decided not to support udev at this time.

I haven't tried udev myself, but I think Dan has used it successfully
with SELinux.  I'd agree that having udev directly call matchpathcon()
and then setfscreatecon() prior to node creation would be preferable,
but I'm not sure that it is strictly necessary - as long as the default
creation type is suitably restrictive and nothing tries to access it
prior to the restorecon.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
