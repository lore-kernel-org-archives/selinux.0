Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3UBi9I4003777
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 07:44:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3UBhv7R002063
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 11:43:58 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h3UBhvKP002060 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 11:43:57 GMT
Subject: Re: truncate(2) and setattr
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200304301034.38073.russell@coker.com.au>
References: <200304301034.38073.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1051703014.1118.116.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 30 Apr 2003 07:43:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-04-29 at 20:34, Russell Coker wrote:
> Why does truncate(2) require setattr access to the file?
> 
> Using truncate(file, len + 1) to increase the size of the file by 1 byte has 
> exactly the same affect on the file attributes as seeking to the end and 
> writing one byte.
> 
> Using truncate to make a file smaller has no greater affect on the file 
> attributes.

The size of a file is one of its attributes.  If you look at the
internal implementation in fs/open.c:do_truncate, you'll see that it
calls fs/attr.c:notify_change with flags indicating that the size and
ctime attributes are changing.  notify_change is also used for other
attribute changes, e.g. chown, chmod, utimes.  If you look at
fs/attr.c:notify_change, you'll see that it calls the
security_inode_setattr hook to perform a permission check prior to
calling the inode->i_op->setattr operation or the inode_setattr
function.  In SELinux, the corresponding hook function
(security/selinux/hooks.c:selinux_inode_setattr) always checks setattr
permission to the file.

Now, it is also true that fs/open.c:do_sys_truncate checks write
permission to the inode by calling fs/namei.c:permission, which calls
the security_inode_permission hook == selinux_inode_permission for
SELinux, and fs/open.c:do_sys_ftruncate requires that the file mode
includes write access.  Hence, at present, both write permission and
setattr permission are required for truncate.  This reflects the fact
that truncate affects both the file data and its size attribute.

A case could be made for splitting up the SELinux setattr file
permission into distinct permissions for the different attributes, and
checking the appropriate permission in selinux_inode_setattr based on
the iattr->ia_valid flags, similar to how fs/attr.c:inode_change_ok
performs different checks depending on those flags.  This is a fine line
in terms of balancing between providing least privilege and making the
policy unnecessarily complicated, as SELinux itself does not depend on
the values of these attributes for its own access controls.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
