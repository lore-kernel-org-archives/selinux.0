Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBO8ArJR004743
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 03:10:53 -0500
Received: from yw-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBO8ArhU013243
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 08:10:53 GMT
Received: by yw-out-1718.google.com with SMTP id 6so1005113ywa.84
        for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 00:10:53 -0800 (PST)
Message-ID: <4951EE89.2080007@gmail.com>
Date: Wed, 24 Dec 2008 00:10:49 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Atsushi SAKAI <sakaia@jp.fujitsu.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Question about SELinux userspace library and scripts?
References: <4951E501.30803@gmail.com> <20081224075329.3A0E31807B@m024.s.css.fujitsu.com>
In-Reply-To: <20081224075329.3A0E31807B@m024.s.css.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Atsushi SAKAI wrote:
> Hi,
>
> Thank you for your comments.
>
> I just want to know that
> where is the ALL userland source code?
>
> For example, I thought user-land code is only in userspace library.
> But further investigatin found the code also in refpolicy/support.
>
> I am worrying about other unread code or script exists. 
>
> Thanks
> Atsushi SAKAI
>
>
> "Justin P. Mattock" <justinmattock@gmail.com> wrote:
>
>   
>> Atsushi SAKAI wrote:
>>     
>>> Hi,
>>>
>>> I have a question about user-space library and script.
>>> As far as I know, following 6-library and 1-script are exists.
>>>
>>> Userspace library(6-libs(utils included))
>>>   http://userspace.selinuxproject.org/trac/wiki/Userland
>>>
>>> macro for reference policy(scripts in following dir)
>>>   serefpolicy-3.5.13/support
>>>
>>> Any other library and script exists ?
>>> and 
>>> some explanation about serefpolicy macros?
>>>
>>>
>>> Thanks
>>> Atsushi SAKAI
>>>
>>>
>>>
>>>
>>> --
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>> the words "unsubscribe selinux" without quotes as the message.
>>>
>>>   
>>>       
>>  From experience with userland
>> just do a git-pull..
>> should give the the proper files
>> except for python-selinux to build a custom policy
>> (as for macros not too sure);
>>
>> regards;
>>
>> Justin P. Mattock
>>
>>
>>
>>
>>
>>
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>>     
>
>
>
>   
Using the userland sourcecode is nice
everything is needed to build a policy i.g.
git clone http://oss.tresys.com/git/selinux.git
then after downloading the source, compile
(you will need certain packages; libpam-dev
flex, gawk, libustr-dev, gettext, sysvinit etc..)
then after compiling and installing,
you only need the python-selinux package.
(for the userland libraries and tools to work, and a policy);
then go grab you're policy
then after compiling the policy;
and making /selinux in you're tree,
you should just reboot and the policy should load
{boot params audit=1 selinux=1 enforcing=0/1};
(after loading the policy you should make relabel,
just to be safe); Userland provides all of the essentials
to build a policy.

Then once the policy is running you need to add you're
entry's in /etc/pam.d/* for newrole to work.

If you need help there's plenty of people to help you.
just don't be afraid to ask.

regards;

Justin P. mattock






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
