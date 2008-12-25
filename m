Message-ID: <a5e2b64d0812250536u67aa89e8p3686225db08e6d06@mail.gmail.com>
Date: Thu, 25 Dec 2008 22:36:34 +0900
From: Tim <timasyk@gmail.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: Alternative location of policy files
Cc: "Paul Howarth" <paul@city-fan.org>,
        "SELinux mailing list" <SELinux@tycho.nsa.gov>
In-Reply-To: <49534D18.2030808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <a5e2b64d0812232358u19f442dfwd27da7f0978a508c@mail.gmail.com>
	 <4951FA70.6000100@city-fan.org> <495204F4.4070301@gmail.com>
	 <49534D18.2030808@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2008/12/25 Justin P. Mattock <justinmattock@gmail.com>:
> Justin P. Mattock wrote:
>>
>> Paul Howarth wrote:
>>>
>>> Tim wrote:
>>>>
>>>> Hello all,
>>>>
>>>> I was wondering, how can I change default location of SELinux policy
>>>> from /etc/selinux/_policyname_ to some other path?
>>>> What source codes should be modified for that?
>>>>
>>>> The reason to do that are:
>>>> - I want to work with loadable policy modules --> that requires
>>>> /etc/selinux/_policyname_ directory to be writable.
>>>> - limitation of my filesystem having /etc directory (it is read-only
>>>> filesystem)
>>>> - unfortunately, I can not mount /etc into some other writable
>>>> filesystem
>>>
>>> Perhaps you could mount /etc/selinux/_policyname_ rather than /etc from a
>>> writeable filesystem?
>>>
>>> Paul.
>>> cy
>>> --
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>> with
>>> the words "unsubscribe selinux" without quotes as the message.
>>>
>> This is confusing to me:
>> it sounds like there not trying to mount
>> SELinux, but have the policy load
>> in a different location other than
>> /etc/selinux/*
>>
>> regards;
>>
>> Justin P. Mattock
>>
>>
> On second thought  from what  it  sounds,
> to have SELinux be read in another location,
> you would have to locate in
> libselinux the location from where the library is
> told to read the the policy, and simple just change the location,
> but then you might have to change the kernel, all the libraries,
> all apps, etc.. that read /etc/selinux/*
> maybe a simple change of /etc/selinux/config
> seems simpler. rather than going through
> lines of code.
> Anyways,
> "Merry christmas"
>
>
> regards;
>
> Justin P. Mattock

You are right. I would like kernel to read policy just from different location.

So options are as folowing:
1. Change libselinux sources and sources of all related apps + kernel.
2. Try to change /etc/selinux/config.

Regarding second one - manuals on SELinux say that /etc/selinux/config
contains name of policy to be loaded. And that name _policyname_ is a
name of directory in /etc/selinux/_policyname_ having subdirectory
policy with actual policy file.

So, it seems only option #1 is the one to use.

Does kernel use libselinux to read policy or it reads it directly from
filesystem?
Any other pitfalls?

Tim

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
