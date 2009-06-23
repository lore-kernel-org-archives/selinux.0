Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5NHA6Yq011992
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 13:10:06 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5NH9prs008323
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 17:09:51 GMT
Message-ID: <4A410C6B.4020406@manicmethod.com>
Date: Tue, 23 Jun 2009 13:10:03 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SELinux context patch
References: <C64DB16C.A7B20%csellers@tresys.com>
In-Reply-To: <C64DB16C.A7B20%csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Sellers wrote:
> On 5/18/09 2:16 PM, "Daniel J Walsh"<dwalsh@redhat.com>  wrote:
>
>> This patch adds context files for virtual_domain and virtual_image,
>> these are both being used to locat the default context to be executed by
>> svirt.
>>
>> I also included the subs patch which I submitted before.  This patch
>> allows us to substitute prefixes to matchpathcon.
>>
>> So we can say /export/home == /home
>>
>> and
>>
>> /web == /var/www
>
> The only problem I see with the patch is:
>
> +                       sub->dst=strdup(dst);
> +                       if (! sub->dst) {
> +                               free(sub);
> +                               free(sub->src);
> +                               return -1;
> +                       }
>
> the free()'s should be reversed in order. Other than that the patch looks
> fine. I'll fix this in the merge.
>
> Acked-by: Chad Sellers<csellers@tresys.com>
>

Merged in libselinux 2.0.82

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
