Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79KDNXZ005512
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 16:13:23 -0400
Received: from smtp107.sbc.mail.re2.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l79KDNMH008647
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 20:13:23 GMT
In-Reply-To: <46BB6F5F.3010202@trustedcs.com>
References: <46BB6F5F.3010202@trustedcs.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0686AF70-E657-439B-9E65-CC49ABC2E226@nall.com>
Cc: James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul.moore@hp.com>, SE Linux <selinux@tycho.nsa.gov>,
        kaigai@ak.jp.nec.com, Eric Paris <eparis@parisplace.org>
From: Joe Nall <joe@nall.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 15:12:56 -0500
To: Darrel Goeddel <DGoeddel@TrustedCS.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Aug 9, 2007, at 2:47 PM, Darrel Goeddel wrote:
>> getpeercon() returned 'user_u:object_r:user_t:C O N F I D E N T I  
>> A L'
>>
>> for a connection from 10.211.55.8.
>>
>> This is a big improvement in linux labeled networking functionality.
>
> As described in an earlier email, from my not-yet-full grasp on the  
> patch,
> this is a vulnerability waiting to happen in the event of using  
> netlabel
> fallback contexts alongside labeled ipsec.

Which would be a configuration error. There are lots of dangerous but  
useful tools (rm, dd). I have ipsec and netlabel configured. I'll try  
crossing the streams and see if we get total protonic reversal.

>  That is not an improvement.

We will have to disagree. It is a big improvement in functionality.  
It may not be the final approach, but it is the only one I can  
evaluate today.

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
