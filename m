Subject: Re: avc: denied with kernel module .. someone help !!!
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: jsingh@ensim.com
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, nsa <SELinux@tycho.nsa.gov>,
   Colin Walters <walters@verbum.org>
In-Reply-To: <1099409000.12251.17.camel@jsingh>
References: <1099347144.9776.3.camel@jsingh>
	 <1099347590.9784.3.camel@jsingh>  <20041102003903.GR9643@lkcl.net>
	 <1099409000.12251.17.camel@jsingh>
Content-Type: text/plain
Message-Id: <1099410670.31739.162.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 10:51:10 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-02 at 10:23, Jaspreet Singh wrote:
> overlay_fs is a layer ... on top of other file-systems ... which does a
> BSD unionfs kind of thing. It exposes methods to get/setxattrs and
> depends upon the underlying file-systems for it. So i am successfully
> able to use 'setfiles' on top of it ...

The code for this filesystem is available where?

> apache at-random starts considering all files and dirs as fifo_file and
> start giving blank denials like -
> 
>  avc:  denied  { } for  pid=1687 exe=/usr/sbin/httpd name=home
> dev=overlay_fs ino=109 scontext=root:system_r:httpd_t
> tcontext=system_u:object_r:home_root_t tclass=fifo_file
> 
> on re-mounts some of the avc's disappear ..and this is random.

Any interesting output related to your overlay_fs prior to these
denials?  The blank denial is because the permission being checked isn't
defined for that security class. Most likely this is a "search" check on
a directory, but since SELinux thinks it is a fifo, it fails to map the
permission.  SELinux sets the security class when the dentry is
instantiated for the inode based on the inode mode.  If the filesystem
isn't setting the inode mode correctly, then there isn't much we can do.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
