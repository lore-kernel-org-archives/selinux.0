Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA10753
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 12:14:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA07949
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 17:13:42 GMT
Received: from smtp-server1.tampabay.rr.com (smtp-server1.tampabay.rr.com [65.32.1.34])
        by jazzband.ncsc.mil  with ESMTP id RAA07945 for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 17:13:42 GMT
Message-ID: <3C4857EB.1090503@netzero.net>
Date: Fri, 18 Jan 2002 12:14:19 -0500
From: Paul Kronenwetter <kronenpj@netzero.net>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: Justin Smith <jsmith@mcs.drexel.edu>, selinux@tycho.nsa.gov
Subject: Re: ext3 file system
References: <Pine.GSO.4.33.0201181023090.3743-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Actually the .journal files are only visible when they're created on a 
mounted filesystem.  If they're created by mke2fs -j they're made invisible.

So Stephen's machine was a clean install of Red Hat 7.2 and Justin's was 
an upgrade or a manual enhancement of an ext2 fs.

-Paul

Stephen Smalley wrote:

>On 17 Jan 2002, Justin Smith wrote:
>
>>When trying to label files with the setfiles utilities, the process
>>crashes when they encounter the .journal files. These are user-visible,
>>but are not regular files (they are immutable in the sense that even
>>root cannot change them in any way). The setfiles utilities issue a
>>warning that they cannot write to .journal and quit.
>>
>>Any ideas?
>>
>>Perhaps there should be some way of exempting the .journal files from
>>the labelling process. It is unfortunate that they are visible to users
>>(since users cannot actually use them for anything).
>>
>
>
>
>
>
>--
>You have received this message because you are subscribed to the selinux list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
