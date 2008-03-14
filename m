Subject: Re: How to handle security_dentry_open when the open flags are
	'special'
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: Eric Paris <eparis@redhat.com>, selinux <selinux@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        casey@schaufler-ca.com
In-Reply-To: <43af0f430803130456y844d429j2a64fb46ec4d71a7@mail.gmail.com>
References: <1205349239.2925.11.camel@localhost.localdomain>
	 <7e0fb38c0803121220w21275aadl7f148eccf645a7f1@mail.gmail.com>
	 <43af0f430803130456y844d429j2a64fb46ec4d71a7@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 14 Mar 2008 10:16:39 -0400
Message-Id: <1205504199.22912.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-03-13 at 07:56 -0400, Stephen Smalley wrote:
> Eric,
> 
> IIUC, in this situation, we are setting up a file that cannot be used
> for read or write operations due to its lack of FMODE_READ or
> FMODE_WRITE.  Thus, we don't actually need to check anything in
> selinux_dentry_open - that check is only to avoid losing checking on
> read/write revalidation altogether in the case where the policy seqno
> or file label has changed since the inode_permission check.  If we can
> never use this file for read/write, it isn't needed.
> 
> For the revalidation of open files on exec or transfer, if it cannot
> be used for read or write, then we likewise can't (and don't need to)
> revalidate it.  If/when it gets used in a ioctl call, we'll check it
> via selinux_file_ioctl.
> 
> Thus, IMHO, we need to change callers of file_to_av() to check for a 0
> return and skip checking in that case - it is apparently a legal case
> that we didn't realize originally.

Alternatively, we could default to returning FILE__IOCTL from
file_to_av() if the f_mode has neither FMODE_READ nor FMODE_WRITE, and
thus check ioctl permission on exec or transfer, thereby validating such
descriptors early as with normal r/w descriptors and catching leaks of
them prior to attempted usage.

selinux_dentry_open() though doesn't need to check anything in this
case; its checking is only required for descriptors that can later be
used in read/write operations.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
