Message-ID: <3C1B64C5.4000207@namesys.com>
Date: Sat, 15 Dec 2001 17:57:09 +0300
From: Hans Reiser <reiser@namesys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: forrest whitcher <fw@fwsystems.com>, SELinux@tycho.nsa.gov
Subject: Re: persistent labelling on afs, jfs, xfs?
References: <Pine.GSO.4.33.0112141652360.17166-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Fri, 14 Dec 2001, forrest whitcher wrote:
>
>>This is Reiserfs related.  The problem is that Reiserfs breaks the
>>inode-number assumption (the assumption is that a file is uniquely
>>represented by a device number for the partition and an inode number).
>>Unfortunately reiserfs doesn't do this, so AFS cache wont work.
>>
>
>We haven't tested SELinux with reiserfs, but others have claimed that it
>works.  However, if it is true that reiserfs doesn't have unique and
>persistent inode numbers for files, then SELinux will have problems with
>it.
>
>--
>Stephen D. Smalley, NAI Labs
>ssmalley@nai.com
>
>
>
>
>--
>You have received this message because you are subscribed to the selinux list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>
>
We currently have unique and persistent inode numbers (at least until we 
someday write a repacker that will optimize key assignments for better 
layout), but you can't use them for finding files that are not in the 
cache.  To find such files requires a key.

Hans



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
