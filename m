Subject: Re: genfscon problem
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1077138592.6667.35.camel@kusturica>
References: <1077138592.6667.35.camel@kusturica>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1077139326.17849.197.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 18 Feb 2004 16:22:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-02-18 at 16:09, Magosányi Árpád wrote:
> Hi!
> 
> I have this:
> genfscon selinuxfs /user                    object_u:object_r:tcb_mod_t
> 
> But my /selinux/user file continues to be tcb_t.
> 
> Did I made some mistake or genfscon isn't updated on policy reload?

Read the last two paras of the comment header for genfs_contexts or the
end of selinux-doc/PORTING. Also, even if genfs_contexts did support
fine-grained labeling of selinuxfs, a policy reload does not walk the
inode lists and reset the SIDs of incore inodes, so it wouldn't change
the SID of an inode that was already incore.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
