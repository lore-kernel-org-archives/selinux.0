Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9QFBFXZ013111
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 11:11:15 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9QF9tC0026120
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 15:09:55 GMT
Date: Tue, 26 Oct 2004 16:21:55 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>,
   Colin Walters <walters@redhat.com>
Subject: Re: Proposed patch for libselinux
Message-ID: <20041026152155.GB8652@lkcl.net>
References: <41782BBA.9090101@redhat.com> <1098449318.7614.13.camel@moss-spartans.epoch.ncsc.mil> <20041022155639.GA4986@lkcl.net> <41796C01.4060909@redhat.com> <1098715957.13491.157.camel@moss-spartans.epoch.ncsc.mil> <20041026142126.GC8053@lkcl.net> <1098799981.27060.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098799981.27060.17.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 26, 2004 at 10:13:01AM -0400, Stephen Smalley wrote:
> On Tue, 2004-10-26 at 10:21, Luke Kenneth Casson Leighton wrote:
> >  it would appear, therefore, that no provision has been made for
> >  filesystem recovery.
> 
> star and (recently patched) rsync supports backing up security
> attributes from live filesystems.
> 
> >  i find frequently that ext3 filesystem damage results in fsck.ext3
> >  going "the extended attributes aren't valid: truncating".
> 
> I've never seen this.  Easily reproducible?
 
 this was four/five months ago - if you recall i sent details about it
 at the time, and part of the "solution" was to upgrade the / partition
 to ext3 (!)

 let me try and think.

 the circumstances under which this occurred were with a 2.6.7 selinux
 kernel, with an ext2 filesystem, i would do a make relabel: something
 was going badly wrong (which i never tracked down, i just moved on...)
 such that on the next reboot, the filesystem could not be shut down
 properly...

 ... it was related to that bug about having a program that would not
 let go of a file handle on the /usr partition, such that at shutdown
 time the /usr partition was remounted read-only, such that on startup
 /etc/mtab had a record of /usr being mounted read-only...

 ... and permission to overwrite /etc/mtab was banned from
 initrc_t, such that it was not possible to clear /etc/mtab,
 such that no mounting /usr AT ALL was done because /etc/mtab
 had a record of /usr being mounted read-only...

 ... at that point, things got very bad, i would have to shut down the
 computer: /etc/mtab would be cleared at shutdown (because no programs
 were or could be using the /usr partition)

 at _that_ point, on the next reboot, the filesystem would be severely
 damaged, and _that's_ when fsck.ext2 found stacks of damaged extended
 attributes, and would truncate them.

 
 so um... easily reproducible?  uhm... not really!!!

 slightly on the reassuring side:

 * i upgraded to 2.6.8 and haven't had the problem since.

 * i reported the problem about /etc/mtab and programs on /usr a couple
   of months back, and posted a fix for the /etc/init.d scripts (i
   think) which russell has since incorporated into initscripts.

   /etc/init.d/mountvirtfs.  yes.

   oh yes that's right it was to do with the detection of whether
   /etc was on a writeable partition by attempting to "touch /etc"
   from an initrc_t context - which of course will fail: the necessary
   change was to touch /etc/mtab instead.

 * i converted the / partition from ext2 to ext3 and thus "avoided"
   the issue.

 l.
 
-- 
--
you don't have to BE MAD   | this space    | my brother wanted to join mensa,
  to work, but   IT HELPS  |   for rent    | for an ego trip - and get kicked 
 you feel better!  I AM    | can pay cash  | out for a even bigger one.
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
