Subject: Re: Configuring kernel module for labeling ...
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: russell@coker.com.au, nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <200411030323.16648.russell@coker.com.au>
References: <1099385154.11681.3.camel@jsingh>
	 <200411030323.16648.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1099417545.12370.21.camel@jsingh>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 23:15:46 +0530
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, 

thanx for the mails ,... i really needed them ...

On Tue, 2004-11-02 at 21:53, Russell Coker wrote:
> On Tue, 2 Nov 2004 19:45, Jaspreet Singh <jsingh@ensim.com> wrote:
> > I am writing an overlayfs module which is not able to set/getxattrs of
> > the underlying etx3 dentries properly ???

> However I am concerned about your above paragraph, it is unclear and I can 
> interpret it in two ways - which require different policies.  Please describe 
> this problem in much more detail and I'll tell you the best answer.

ok so, the code base i am using is mini_fo curretly maintained at 
http://projects.programmers.ch/project/showfiles.php?group_id=14&release_id=41
I preferred using name as overlay_fs as it was more symbolic.

Itz a fanout file-system with gives Copy-On-Write when a RW storage is
mounted on RO base directory. The results are very satisfactory .. and i
am able to easily set/getxatts on the mount-point both using setfiles
and my own-simple C code.

The mini-fo sets/getattrs from the underlying lower-level file-systems
like ext2 and etx3 ... In case of a setxattr on the mount-file it
duplicates the file in storage and applies xattrs there.

> What is the entry in /proc/filesystems for that file system?

The proc-sys entry for this is "nodev mini_fo".

> Your problem is that the filesystem has type unlabeled_t.

How can i change that ???

> Stephen Smalley: Any interesting details prior to these avc's ..
One interesting thing was .. whenever i used to change xattrs of a
directory of the underlying filesys directly using
dentry->d_inode->i_op->setxattr the selinux used to refuse any
type_transitions for any file creating in that changed directory.
Although the xattrs of the dir used to be perfect.


> SELinux sets the security class when the dentry is instantiated for >
the inode based on the inode mode.

How can i check if the inode is exposing itself correctly or not ..
given the fact .. everything appears to be fine with unconfined_t and
problematic with httpd_t :-(

Hope this information helps ...

Thanx a lot for suggestions anyways ...
Jaspreet


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
