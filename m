Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4OJpxNK025322
	for <selinux@tycho.nsa.gov>; Sun, 24 May 2009 15:51:59 -0400
Received: from yx-out-1718.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4OJpsrF006853
	for <selinux@tycho.nsa.gov>; Sun, 24 May 2009 19:51:54 GMT
Received: by yx-out-1718.google.com with SMTP id 34so1710603yxf.84
        for <selinux@tycho.nsa.gov>; Sun, 24 May 2009 12:51:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1243189652.3697.12.camel@notebook2.grift.internal>
References: <dd18b0c30905240931u49912081o88fc47ec1599187a@mail.gmail.com>
	 <1243189652.3697.12.camel@notebook2.grift.internal>
Date: Sun, 24 May 2009 12:51:57 -0700
Message-ID: <dd18b0c30905241251i6fea534cn7af38796b086892e@mail.gmail.com>
Subject: Re: SELinux acl's options
From: Justin Mattock <justinmattock@gmail.com>
To: Dominick Grift <domg472@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, May 24, 2009 at 11:27 AM, Dominick Grift <domg472@gmail.com> wrote:
> On Sun, 2009-05-24 at 09:31 -0700, Justin Mattock wrote:
>> I've been freaking out for a few weeks at looking
>> at ls -Z and seeing a dot at the end of the permissions.
>> (then after gogling I found)
>> http://www.linux-archive.org/fedora-development/285498-dot-end-permissions-something-new.html
>>
>> relieving me of thinking I have a hole in the ACL's.
>>
>> Anyways how would one go about changing
>> the "." to a "+" at the end of the permission?
>>
>
> The dot in the end means there is also a SELinux context.
> The plus in the end means there is also a ACL defined.
>
> No dot and plus means only basic DAC permissions are defined.
>
> I hope this clears things up for you:
>
> [root@notebook2 /]# mkdir test
> [root@notebook2 /]# ls -alZ / | grep test
> drwxr-xr-x. root root dgrift:object_r:default_t:SystemLow test
> [root@notebook2 /]# setfacl -m u:dgrift:r test
> [root@notebook2 /]# ls -alZ / | grep test
> drwxr-xr-x+ root root dgrift:object_r:default_t:SystemLow test
> [root@notebook2 /]#
>
>

Thanks for the info.
So I take it somewhere
on  my system there an init script that's
setting the "."(dot)

What would be the preferred way to have this set?
(safest and/or securest)

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
