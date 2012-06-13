Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5DIHUR7002521
	for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2012 14:17:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 13 Jun 2012 14:17:26 -0400
From: David Quigley <selinux@davequigley.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: casinee app <appcasinee@gmail.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: "operation not support" when execute #restorecon -R /
In-Reply-To: <4FD8BCEB.30904@schaufler-ca.com>
References: <CAO-AVB7hN1sODoEyE3pXv0mz0SN1KagdNFcHrb1Tt24DC+_dDA@mail.gmail.com>
 <ff7c28e8f022fc5bd217bb5ed7321fa6@countercultured.net>
 <CAO-AVB4D4=LLMqaifLqOE8v6APndkMkkHwspx4+kazcs3Fo=ow@mail.gmail.com>
 <c2d372aa61ec3547cbe08b3fa3f61fc0@countercultured.net>
 <CAO-AVB7QdNtzoZWKQ0R0mBOrzEFy5e1kovZs5CVW-795K6WpkQ@mail.gmail.com>
 <4FD8BCEB.30904@schaufler-ca.com>
Message-ID: <f65dde7d2b1b153b983162861effab4a@countercultured.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/13/2012 12:16, Casey Schaufler wrote:
> On 6/12/2012 7:29 PM, casinee app wrote:
>> 2012/6/13 David Quigley <selinux@davequigley.com>:
>>> On 06/05/2012 21:34, casinee app wrote:
>>>> the NFS. I had applied a patch to the kernel to support the xattr 
>>>> of
>>>> NFS filesystem.
>>>>
>>>> 2012/6/5 David Quigley <selinux@davequigley.com>
>>>>
>>>>> On 06/05/2012 02:51, casinee app wrote:
>>>>>
>>>>>> Hi,
>>>>>> when i execute #restorecon -R / , all the output is "... 
>>>>>> operation
>>>>>> not support".  I had check the source code, and in
>>>>>> linux/security/selinux/hooks.c :
>>>>>>
>>>>>>          ...
>>>>>>  sbsec = inode->i_sb->s_security;
>>>>>>  if (!(sbsec->flags & SE_SBLABELSUPP))
>>>>>>  {
>>>>>>  return -EOPNOTSUPP;
>>>>>>  }
>>>>>>         ...
>>>>>> it returned. The  SE_SBLABELSUPP defined as 0x40, i want to know 
>>>>>> how
>>>>>> can i do to make the filesystem to support the SecurityContext 
>>>>>> of
>>>>>> selinux.
>>>>>> Thanks.
>>>>>
>>>>> Which filesystem is this?
>>>>>
>>>>> Dave
>>>
>>> Where did you get this patch? Is it supposed to be generic xattr 
>>> support in
>>> NFS? if so what version?
>>>
>> I got the patch from the website  http://namei.org/nfsxattr/ .  
>> After
>> i applied the patch,
>> when i config the kernel, i can see the options like this:
>> ...
>> <*>   NFS client support
>>   [*]     NFS client support for NFS version 3
>>   [*]   NFS client support for the NFSv3 ACL protocol extension
>>   [*]   NFS client support for the NFSv3 XATTR protocol extension 
>> (EXPERIMENTAL)
>>   [*]     Extended attributes in the user namespace (EXPERIMENTAL)
>>   [*]   NFS client support for NFS version 4 (EXPERIMENTAL)
>>   [*]   Root file system on NFS
>>  <M>   NFS server support
>>     -*-     NFS server support for NFS version 3
>>    [*]       NFS server support for the NFSv3 ACL protocol extension
>>    [*]       NFS server support for the NFSv3 XATTR protocol 
>> extension
>> (EXPERIMENTAL)
>>    [*]     NFS server support for NFS version 4 (EXPERIMENTAL)
>
> Ah, James' generic xattr patches. Very useful, fully functional, the
> right thing is every way and totally despised by the NFS and IETF 
> crowd.
> They're fine to use for experimental purposes, but it is hard to 
> imagine
> them ever getting upstream.
>
>
>>
>>
>>> Dave
>>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing 
>> list.
>> If you no longer wish to subscribe, send mail to 
>> majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>>


Proper XATTR support is not despised by the IETF. Trond at one point 
proposed to do XATTRS for NFSv4. However it is not the ideal solution 
for security attributes. The security attribute should be a first class 
citizen as it is in other UNIX like operating systems. Just because 
Linux has crammed it into an XATTR doesn't mean that NFSv4 or FreeBSD or 
Solaris or any number of other systems should be forced to do it as 
well.

The main reason these patches weren't taken is because everyone is 
strongly encouraging people to migrate away from NFSv3 and onto NFSv4. 
Having this kind of support in NFSv3 is a bad idea for two fold. One it 
will hinder migration to NFSv4 when it should happen and two it will 
never be part of the standard. This means this extension will be Linux 
only and not work with any of the other standards compliant hardware. 
This is the reason Labeled NFS is taking so long to get in the kernel. 
The Linux NFS maintainers don't want Linux specific extensions stuck in 
the kernel with no backing by storage vendors. Lets be honest here most 
if not all enterprises are using NetApp/EMC/Panases/Etc.... network 
storage appliances. They aren't sticking a Linux server with raid 
controllers in it on their network to keep track of their important 
data. So something that is a Linux specific extension does no one any 
good.

That being said the ideal person to contact to find out why it isn't 
working would be James Morris. If he wants to keep the patches up to 
date he is welcome to but this was a stop gap method until we got 
Labeled NFS in the kernel. It was determined that NFSv4 with Labeled NFS 
was the proper solution to the problem.

Dave

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
