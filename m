Date: Wed, 5 Sep 2007 23:45:08 +0900
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
To: Paul Moore <paul.moore@hp.com>
Cc: himainu-ynakam@miomio.jp, ynakam@hitachisoft.jp, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov, busybox@kaigai.gr.jp, jmorris@namei.org,
        eparis@parisplace.org, kaigai@ak.jp.nec.com
Subject: Re: [RFC]Tuning selinux_file_permission
Message-Id: <20070905234508.2f6e483f.himainu-ynakam@miomio.jp>
In-Reply-To: <200709051019.44607.paul.moore@hp.com>
References: <20070903170020.D7E4.YNAKAM@hitachisoft.jp>
	<200709051019.44607.paul.moore@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 5 Sep 2007 10:19:44 -0400
Paul Moore wrote:
> On Monday, September 3 2007 4:04:46 am Yuichi Nakamura wrote:
> > +static int selinux_file_permission(struct file *file, int mask)
> > +{
> > +
> > +	struct task_security_struct *tsec = current->security;
> > +	struct file_security_struct *fsec = file->f_security;
> > +	int rc;
> > +	u32 current_sid_serial;
> > +
> > +	if (!mask) {
> > +		/* No permission to check.  Existence test. */
> > +		return 0;
> > +	}
> > +
> > +	/*Check FS__USE*/
> > +	if (tsec->sid != fsec->sid) {
> > +		struct vfsmount *mnt = file->f_path.mnt;
> > +		struct dentry *dentry = file->f_path.dentry;
> > +		struct avc_audit_data ad;
> > +		AVC_AUDIT_DATA_INIT(&ad, FS);
> > +		ad.u.fs.mnt = mnt;
> > +		ad.u.fs.dentry = dentry;
> > +		rc = avc_has_perm(tsec->sid, fsec->sid,
> > +				  SECCLASS_FD,
> > +				  FD__USE,
> > +				  &ad);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	/*Skip permission check
> > +	  when sids are not changed after open*/
> > +	current_sid_serial = read_sid_serial();
> > +	if (fsec->sid_serial == current_sid_serial &&
> > +	    !(fsec->force_file_check))
> > +		return 0;
> 
> Instead of simply returning 0 here, you should return the return value from 
> selinux_netlbl_inode_permission just like you are doing in your 
> do_selinux_file_permission() function above.
> 
> This NetLabel call is required to ensure that the on-the-wire label is set 
> correctly for connected stream sockets initiated by a remote host.  It may be 
> possible to do away with this call at some point but it requires additional 
> functionality which we do not have at present.

Thanks,
I forgot about that.
I will fix it in next patch.

> 
> > +	rc = do_selinux_file_permission(file, mask);
> > +	if (rc)
> > +		return rc;
> > +
> > +	fsec->sid_serial = current_sid_serial;
> > +	fsec->force_file_check = 0;
> > +
> > +	return 0;
> > +}
> 
> -- 
> paul moore
> linux security @ hp
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

Regards,
Yuichi Nakamura




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
