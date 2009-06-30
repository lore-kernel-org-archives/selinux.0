Subject: Re: [PATCH] setfiles converted to fts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Liu <tliu@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1246390368.2856.2.camel@Ares>
References: <1246390368.2856.2.camel@Ares>
Content-Type: text/plain
Date: Tue, 30 Jun 2009 15:47:31 -0400
Message-Id: <1246391251.13464.126.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-06-30 at 15:32 -0400, Thomas Liu wrote:
> This patch converted setfiles/restorecon to using fts instead of nftw.
> It also removed forking, pipes and pre_stat because Dan Walsh and I
> could not figure out what it was for.

See:
http://marc.info/?l=selinux&m=113627973615236&w=2
for the rationale for that logic.

Did you run any measurements to assess the impact of your changes on setfiles?

Did you compare with the implementation of setfsmac.c in FreeBSD, which
likewise started life as setfiles and was then rewritten to use fts()?

What improvements do we get from the changes?

Should we be using fts_path or fts_accpath when performing operations on
the files, like lsetfilecon()?  I suspect the latter would be more
efficient and less prone to simultaneous changes to the file tree if fts
switches the cwd as it walks the tree.

IIRC, we called lstat() within apply_spec() even though a struct stat
was supplied as an argument because in the case of symlinks, we were
getting the stat of the referenced file rather than of the symlink file.
Is this true of fts?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
