Message-ID: <4A4A7C29.5060807@redhat.com>
Date: Tue, 30 Jun 2009 16:57:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Thomas Liu <tliu@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] setfiles converted to fts
References: <1246390368.2856.2.camel@Ares> <1246391251.13464.126.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1246391251.13464.126.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/30/2009 03:47 PM, Stephen Smalley wrote:
> On Tue, 2009-06-30 at 15:32 -0400, Thomas Liu wrote:
>> This patch converted setfiles/restorecon to using fts instead of nftw.
>> It also removed forking, pipes and pre_stat because Dan Walsh and I
>> could not figure out what it was for.
>
> See:
> http://marc.info/?l=selinux&m=113627973615236&w=2
> for the rationale for that logic.
But this does not seem to be much benefit since fts files come with the 
stat already filled out.  Thomas removed all stat/lstat calls since you 
are not allowed to use the -D_FILE_OFFSET_BITS=64 with fts.
>
> Did you run any measurements to assess the impact of your changes on setfiles?
>
I think the biggest impact on speed comes from not trying to read past a 
failed directory.

One thing that would be helpful to add would be to check if a directory 
is on a files system that supports labeling, if not then the directory 
should be skipped.  I think with this patch the tool would walk a nfs_t 
file system unless it is called as setfiles.
> Did you compare with the implementation of setfsmac.c in FreeBSD, which
> likewise started life as setfiles and was then rewritten to use fts()?
>
> What improvements do we get from the changes?
>
> Should we be using fts_path or fts_accpath when performing operations on
> the files, like lsetfilecon()?  I suspect the latter would be more
> efficient and less prone to simultaneous changes to the file tree if fts
> switches the cwd as it walks the tree.
>
> IIRC, we called lstat() within apply_spec() even though a struct stat
> was supplied as an argument because in the case of symlinks, we were
> getting the stat of the referenced file rather than of the symlink file.
> Is this true of fts?
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
