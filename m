Subject: Re: Linux 2.6.13.4 --> 2.6.14.3 & security contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sami Farin <safari-selinux@safari.iki.fi>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1133366596.26593.345.camel@moss-spartans.epoch.ncsc.mil>
References: <20051129204523.GA29885@m.safari.iki.fi>
	 <1133365920.26593.338.camel@moss-spartans.epoch.ncsc.mil>
	 <20051130154955.GE29869@m.safari.iki.fi>
	 <1133366596.26593.345.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 11:09:23 -0500
Message-Id: <1133366963.26593.352.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-30 at 11:03 -0500, Stephen Smalley wrote:
> On Wed, 2005-11-30 at 17:49 +0200, Sami Farin wrote:
> > All are XFS.
> > 
> > /dev/root / xfs rw,noatime 0 0
> > /dev/hdc7 /var xfs rw,noatime 0 0
> > /dev/hdc8 /usr xfs rw,noatime 0 0
> > /dev/hdc9 /wrk xfs rw,noatime 0 0
> > /dev/loop0 /mnt/aes xfs rw,noatime,nosuid,nodev 0 0
> 
> Therein lies the problem.  As of 2.6.14, xfs is not supported with
> SELinux until such a time as the xfs developers update their filesystem
> to call the security_inode_init_security() hook and set the attribute on
> newly created inodes.  Please nag the xfs developers about this.  See:
> http://marc.theaimsgroup.com/?l=selinux&m=112653995

Re-sending with the list cc'd this time, as you dropped the list from
your reply and thus my reply also didn't include the list.  I think this
is of general interest; we are likely to receive more such reports in
the future, so I wanted it archived.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
