Subject: Re: Questions about extended attributes
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_2004@yahoo.com.cn>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20040214161254.87474.qmail@web15212.mail.bjs.yahoo.com>
References: <20040214161254.87474.qmail@web15212.mail.bjs.yahoo.com>
Content-Type: text/plain
Message-Id: <1077031564.16139.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 17 Feb 2004 10:26:05 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-02-14 at 11:12, Park Lee wrote:
> Dear sir,
>  What's the difference between extended attributes for file system and
> the old method of using persistent labeling mapping for persistent
> files and directories? 
>  Is it still using persistent security identifiers (PSIDs) in  
> extended attributes?
>  Where can I get more information about extended attributes for file
> system?

SELinux has gone through three phases in its approach to labeling files:
1) original SELinux kernel patch - SELinux stored an integer PSID in a
spare field of the on-disk ext2 inode and maintained a mapping from
PSIDs to contexts in regular files stored under a /...security directory
on each filesystem.
2) initial LSM-based SELinux -  Since LSM did not provide any
filesystem-specific hooks, the SELinux persistent label mapping was
changed to maintain the inode-to-PSID mapping as a regular file under
the /...security directory rather than using a spare field in the
on-disk inode.  This allowed SELinux to support most filesystem types
but at a cost in performance and consistency.
3) Current SELinux - As part of preparing SELinux for mainline
integration, SELinux was reworked to use the native Linux extended
attribute mechanism for storing file security contexts.  PSIDs are no
longer used at all, nor are there any /...security mapping files.  See
http://acl.bestbits.at for information about Linux extended attributes. 
Extended attribute support is included in 2.6, and patches exist for the
2.4 series.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
