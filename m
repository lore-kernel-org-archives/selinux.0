Subject: Re: [PATCH] setfiles converted to fts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Thomas Liu <tliu@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <4A4A7C29.5060807@redhat.com>
References: <1246390368.2856.2.camel@Ares>
	 <1246391251.13464.126.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4A7C29.5060807@redhat.com>
Content-Type: text/plain
Date: Wed, 01 Jul 2009 09:41:59 -0400
Message-Id: <1246455719.13464.141.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-06-30 at 16:57 -0400, Daniel J Walsh wrote:
> On 06/30/2009 03:47 PM, Stephen Smalley wrote:
> > On Tue, 2009-06-30 at 15:32 -0400, Thomas Liu wrote:
> >> This patch converted setfiles/restorecon to using fts instead of nftw.
> >> It also removed forking, pipes and pre_stat because Dan Walsh and I
> >> could not figure out what it was for.
> >
> > See:
> > http://marc.info/?l=selinux&m=113627973615236&w=2
> > for the rationale for that logic.
> But this does not seem to be much benefit since fts files come with the 
> stat already filled out.  Thomas removed all stat/lstat calls since you 
> are not allowed to use the -D_FILE_OFFSET_BITS=64 with fts.

I'm open to considering the change, but I'd like to see actual
measurements before and after the changes.

I'd also like answers to the questions I posed regarding use of fts_path
vs. fts_accpath (I think we should be using the latter for calls to
getfilecon and setfilecon at least), whether the removal of the extra
lstat call changes behavior for symlinks (nftw would pass the stat
struct of the referenced file rather than the symlink, and the man page
for fts suggests that it may do likewise, which may change how we end up
labeling symlinks due to the different modes), and whether you looked at
the FreeBSD setfsmac.c implementation to see if we can learn anything
useful from it.

> > Did you run any measurements to assess the impact of your changes on setfiles?
> >
> I think the biggest impact on speed comes from not trying to read past a 
> failed directory.
> 
> One thing that would be helpful to add would be to check if a directory 
> is on a files system that supports labeling, if not then the directory 
> should be skipped.  I think with this patch the tool would walk a nfs_t 
> file system unless it is called as setfiles.
> > Did you compare with the implementation of setfsmac.c in FreeBSD, which
> > likewise started life as setfiles and was then rewritten to use fts()?
> >
> > What improvements do we get from the changes?
> >
> > Should we be using fts_path or fts_accpath when performing operations on
> > the files, like lsetfilecon()?  I suspect the latter would be more
> > efficient and less prone to simultaneous changes to the file tree if fts
> > switches the cwd as it walks the tree.
> >
> > IIRC, we called lstat() within apply_spec() even though a struct stat
> > was supplied as an argument because in the case of symlinks, we were
> > getting the stat of the referenced file rather than of the symlink file.
> > Is this true of fts?
> >
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
