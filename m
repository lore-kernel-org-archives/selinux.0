Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0LBYTRb000677
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 06:34:29 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0LBXHxr013904
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 11:33:17 GMT
Received: from mxlx1.surveysavvy.com (mxlx1.surveysavvy.com [63.108.92.46])
	by jazzswing.ncsc.mil  with SMTP id i0LBXGYc013901
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 11:33:16 GMT
Message-ID: <3345.68.6.187.64.1074684548.squirrel@mxlx1.surveysavvy.com>
In-Reply-To: <200401212131.10696.russell@coker.com.au>
References: <1988.68.6.187.64.1074664098.squirrel@mxlx1.surveysavvy.com>
    <200401211935.42235.russell@coker.com.au>
    <3302.68.6.187.64.1074680162.squirrel@mxlx1.surveysavvy.com>
    <200401212131.10696.russell@coker.com.au>
Date: Wed, 21 Jan 2004 03:29:08 -0800 (PST)
Subject: Re: Debian and 2.6 selinux
From: "Chris Babcock" <cbabcock@luthresearch.com>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Wed, 21 Jan 2004 21:16, "Chris Babcock" <cbabcock@luthresearch.com>
> wrote:
>> > However I have not tried woody with a 2.6.x kernel.  I don't know why
>> you
>> > would want to run Debian/stable with a 2.6.x kernel though, as 2.6.x
>> > kernels are not stable in my experience!
>>
>> Is that 2.6 alone is too unstable for your taste, or 2.6 with SE enabled
>> is too unstable?
>
> 2.6 in any situation.
>
> I have found APM not to work correctly, some Ext3 file system issues, and
> some
> significant driver changes that take some time and effort to sort out
> (particularly for ISA drivers).

That is unfortunate.  It makes me wonder what hardware the kernel
developers use.  If the kernel made it passed the 2.5 stage it has to run
stable for somebody (Linus?).

>
>> So, I was thinking that perhaps running 2.6 w/SE on a known, stable
>> infrequently changing platform may be worth a try, since it would let me
>> compare Non-SE, 2.4-SE, and 2.6-SE on a common, easily reproducible base
>> platform.  It is probably a bad idea.  Most of the debian stable
>> packages
>> are downright stale.  Odds are something in the system will end up
>> causing
>> trouble with the 2.6 kernel.  Any thoughts on this?
>
> I suggest running 2.4 with the new SE Linux back-port on Stable then.
>
>> Also, what combination of base distro and SE do you prefer for
>> production
>> servers?
>
> The combination that's likely to work best in most ways at the moment is
> Fedora with Arjan's kernel and Dan's packages.
>
> For Debian use Stable with Brian's packages.
>

Thanks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
