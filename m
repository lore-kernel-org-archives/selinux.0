Message-ID: <440F520C.8080604@cornell.edu>
Date: Wed, 08 Mar 2006 16:52:12 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Desktop Integration Take 2
References: <4404BA44.8000503@cornell.edu> <440F2E61.4070905@cornell.edu> <A98716CB-BC6B-4EFE-B480-2B31C8D6FACD@nall.com>
In-Reply-To: <A98716CB-BC6B-4EFE-B480-2B31C8D6FACD@nall.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>> - Have a file controlled by libsetrans which maps mls ranges to 
>>> (unicode?) translated strings
>>>     (setrans.conf)
>>>
>>> - Require the mappings above to be 1:1.
> ...
>
> The work I'm doing on better MLS inverse bit handing (rel 
> country1/country2 ...) in libsetrans supports mapping label fragments 
> (individual categories and category ranges) in addition to the current 
> 1:1 mapping.
It was my understanding that the range should be treated as a whole for 
maximum generality, and we shouldn't unroll and translate individual 
categories [ at least for the purposes of nautilus ]. That way you could 
have a coded clearance label like: NSASecretProject, that unrolls to the 
actual categories [ say NDA_1, NDA_3, Programmer, NSA, Security, 
Confidential, ProjectX ], without listing them all individually.
> With 256 bits, 1:1 MLS mappings are not practical because the number 
> of potential combinations is so great. I hope to have a patch for 
> review at by the end of next week.
My comment said they should be 1:1, not onto.
(i.e. I don't expect the setrans file to define a translation for each 
and every bit combination. In fact, I though I could ignore the 
unspecified ones, and not provide access to them via the Nautilus GUI. 
They'd still be available for use, but they wouldn't be exposed via 
nautilus if they're not in the setrans file).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
