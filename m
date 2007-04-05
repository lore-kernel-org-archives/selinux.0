Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l35E7AYK029886
	for <selinux@tycho.nsa.gov>; Thu, 5 Apr 2007 10:07:10 -0400
Received: from mail4.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l35E78v5014282
	for <selinux@tycho.nsa.gov>; Thu, 5 Apr 2007 14:07:08 GMT
Date: Thu, 5 Apr 2007 10:07:05 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: James Carter <jwcart2@tycho.nsa.gov>
cc: SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [patch 0/3] selinux: fix of selinuxfs inode number assigning
 and cleanup of selinuxfs
In-Reply-To: <1175717910.14463.69.camel@moss-lions.epoch.ncsc.mil>
Message-ID: <Line.LNX.4.64.0704051006570.32651@d.namei>
References: <1175717910.14463.69.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 4 Apr 2007, James Carter wrote:

> This patch set fixes a potential problem of inode number conflicts in
> selinuxfs, makes numbering the inodes in the booleans directory
> consistent with what is done for the initial_contexts directory, and
> removes an unused enumeration constant.

All applied.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
