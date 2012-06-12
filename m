Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5CKeVFS013600
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2012 16:40:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 12 Jun 2012 16:40:29 -0400
From: David Quigley <selinux@davequigley.com>
To: casinee app <appcasinee@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: "operation not support" when execute #restorecon -R /
In-Reply-To: <CAO-AVB4D4=LLMqaifLqOE8v6APndkMkkHwspx4+kazcs3Fo=ow@mail.gmail.com>
References: <CAO-AVB7hN1sODoEyE3pXv0mz0SN1KagdNFcHrb1Tt24DC+_dDA@mail.gmail.com>
 <ff7c28e8f022fc5bd217bb5ed7321fa6@countercultured.net>
 <CAO-AVB4D4=LLMqaifLqOE8v6APndkMkkHwspx4+kazcs3Fo=ow@mail.gmail.com>
Message-ID: <c2d372aa61ec3547cbe08b3fa3f61fc0@countercultured.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/05/2012 21:34, casinee app wrote:
> the NFS. I had applied a patch to the kernel to support the xattr of
> NFS filesystem.
>
> 2012/6/5 David Quigley <selinux@davequigley.com>
>
>> On 06/05/2012 02:51, casinee app wrote:
>>
>>> Hi,
>>> when i execute #restorecon -R / , all the output is "... operation
>>> not support".  I had check the source code, and in
>>> linux/security/selinux/hooks.c :
>>>
>>>          ...
>>>  sbsec = inode->i_sb->s_security;
>>>  if (!(sbsec->flags & SE_SBLABELSUPP))
>>>  {
>>>  return -EOPNOTSUPP;
>>>  }
>>>         ...
>>> it returned. The  SE_SBLABELSUPP defined as 0x40, i want to know 
>>> how
>>> can i do to make the filesystem to support the SecurityContext of
>>> selinux. 
>>> Thanks.
>>
>> Which filesystem is this?
>>
>> Dave

Where did you get this patch? Is it supposed to be generic xattr 
support in NFS? if so what version?

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
