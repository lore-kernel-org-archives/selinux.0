Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89NW7rT015737
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 19:32:08 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i89NVEo3009848
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 23:31:14 GMT
Date: Fri, 10 Sep 2004 00:43:21 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: at last: info regarding boot problems on multiple partitions
Message-ID: <20040909234320.GA7328@lkcl.net>
References: <20040908224949.GK7717@lkcl.net> <200409100233.47416.russell@coker.com.au> <20040909183823.GJ10046@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040909183823.GJ10046@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 09, 2004 at 07:38:23PM +0100, Luke Kenneth Casson Leighton wrote:

> On Fri, Sep 10, 2004 at 02:33:47AM +1000, Russell Coker wrote:

> > On Thu, 9 Sep 2004 08:49, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > FINALLY i got a useable system when i encountered a boot problem
> > > [well, i got a console login].
> > >
> > > the issue is that partitions fail to be mounted.

>  Mounting local filesystems...
>  SeLinix: initialized (dev hda1, type ext2) uses xattr
>  same for hda6
>  same for hda7
> 
>  /dev/hda1 on /boot type ext2 (rw)
>  /dev/hda6 on /var type ext2 (rw)
>  /dev/hda7 on /home type ext2 (rw)
> 
> 
>  .... not a sausage about /dev/hda5!!!

okay, it was as i kind-of expected - that audit banning
write access of /bin/touch to /etc was wot done it.

that check is done in /etc/init.d/mountvirtfs.sh - it's a very
awful hack to check that /etc/mtab is on a writeable filesystem.

rather than check the file itself, mountvirtfs.sh checks that
the subdirectory is writeable - by attempting to touch it!

[which is of course banned under the selinux policy]

consequently, the test fails, and only if the test _succeeds_ does
mountvirtfs.sh delete /etc/mtab. (with :> $MTAB_PATH)

so, as a temporary hack, i removed the "if dir_writable ${MTAB_PATH%/*}"
check.

result?

	/etc/mtab gets deleted.

result?

	/usr doesn't end up looking like it's still mounted (read-only in the
	case of the prior shutdown...]

result?

	/usr always gets mounted.

what an arse.

bugreporting time.

l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
