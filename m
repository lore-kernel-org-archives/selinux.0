Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5D2Th4m027725
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2012 22:29:43 -0400
Received: by lagu2 with SMTP id u2so67245lag.12
        for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2012 19:29:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c2d372aa61ec3547cbe08b3fa3f61fc0@countercultured.net>
References: <CAO-AVB7hN1sODoEyE3pXv0mz0SN1KagdNFcHrb1Tt24DC+_dDA@mail.gmail.com>
	<ff7c28e8f022fc5bd217bb5ed7321fa6@countercultured.net>
	<CAO-AVB4D4=LLMqaifLqOE8v6APndkMkkHwspx4+kazcs3Fo=ow@mail.gmail.com>
	<c2d372aa61ec3547cbe08b3fa3f61fc0@countercultured.net>
Date: Wed, 13 Jun 2012 10:29:36 +0800
Message-ID: <CAO-AVB7QdNtzoZWKQ0R0mBOrzEFy5e1kovZs5CVW-795K6WpkQ@mail.gmail.com>
Subject: Re: "operation not support" when execute #restorecon -R /
From: casinee app <appcasinee@gmail.com>
To: David Quigley <selinux@davequigley.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2012/6/13 David Quigley <selinux@davequigley.com>:
> On 06/05/2012 21:34, casinee app wrote:
>>
>> the NFS. I had applied a patch to the kernel to support the xattr of
>> NFS filesystem.
>>
>> 2012/6/5 David Quigley <selinux@davequigley.com>
>>
>>> On 06/05/2012 02:51, casinee app wrote:
>>>
>>>> Hi,
>>>> when i execute #restorecon -R / , all the output is "... operation
>>>> not support".  I had check the source code, and in
>>>> linux/security/selinux/hooks.c :
>>>>
>>>>          ...
>>>>  sbsec = inode->i_sb->s_security;
>>>>  if (!(sbsec->flags & SE_SBLABELSUPP))
>>>>  {
>>>>  return -EOPNOTSUPP;
>>>>  }
>>>>         ...
>>>> it returned. The  SE_SBLABELSUPP defined as 0x40, i want to know how
>>>> can i do to make the filesystem to support the SecurityContext of
>>>> selinux.
>>>> Thanks.
>>>
>>>
>>> Which filesystem is this?
>>>
>>> Dave
>
>
> Where did you get this patch? Is it supposed to be generic xattr support in
> NFS? if so what version?
>

I got the patch from the website  http://namei.org/nfsxattr/ .  After
i applied the patch,
when i config the kernel, i can see the options like this:
...
<*>   NFS client support
  [*]     NFS client support for NFS version 3
  [*]   NFS client support for the NFSv3 ACL protocol extension
  [*]   NFS client support for the NFSv3 XATTR protocol extension (EXPERIMENTAL)
  [*]     Extended attributes in the user namespace (EXPERIMENTAL)
  [*]   NFS client support for NFS version 4 (EXPERIMENTAL)
  [*]   Root file system on NFS
 <M>   NFS server support
    -*-     NFS server support for NFS version 3
   [*]       NFS server support for the NFSv3 ACL protocol extension
   [*]       NFS server support for the NFSv3 XATTR protocol extension
(EXPERIMENTAL)
   [*]     NFS server support for NFS version 4 (EXPERIMENTAL)


> Dave
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
