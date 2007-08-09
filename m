Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79Jhha4003220
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 15:43:43 -0400
Received: from M4.sparta.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l79Jhfod016647
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 19:43:41 GMT
Received: from Beta5.sparta.com (beta5.sparta.com [157.185.63.21])
	by M4.sparta.com (8.13.5/8.13.5) with ESMTP id l79Jhf7t012853
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 14:43:41 -0500
Received: from nemo.columbia.ads.sparta.com (nemo.columbia.sparta.com [157.185.80.75])
	by Beta5.sparta.com (8.12.11/8.13.1) with ESMTP id l79Jhf0J008662
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 14:43:41 -0500
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <36BDDAA7-7173-42C5-A779-0BD6F1143625@sparta.com>
Cc: Chris Vance <Christopher.Vance@sparta.com>
From: Chris Vance <Christopher.Vance@sparta.com>
Subject: xattr and LSM interaction
Date: Thu, 9 Aug 2007 15:43:40 -0400
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Having spent a bit of time looking at the vfs_getxattr and  
vfs_setxattr (as well as the rest of the xattr management calls), I  
would appreciate a second opinion or an explanation of the  
interaction between the xattr code and the LSM code.

It's been a few years since I've lingered in the Linux kernel, so I  
might have missed another bit of code interaction.  Please let me  
know if my interpretation is wrong.

  107 ssize_t
  108 vfs_getxattr(struct dentry *dentry, char *name, void *value,  
size_t size)
  109 {
  110         struct inode *inode = dentry->d_inode;
  111         int error;
  112
  113         error = xattr_permission(inode, name, MAY_READ);
  114         if (error)
  115                 return error;
  116
  117         error = security_inode_getxattr(dentry, name);
  118         if (error)
  119                 return error;
  120
  121         if (inode->i_op->getxattr)
  122                 error = inode->i_op->getxattr(dentry, name,  
value, size);
  123         else
  124                 error = -EOPNOTSUPP;
  125
  126         if (!strncmp(name, XATTR_SECURITY_PREFIX,
  127                                 XATTR_SECURITY_PREFIX_LEN)) {
  128                 const char *suffix = name +  
XATTR_SECURITY_PREFIX_LEN;
  129                 int ret = security_inode_getsecurity(inode,  
suffix, value,
  130                                                      size, error);
  131                 /*
  132                  * Only overwrite the return value if a  
security module
  133                  * is actually active.
  134                  */
  135                 if (ret != -EOPNOTSUPP)
  136                         error = ret;
  137         }
  138
  139         return error;
  140 }

It looks like if the file system supports xattrs, I/O is performed to  
go off and retrieve the persistent xattr.  A few lines later, if  
SELinux is loaded (or any LSM), the persistent xattr value and error  
code are discarded and replaced by the in-memory inode label  
retrieved by security_inode_getsecurity().

I have a couple questions:
1) Why is the I/O essentially unconditional if the results are  
intended to be replaced by the value retrieved via the LSM hook.
2) Is it always correct to prefer the in-memory-LSM-retrieved  
representation over the persistent label?  I believe there are cases  
where the persistent label can be different from the in-memory inode  
label (if the persistent label is no longer valid in the context of  
the currently loaded policy, it will default to unlabeled_t, right?).
3) Is there a way to retrieve the actual persistent label, or is this  
never needed?

An unrelated side note is that hooks.c computes (sizeof  
XATTR_SECURITY_PREFIX - 1) vs. using XATTR_SECURITY_PREFIX_LEN.   
Sometimes the LSM hooks pass the entire xattr name, sometimes a  
portion of it.  The modules must have code to check for ownership a  
couple ways.

chris.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
