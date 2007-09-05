From: Paul Moore <paul.moore@hp.com>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
Subject: Re: [RFC]Tuning selinux_file_permission
Date: Wed, 5 Sep 2007 10:19:44 -0400
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        busybox@kaigai.gr.jp, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, kaigai@ak.jp.nec.com
References: <20070903170020.D7E4.YNAKAM@hitachisoft.jp>
In-Reply-To: <20070903170020.D7E4.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709051019.44607.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, September 3 2007 4:04:46 am Yuichi Nakamura wrote:
> +static int selinux_file_permission(struct file *file, int mask)
> +{
> +
> +	struct task_security_struct *tsec = current->security;
> +	struct file_security_struct *fsec = file->f_security;
> +	int rc;
> +	u32 current_sid_serial;
> +
> +	if (!mask) {
> +		/* No permission to check.  Existence test. */
> +		return 0;
> +	}
> +
> +	/*Check FS__USE*/
> +	if (tsec->sid != fsec->sid) {
> +		struct vfsmount *mnt = file->f_path.mnt;
> +		struct dentry *dentry = file->f_path.dentry;
> +		struct avc_audit_data ad;
> +		AVC_AUDIT_DATA_INIT(&ad, FS);
> +		ad.u.fs.mnt = mnt;
> +		ad.u.fs.dentry = dentry;
> +		rc = avc_has_perm(tsec->sid, fsec->sid,
> +				  SECCLASS_FD,
> +				  FD__USE,
> +				  &ad);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	/*Skip permission check
> +	  when sids are not changed after open*/
> +	current_sid_serial = read_sid_serial();
> +	if (fsec->sid_serial == current_sid_serial &&
> +	    !(fsec->force_file_check))
> +		return 0;

Instead of simply returning 0 here, you should return the return value from 
selinux_netlbl_inode_permission just like you are doing in your 
do_selinux_file_permission() function above.

This NetLabel call is required to ensure that the on-the-wire label is set 
correctly for connected stream sockets initiated by a remote host.  It may be 
possible to do away with this call at some point but it requires additional 
functionality which we do not have at present.

> +	rc = do_selinux_file_permission(file, mask);
> +	if (rc)
> +		return rc;
> +
> +	fsec->sid_serial = current_sid_serial;
> +	fsec->force_file_check = 0;
> +
> +	return 0;
> +}

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
