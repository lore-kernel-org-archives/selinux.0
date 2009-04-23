Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3N3206X006250
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 23:02:00 -0400
Received: from fk-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3N31xoV028140
	for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2009 03:01:59 GMT
Received: by fk-out-0910.google.com with SMTP id z22so139422fkz.2
        for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 20:01:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C61510C5.A6A7F%csellers@tresys.com>
References: <9f066ee90904220426g563d2ebpa708ef8b6e1a4378@mail.gmail.com>
	 <C61510C5.A6A7F%csellers@tresys.com>
Date: Wed, 22 Apr 2009 23:01:56 -0400
Message-ID: <9f066ee90904222001xb31b39ajf6953ca0767f3494@mail.gmail.com>
Subject: Re: labeled network aware kernel
From: Mark Webb <elihusmails@gmail.com>
To: Chad Sellers <csellers@tresys.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am looking at the IPSec-based labeled networking.

BTW.  I will be at the Tresys Advanced Policy course next week.  Is
any of this covered there?

Thanks,

On Wed, Apr 22, 2009 at 6:21 PM, Chad Sellers <csellers@tresys.com> wrote:
> Josh's article talks about IPSec labeled networking (as well as using
> SECMARK which provides firewall-level networking controls), as opposed to
> Netlabel labeled networking. I played with the IPSec-based stuff in Fedora 9
> and everything was there, so I'd imagine it's still there in F10. Just make
> sure you install ipsec-tools.
>
> Chad Sellers
>
>
> On 4/22/09 7:26 AM, "Mark Webb" <elihusmails@gmail.com> wrote:
>
>> I am interested in experimenting with the labeled networking that SE
>> Linux offers.  I am reading through Josh Brindle's blog
>>
>> http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux/
>>
>> My question is, how do I know if my kernel is capable of supporting
>> this?  I am currently running Fedora 10 with all the latest updates
>> but not sure how to check.
>>
>> Also if I compile a kernel from source, is there anything that needs
>> to be done in the configuring of the kernel build to enable the
>> labeled networking?
>>
>> Thanks,
>> Mark
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
