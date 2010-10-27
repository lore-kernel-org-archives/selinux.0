Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9RLI0Hx018142
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2010 17:18:00 -0400
Received: from smtp138.iad.emailsrvr.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9RLHxjx001394
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2010 21:17:59 GMT
Subject: Re: [RFC PATCH URL] mcstrans - SELInux Project contribution
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Joe Nall <joe@nall.com>
In-Reply-To: <4CC8908C.9010404@tresys.com>
Date: Wed, 27 Oct 2010 16:17:53 -0500
Cc: Xavier Toth <txtoth@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Message-Id: <41B73930-FF9A-4B34-9084-AABA0565E5D6@nall.com>
References: <AANLkTi=e6niGe9wFVFc_wKvaCTubN=QQjA5b0WbkSvVf@mail.gmail.com> <4CC8908C.9010404@tresys.com>
To: Steve Lawrence <slawrence@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Oct 27, 2010, at 3:50 PM, Steve Lawrence wrote:

> Due to size constrains, my changes for the mcstrans patch can be
> downloaded here:
> 
> http://oss.tresys.com/files/selinux/mcstrans-review.patch.tgz

Wow. Thanks for all the work on the review.

Are you going to put up a git tree at userspace.selinuxproject.org?

joe


> 
> The majority of the patch is just handling the case of memory
> allocation failures and making sure things get cleaned up correctly in
> those cases.
> 
> This also moves duplicate code in parse_ebitmap() and parse_raw() into
> parse_category(), and also updates the parse function to ensure the
> config files are in the correct format.
> 
> But aside from that, only very minor changes.
> 
> Reviewed by: Steve Lawrence <slawrence@tresys.com>
> 
> 
> On 07/21/2010 03:40 PM, Xavier Toth wrote:
>> Due to posting size constraints my previous attempt to post this patch
>> failed you can now find it at:
>> 
>> http://www.nall.com/tedx/mcstrans.patch.tgz
>> 
>> 
>> SELinux Project contribution of mcstrans. mcstrans is a userland package
>> specific to SELinux which allows system administrators to define sensitivity
>> levels and categories and provides a daemon for their translation into human
>> readable form. This version is a merge of Joe Nalls git tree (
>> http://github.com/joenall/mcstrans) and patches supplied by Dan Walsh and
>> others at RedHat.
>> 
>> Ted
>> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
