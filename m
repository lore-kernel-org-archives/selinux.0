Message-ID: <3C1E0279.7030102@namesys.com>
Date: Mon, 17 Dec 2001 17:34:33 +0300
From: Hans Reiser <reiser@namesys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: forrest whitcher <fw@fwsystems.com>, SELinux@tycho.nsa.gov,
        "Vladimir V. Saveliev" <monstr@namesys.com>,
        Nikita Danilov <god@namesys.com>
Subject: Re: persistent labelling on afs, jfs, xfs?
References: <Pine.GSO.4.33.0112170709420.10438-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Sat, 15 Dec 2001, Hans Reiser wrote:
>
>>We currently have unique and persistent inode numbers (at least until we
>>someday write a repacker that will optimize key assignments for better
>>layout), but you can't use them for finding files that are not in the
>>cache.  To find such files requires a key.
>>
>
>SELinux uses the inode number as an identifier for the file in the
>persistent label mapping in each filesystem.   So it doesn't find files
>based on the inode number, but it needs each file in a filesystem to have
>a unique and persistent inode number.  It sounds like reiserfs does
>currently provide this property.
>
>--
>Stephen D. Smalley, NAI Labs
>ssmalley@nai.com
>
>
>
>
>
>

yes, so everything is easy for now.:)

Hans


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
