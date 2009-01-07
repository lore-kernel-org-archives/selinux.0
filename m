Message-ID: <a5e2b64d0901071528m4d33787bm307c05cb943979b1@mail.gmail.com>
Date: Thu, 8 Jan 2009 08:28:46 +0900
From: Tim <timasyk@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Reference policy: fc_sort bug (or feature?)
Cc: "SELinux mailing list" <SELinux@tycho.nsa.gov>
In-Reply-To: <1231357639.7517.2.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <a5e2b64d0812301805m706463b7o3aae6ab45502d32f@mail.gmail.com>
	 <1231357639.7517.2.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2009/1/8 Christopher J. PeBenito <cpebenito@tresys.com>:
> On Wed, 2008-12-31 at 11:05 +0900, Tim wrote:
>> While crafting reference policy to adjust it to my needs, I've
>> discovered a bug (or feature?) in fc_sort executable used to sort file
>> with files contexts.
>>
>> Discovered behaviour (refpolicy 20080702):
>> 1) If input file to fc_sort contains no files contexts definitions,
>> e.g. only comments starting with #, the fc_sort terminates with
>> Segmentation fault, core is dumped.
>> 2) If input file to fc_sort contains only one files context
>> definition, the fc_sort terminates with Segmentation fault, core is
>> dumped.
>> 3) fc_sort is working file if input file contains at least two files
>> contexts definitions.
>>
>> Is there any patch available to fix that bug (or feature)?
>
> A segfault certainly isn't a feature.  There currently isn't a fix for
> that yet, but more importantly why would you have so few or no file
> contexts (not that the segfault shouldn't be fixed)?
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>

I was making heavily customized policy for my device. For that I use
refpolicy as starting point. Also I've used genfscon for security
contexts labeling (with a patch to kernel to support security context
for individual files).

Since my filesystems do not use xattr, I did not use "regular"
security contexts labeling, so file_contexts file was empty.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
