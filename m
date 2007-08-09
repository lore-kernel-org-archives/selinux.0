Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79II4Jj027448
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 14:18:04 -0400
Subject: Re: Upstreaming shared LSM interfaces
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: David Howells <dhowells@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <Pine.LNX.4.64.0708091111470.19611@us.intercode.com.au>
References: <1186682361.14386.27.camel@moss-terrapins.epoch.ncsc.mil>
	 <Pine.LNX.4.64.0708091111470.19611@us.intercode.com.au>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 14:13:03 -0400
Message-Id: <1186683183.14386.29.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Redirected to the SELinux mailing list, and I am leaving David Howells
on the CC line since he isn't actually on the SELinux mailing list.


On Thu, 2007-08-09 at 11:12 -0700, James Morris wrote:
> Please discuss technical issues on a public mailing list.
> 
> 
> On Thu, 9 Aug 2007, David P. Quigley wrote:
> 
> > Hello Everyone,
> > 	Between Casey's Audit patches, the FS-Cache patches and the Labeled NFS
> > patches there are a bunch of new LSM interfaces being proposed that some
> > combination of us seem to need. I would like to propose that we agree on
> > the interfaces and send them to James to be upstreamed. The interfaces
> > and the proposed prototypes are listed below
> > 
> > Interfaces:
> > 
> > inode_{get,set}secid: From Labeled NFS patches
> > void (*inode_getsecid)(struct inode *inode, u32 *secid);
> > void (*inode_setsecid)(struct inode *inode, u32 secid);
> > 
> > 
> > ipc_getsecid: From Audit patches
> > void (*ipc_getsecid) (struct kern_ipc_perm *p, u32 *secid);
> > 
> > {get,set}_fscreate_secid: From FS-Cache patches
> > u32 (*get_fscreate_secid)(void);
> > u32 (*set_fscreate_secid)(u32 secid);
> > 
> > 
> > secctx_to_secid: From Labeled NFS patches
> > int (*secctx_to_secid)(u32 *secid, char *secdata, u32 seclen);
> > 
> > act_as_{secid,self}: From FS-Cache patches
> > u32 (*act_as_secid)(u32 secid);
> > u32 (*act_as_self)(void);
> > 
> > 
> > Dave Quigley
> > 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
