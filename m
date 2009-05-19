Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4JHZwgt027476
	for <selinux@tycho.nsa.gov>; Tue, 19 May 2009 13:35:58 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4JHa5Op011518
	for <selinux@tycho.nsa.gov>; Tue, 19 May 2009 17:36:05 GMT
Message-ID: <4A12EDFC.6020305@redhat.com>
Date: Tue, 19 May 2009 13:35:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: This patch fixes the exception handling in libselinux-python
 bindings
References: <C63853A5.A735D%csellers@tresys.com>
In-Reply-To: <C63853A5.A735D%csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/19/2009 12:16 PM, Chad Sellers wrote:
> On 5/18/09 2:10 PM, "Daniel J Walsh"<dwalsh@redhat.com>  wrote:
>
>> Basically we need to search for all interfaces that return an int and
>> set those up as python exception handlers.
>
> I presume this supercedes the patch submitted on March 4 titled "Patch to
> python bindings" which used a single generic exception handler. Is that
> correct? Why the switch from a generic exception handler to a shell script
> to generate lots of specific exception handlers?
>
> Thanks,
> Chad
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
Yes, that patch caused certain interfaces to not work if they did not 
return int.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
