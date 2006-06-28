Subject: Re: Wrong tclass on a cifs share content
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David-Alexandre Davidson <ryvore@gmail.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <44A2966A.2040905@gmail.com>
References: <44A2966A.2040905@gmail.com>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 11:19:02 -0400
Message-Id: <1151507942.20419.247.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-06-28 at 10:47 -0400, David-Alexandre Davidson wrote:
> When accessing folders over a cifs share from a selinux context, I get 
> audit messages, reporting denied actions
> such as 0x100000 and 0x200000 , which refers to search, and rmdir. The 
> problem is that selinux incorrectly
> report the target class as "file", when it is in reality a "dir" 
> element. Being unable to map these Hex code to
> a valid action for a file, every request is denied no mater what policy 
> rules are in effect. (actions like read,
> setattr, getattr are valid because they are the same for file and dir 
> elements)
>
> I'm running Fedora core 5 with the lastest stable kernel, and it can 
> easily be reproduced. Just map a cifs share,
> (I use automount) and attempt a rmdir  /theshare/sample_dir  as root. 
> and then :
> 
> type=AVC msg=audit(1151197545.712:144): avc:  denied  { 0x200000 } for  pid=2608
> comm="rmdir" name="sample_dir" dev=cifs ino=8889
> scontext=root:staff_r:staff_t:s0-s0:c0.c255 tcontext=system_u:object_r:cifs_t:s0
> tclass=file
> 
> 
> If anyone can help on that matter, or tell me who I should report this 
> to, it would be very appreciated. I
> believe it is related to the kernel either at the point the labeling is 
> made when the share is mounted, or
> if not, when selinux lookup the tclass on those element. Without 
> selinux, everything work fine, and no file
> system error occur. I'll be browsing the source code to find more 
> details about what causes this issue,
> but I'm not really familiar with that part of the kernel source.

It is a bad interaction between cifs and selinux.  Did you file a
bugzilla against the kernel as I suggested when you initially raised
this report on fedora-selinux-list?  SELinux does its inode security
setup upon d_instantiate, and expects the fs to have set up the base
inode state (such as the inode mode) by that point.  cifs appears to
violate this expectation.  One or the other will have to change.

If you just want to allow staff_t to perform arbitrary actions on the
mount, you could add:
	allow staff_t cifs_t:file *;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
