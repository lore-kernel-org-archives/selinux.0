Message-ID: <1345809991.18849.14.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Inheriting labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Fri, 24 Aug 2012 08:06:31 -0400
In-Reply-To: <CAFftDdqVC0ho6C0GzWsyLqSFkR71E7KaY5FeqJYbripPjG7DjA@mail.gmail.com>
References: 
	<CAFftDdqVC0ho6C0GzWsyLqSFkR71E7KaY5FeqJYbripPjG7DjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-08-23 at 21:16 -0700, William Roberts wrote:
> Suppose you have a directory in /efs/dir1 that is labeled as X
> 
> suppose you create /efs/dir1/B, it is unlabeled...
> 
> When I go to system or another partition, the label is inherited from
> the parent, how come it is not like this on efs?

That would be a bug.  What kernel are you using and what type of
filesystem do you have on /efs?  The filesystem code has to make a call
to SELinux on inode creation to get the security attribute name and
value, and then set that attribute as part of the inode creation
transaction.  The native Linux filesystem types include that support
already.  We had to patch yaffs2 to do it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
