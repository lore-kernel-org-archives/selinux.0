Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kATCEAbS012056
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 07:14:10 -0500
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kATCDSwt015009
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 12:13:28 GMT
Received: by wr-out-0506.google.com with SMTP id 57so588538wri
        for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 04:14:31 -0800 (PST)
Message-ID: <456D799E.40105@kaigai.gr.jp>
Date: Wed, 29 Nov 2006 21:14:22 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Yuichi Nakamura <ynakam@gwu.edu>, selinux@tycho.nsa.gov
Subject: Re: First argument of matchpathcon_filespec_add
References: <ddeda73453a4.456d4b0b@gwu.edu> <200611291923.30237.russell@coker.com.au>
In-Reply-To: <200611291923.30237.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Wednesday 29 November 2006 10:55, Yuichi Nakamura <ynakam@gwu.edu> wrote:
>> When we do not want to build busybox with -D_FILE_OFFSET_BIT=64,
>> we have to rebuild libselinux.
>>
>> I think it is a problem.
>>
>> Does anyone have good idea ?
> 
> What harm does it do to build busybox with 64bit file offsets?  For system 
> recovery I think that 64bit offsets are desirable.
> 
> For embedded systems I guess you could have both the same whichever option you 
> choose.

I think this topic should not be about the configuration of busybox,
be about the consistency of the libselinux interfaces.

Because the length of ino_t which is the first argument of the funciton
depends on the definition of _FILE_OFFSET_BIT, we have a possibility to
have different views on the interface of libselinux.
It is not limited in busybox cases.

Is it appropriate way that the consistency of libselinux's interface
depends on whether the application defines _FILE_OFFSET_BIT, or not?

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
