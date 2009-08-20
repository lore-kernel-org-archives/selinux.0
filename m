Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7KEFwm5003988
	for <selinux@tycho.nsa.gov>; Thu, 20 Aug 2009 10:15:58 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7KEFP1j005906
	for <selinux@tycho.nsa.gov>; Thu, 20 Aug 2009 14:15:26 GMT
Message-ID: <4A8D5A8F.8060306@manicmethod.com>
Date: Thu, 20 Aug 2009 10:15:43 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Thomas Liu <tliu@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/2] policAycoreutils: share setfiles restore function
 with restorecond
References: <1250711251.2835.25.camel@Hephaestus> <4A8C683F.8070005@manicmethod.com> <4A8C6F26.6080304@redhat.com>
In-Reply-To: <4A8C6F26.6080304@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> On 08/19/2009 05:01 PM, Joshua Brindle wrote:
>> Thomas Liu wrote:
>>> This patch edits restorecond to use the shared restore
>>>
>>> functions split out from the first patch in this series.
>>>
>> Is the DBus stuff in here suppose to be here? It looks like you are
>> adding libdbus and include dirs but I don't see any dbus usage.
>>
<snip>
>>
> restorcond -u is a dbus session bus service.
>
> The idea is to run restorecond as your UID when you log into a console session.
>

Maybe I don't get how DBus works. Why are the include dirs added to CFLAGS but 
no apparent dbus #includes?

Further, will this _only_ work with DBus after this patch? If so there needs to 
be a way to not build it if dbus isn't present on the system (embedded).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
