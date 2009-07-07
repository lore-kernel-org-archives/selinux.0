Subject: Re: [PATCH v5] setfiles converted to fts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Liu <tliu@redhat.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <1246892131.28321.35.camel@moss-pluto.epoch.ncsc.mil>
References: <1246480778.2771.0.camel@Ares>
	 <1246536793.13464.251.camel@moss-pluto.epoch.ncsc.mil>
	 <1246548607.2480.3.camel@Ares>
	 <1246554022.13464.348.camel@moss-pluto.epoch.ncsc.mil>
	 <1246558042.2480.5.camel@Ares>
	 <1246882816.27287.1.camel@moss-pluto.epoch.ncsc.mil>
	 <1246888179.2460.4.camel@Ares>
	 <1246892131.28321.35.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 07 Jul 2009 10:29:22 -0400
Message-Id: <1246976962.28321.232.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-07-06 at 10:55 -0400, Stephen Smalley wrote:
> On Mon, 2009-07-06 at 09:49 -0400, Thomas Liu wrote:
> > This is version 5 of the setfiles to fts patch.
> > 
> > The code has been cleaned up to adhere to the CodingStyle guidelines.
> > 
> > I have confirmed that the stat struct that fts returns for a symlink when using
> > the FTS_PHYSICAL flag is in fact the stat struct for the symlink, not the file
> > it points to (st_size is 8 bytes).
> > 
> > Instead of using fts_path for getfilecon/setfilecon it now uses fts_accpath,
> > which should be more efficient since fts walks the file hierarchy for us.
> > 
> > FreeBSD setfsmac uses fts in a similar way to how this patch does and one
> > thing that I took from it was to pass the FTSENT pointer around instead of
> > the names, because although fts_accpath is more efficient for get/setfilecon,
> > it is less helpful in verbose output (fts_path will give the entire path).
> > 
> > Here is the output from running restorecon on /
> > 
> > (nftw version)
> > restorecon -Rv / 2>/dev/null
> > restorecon reset /dev/pts/ptmx context system_u:object_r:devpts_t:s0->system_u:object_r:ptmx_t:s0
> > 
> > (new version)
> > ./restorecon -Rv / 2>/dev/null
> > ./restorecon reset /dev/pts/ptmx context system_u:object_r:devpts_t:s0->system_u:object_r:ptmx_t:s0
> > 
> > Here are some benchmarks each was run twice from a fresh
> > boot in single user mode (shown are the second runs).
> > 
> > (nftw version)
> > restorecon -Rv /usr
> > real	1m56.392s
> > user	1m49.559s
> > sys	0m6.012s
> > 
> > (new version)
> > ./restorecon -Rv /usr
> > real	1m55.102s
> > user	1m50.427s
> > sys	0m4.656s
> > 
> > So not much of a change, though some work has been pushed from kernel space
> > to user space.
> > 
> > It turns out setting the FTS_XDEV flag tells fts not to descend into 
> > directories with different device numbers, but fts will still give back the
> > actual directory.  I think nftw would completely avoid the directories as well
> > as their contents.
> > 
> > This patch fixed this issue by saving the device number of the directory
> > that was passed to setfiles and then skipping all action on any directories
> > with a different device number when the FTS_XDEV flag is set.
> > 
> > Also removed some code that removed beginning and trailing slashes
> > from paths, since fts seems to handle it.
> > 
> > Signed-off-by: Thomas Liu <tliu@redhat.com>
> > ---
> > Sending again due to whitespace damage, also used git diff so that
> > the patch is p1 appliable.
> 
> I meant relative to the root of the git repo, e.g.
> git clone http://oss.tresys.com/git/selinux.git
> cd selinux/policycoreutils
> <apply your patch>
> git diff
> 
> But that's ok.  Looks fine to me, although I would have preferred that
> the local var decls go at the beginning of the function.
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merged with a change to move up those local var decls in policycoreutils
2.0.66.  Thanks!

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
