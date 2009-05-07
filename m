Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n47ITqKh007219
	for <selinux@tycho.nsa.gov>; Thu, 7 May 2009 14:29:52 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n47IXT1j023548
	for <selinux@tycho.nsa.gov>; Thu, 7 May 2009 18:33:30 GMT
Message-ID: <4A032899.6040509@redhat.com>
Date: Thu, 07 May 2009 14:29:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fixes for libselinux/matchpathcon
References: <C6289E43.A6F98%csellers@tresys.com>
In-Reply-To: <C6289E43.A6F98%csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/07/2009 02:18 PM, Chad Sellers wrote:
> On 4/1/09 10:19 AM, "Daniel J Walsh"<dwalsh@redhat.com>  wrote:
> <snip>
>> If matchpathcon returns ENOENT, we return<<none>>
>
> matchpathcon doesn't set errno. The underlying selabel functions do, which
> is why this works sometimes. Unfortunately, you don't know which of the
> underlying functions set errno, so you display<<none>>  if any of them set
> errno to ENOENT. For instance, if the file_contexts file is missing, the
> selabel_open() call sets errno to ENOENT. It would be better to change
> matchpathcon() itself (and possibly it's underlying functions like
> matchpathcon_init()) to report back errors depending on what failed.
>
> Thanks,
> Chad
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
Patches accepted.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
