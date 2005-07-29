Subject: Re: SELinux for embedded devices...
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   "Sriram, Kannan" <ksriram@ti.com>,
   Lorenzo Hern?ndez Garc?a-Hierro <lorenzo@gnu.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1122643005.6573.115.camel@moss-spartans.epoch.ncsc.mil>
References: <45F366B1BC4F7C4A895F0F34C41E61A55113E1@dbde01.ent.ti.com>
	 <20050729084419.GD11752@lkcl.net>
	 <1122643005.6573.115.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 17:08:08 -0400
Message-Id: <1122671289.20983.89.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-07-29 at 09:16 -0400, Stephen Smalley wrote:
> On Fri, 2005-07-29 at 09:44 +0100, Luke Kenneth Casson Leighton wrote:
> > On Fri, Jul 29, 2005 at 10:17:18AM +0530, Sriram, Kannan wrote:
> > > Does SELinux require a writeable filesystem always? 
> > 
> >  no, it doesn't.
> > 
> >  however, nobody with the skills to add xattrs to any of
> >  the read-only filesystems has yet gone ahead and done it /
> >  had a requirement strong enough to justify adding xattrs.
> >  [i added xattrs to tmpfs because i really needed it and there
> >  were enough simple examples to copy].
> > 
> >  i too would like to use selinux-enabled squashfs or other
> >  read-only filesystem, because that's a _fantastic_ way of
> >  getting a secure OS.  someone's root-kitted the machine?
> >  oh dearie me: reboot it and you _know_ that the squashfs-based
> >  live boot CD will get you back up-and-running.
> 
> I think that prior SELinux LiveCDs just loaded an ext3 or ext2
> filesystem into ram, so the medium was still read-only, but you could
> set/get the xattrs in the memory-backed ext2/ext3 fs.

The Gentoo SELinux LiveCD loads up a large, ext2 labeled initrd for a
bare minimum root filesystem and a small writable area, so the user can
still set a resolv.conf, for example.  Then the remaining parts of the
filesystem are ext2 labeled filesystem images on the cd, mounted by
loopback.  Now that tmpfs has labels, that is another option, rather
then having a large initrd (in terms of writable areas).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
