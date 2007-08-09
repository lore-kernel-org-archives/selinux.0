Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79IxbVY031488
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 14:59:37 -0400
Received: from web36604.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l79IxYVe023597
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 18:59:34 GMT
Date: Thu, 9 Aug 2007 11:59:27 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Fwd: Re: Upstreaming shared LSM interfaces
To: LSM List <linux-security-module@vger.kernel.org>,
        SELinux List <selinux@tycho.nsa.gov>,
        Audit List <linux-audit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <588796.69383.qm@web36604.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Casey Schaufler <casey@schaufler-ca.com> wrote:

> Date: Thu, 9 Aug 2007 11:43:53 -0700 (PDT)
> From: Casey Schaufler <casey@schaufler-ca.com>
> Subject: Re: Upstreaming shared LSM interfaces
> To: "David P. Quigley" <dpquigl@tycho.nsa.gov>,
>         Stephen Smalley <sds@tycho.nsa.gov>, James Morris
> <jmorris@namei.org>,
>         David Howells <dhowells@redhat.com>,
>         Casey Schaufler <casey@schaufler-ca.com>
> 
> 
> --- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:
> 
> > Hello Everyone,
> > 	Between Casey's Audit patches, the FS-Cache patches and the Labeled NFS
> > patches there are a bunch of new LSM interfaces being proposed that some
> > combination of us seem to need. I would like to propose that we agree on
> > the interfaces and send them to James to be upstreamed. The interfaces
> > and the proposed prototypes are listed below
> 
> I was wrong to propose the hooks that get the secids to feed to
> the audit system. I had hoped that I could contain the scope of
> the changes required to the audit system to pull SELinux dependencies
> out by allowing the continued use of secids in that case. I see
> now the error in my ways and will shortly proposed an alternative
> patch set for the deselinixifation of audit.
> 
> The secid is an internal SELinux data structure (albeit one with
> many favorable characteristics) and the LSM interface ought not
> be exposing it.
> 
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
> > 
> > 
> 
> 
> Casey Schaufler
> casey@schaufler-ca.com
> 
> 
> 


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
