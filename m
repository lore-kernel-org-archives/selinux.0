Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4BK2wdY019917
	for <selinux@tycho.nsa.gov>; Thu, 11 May 2006 16:02:59 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4BK2wk1022739
	for <selinux@tycho.nsa.gov>; Thu, 11 May 2006 20:02:58 GMT
Message-ID: <446398BE.90501@redhat.com>
Date: Thu, 11 May 2006 16:04:14 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: selinux@tycho.nsa.gov
Subject: Re: textrel_shlib_t
References: <200605111730.k4BHUc13006509@turing-police.cc.vt.edu>            <44638B97.8080009@redhat.com> <200605111948.k4BJmACc019175@turing-police.cc.vt.edu>
In-Reply-To: <200605111948.k4BJmACc019175@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Valdis.Kletnieks@vt.edu wrote:
> On Thu, 11 May 2006 15:08:07 EDT, Daniel J Walsh said:
>
>   
>> http://people.redhat.com/~drepper/selinux-mem.html
>>     
>
> I had that one already, it mostly discusses using chcon as a workaround..
>
>   
>> http://people.redhat.com/~drepper/dsohowto.pdf
>>     
>
> Aha! Some digging through this one, and we find:
>
> The library in question wasn't compiled with -fpic or similar.
>
> This looks easy enough to fix. :)
>   
BTW Read my blog today, as I talk about a lot of this stuff...  How timely.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
