Subject: Re: inode security state and cluster file systems
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuri L Volobuev <volobuev@us.ibm.com>
Cc: selinux@davequigley.com, SELinux@tycho.nsa.gov, swhiteho@redhat.com,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <OFEB82FE90.36E35458-ON8625783B.005690C6-8625783B.00594784@us.ibm.com>
References: 
	 <OFF4F848CC.EFE2D45E-ON8625783A.0076BBE7-8625783B.001141BA@us.ibm.com>
	 <1298035684.23592.6.camel@moss-pluto>
	 <OFEB82FE90.36E35458-ON8625783B.005690C6-8625783B.00594784@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Feb 2011 11:25:41 -0500
Message-ID: <1298046341.23592.16.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-02-18 at 10:15 -0600, Yuri L Volobuev wrote:
> The logical place to make this call would be at d_revalidate time.
>  The new value of the security context is not readily available at
> that time, as described above.  Technically speaking, the file system
> code could know the new context -- it can do a getxattr, which would
> return the up-to-date label content.  However, this would require
> knowing the security label xattr name, which is not readily available
> in RHEL6.  (I actually had the code working with correct semantics on
> RHEL5, which has security_inode_xattr_getsuffix(), but it would be
> fair to say that it was hacking around the API rather than leveraging
> it as intended).
> 
> Hope it makes things clearer.

Yes, thanks.  One lingering concern then is that we revalidate
permissions on read/write via security_file_permission ->
selinux_file_permission.  Within selinux_file_permission, we check
whether the task SID, inode SID, or policy has changed since the file
was opened, and if so, we recheck permissions.  If you only make the
call at d_revalidate time, then we'll only update the inode sid on next
lookup and thus ongoing reads/writes on an already open file will
continue to succeed even if they should be denied by policy until some
process on that node attempts another lookup.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
