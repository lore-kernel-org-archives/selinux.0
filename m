MIME-Version: 1.0
In-Reply-To: <AANLkTimtVyT-7p+6H9=8KGE=cmHNr7kgramsdH5coWwv@mail.gmail.com>
References: <OFF4F848CC.EFE2D45E-ON8625783A.0076BBE7-8625783B.001141BA@us.ibm.com>
	<1298035684.23592.6.camel@moss-pluto>
	<OFEB82FE90.36E35458-ON8625783B.005690C6-8625783B.00594784@us.ibm.com>
	<1298046341.23592.16.camel@moss-pluto>
	<OFAB2AD310.C60A1CF4-ON8625783B.007027A3-8625783B.0071BDC6@us.ibm.com>
	<AANLkTimtVyT-7p+6H9=8KGE=cmHNr7kgramsdH5coWwv@mail.gmail.com>
Date: Fri, 18 Feb 2011 17:40:59 -0500
Message-ID: <AANLkTik76eqvav9NvFbKSacitH-aZ14vxUeDRc_JWYGY@mail.gmail.com>
Subject: Re: inode security state and cluster file systems
From: Eric Paris <eparis@parisplace.org>
To: Yuri L Volobuev <volobuev@us.ibm.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
        selinux@davequigley.com, swhiteho@redhat.com,
        Mark Fasheh <mfasheh@suse.com>, Joel Becker <jlbec@evilplan.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Resending adding linux-security-module to the thread.  Sorry if you
feel lost, you can try to look through the SELinux list history, but
some of this conversation didn't appear their since people are not
members.....

I can try to write a review if anyone needs/wants it....

On Fri, Feb 18, 2011 at 5:39 PM, Eric Paris <eparis@parisplace.org> wrote:
> On Fri, Feb 18, 2011 at 3:42 PM, Yuri L Volobuev <volobuev@us.ibm.com> wrote:
>>> > The logical place to make this call would be at d_revalidate time.
>>> >  The new value of the security context is not readily available at
>>> > that time, as described above.  Technically speaking, the file system
>>> > code could know the new context -- it can do a getxattr, which would
>>> > return the up-to-date label content.  However, this would require
>>> > knowing the security label xattr name, which is not readily available
>>> > in RHEL6.  (I actually had the code working with correct semantics on
>>> > RHEL5, which has security_inode_xattr_getsuffix(), but it would be
>>> > fair to say that it was hacking around the API rather than leveraging
>>> > it as intended).
>>> >
>>> > Hope it makes things clearer.
>>>
>>> Yes, thanks.  One lingering concern then is that we revalidate
>>> permissions on read/write via security_file_permission ->
>>> selinux_file_permission.  Within selinux_file_permission, we check
>>> whether the task SID, inode SID, or policy has changed since the file
>>> was opened, and if so, we recheck permissions.  If you only make the
>>> call at d_revalidate time, then we'll only update the inode sid on next
>>> lookup and thus ongoing reads/writes on an already open file will
>>> continue to succeed even if they should be denied by policy until some
>>> process on that node attempts another lookup.
>>
>> Interesting.  With plain Unix semantics, a permission check would be done at
>> file open time, and wouldn't be repeated at read/write time.  So there's no
>> attempt by the kernel proper to revalidate the associated dentry/inode prior
>> to calling read/write fop.  So, if the file owner were to change (for
>> example), the local inode would not necessarily have the correct owner prior
>> to a write, which is probably important.  So this is something that
>> transcends the issue of inode security state per se.
>>
>> Another possible approach here, as noted by GFS folks, is to invalidate
>> inode security state when a lock protecting it is lost.  GPFS could
>> certainly take that approach as well (it's done already for "regular" inode
>> state).  In this case, it sounds like kernel/LSM code would be responsible
>> to refreshing the inode security state when it's needed (although fs code
>> could also drive this explicitly at d_revalidate time).  I'd be fine with
>> that approach.
>
> I'm thinking about the GFS suggested approach of just 'invalidating'
> the inode security label.  It presents us with 2 problems I can see up
> front.  It really seems like filesystems would be upset when the next
> read/write calls starts running down the ->getxattr() code.  Even if
> they can handle the locking and such of having getxattr called at
> random times, most of those calls into the LSM only come with an
> inode.  But we need a dentry to make said ->getxattr calls.   (I
> believe this is a broken VFS problem, but the VFS requires a dentry)
>
> If we made the invalidation point an explicit refresh of the label at
> least the filesystems would be able to control both of those
> problems.....
>
> -Eric
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
