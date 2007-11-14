MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Re: Kernel oops on fc6 with non-mls policy
Date: Wed, 14 Nov 2007 16:23:42 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801331BF7@exchange.columbia.tresys.com>
From: "Brian M. Williams" <bwilliams@tresys.com>
To: "Eric Paris" <eparis@redhat.com>
Cc: "Joshua Brindle" <jbrindle@tresys.com>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "James Morris" <jmorris@namei.org>, "Paul Moore" <paul.moore@hp.com>,
        <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>-----Original Message-----
>From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Eric Paris
>Sent: Thursday, February 01, 2007 3:20 PM
>To: Joshua Brindle
>Cc: selinux@tycho.nsa.gov; Stephen Smalley; Karl MacMillan; Paul Moore;
James Morris
>Subject: Re: Kernel oops on fc6 with non-mls policy
>
>On Thu, 2007-02-01 at 14:58 -0500, Joshua Brindle wrote:
>> There seems to be a kernel oops on non-mls policies with the fc6
kernel.
>> It appears that netlabel is the culprit but I couldn't immediately
track
>> down the issue, the mls functions all seem to be returning if mls is
>> disabled. The oops and ksymoops output is available at
>> http://pastebin.com/872996.
>>
>> I have seen another that isn't there that happens on
unix_stream_connect
>> and oopses in security_sid_mls_copy->ebitmap_cpy.
>>
>> Is this a known issue?
>
>http://marc2.theaimsgroup.com/?l=selinux&m=116920292206962&w=2
>
>I believe.
>
>Will get fixed in FC7 when the kernel gets new enough to pick it up
from
>upstream.  Will not get fixed in RHEL5 until U1.

I just tried to run a RHEL5 U1 system with a non-mls policy and this
appears to still be a problem, are there plans to fix the bug in U2?

Brian

>
>-Eric
>
>
>--
>This message was distributed to subscribers of the selinux mailing
list.
>If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
