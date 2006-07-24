Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6OFPP6i031686
	for <selinux@tycho.nsa.gov>; Mon, 24 Jul 2006 11:25:25 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k6OFPOM8016009
	for <selinux@tycho.nsa.gov>; Mon, 24 Jul 2006 15:25:24 GMT
In-Reply-To: <1153751437.6122.74.camel@moss-spartans.epoch.ncsc.mil>
References: <44BFECE8.80501@us.ibm.com> <1153748747.1641.18.camel@moss-terrapins.epoch.ncsc.mil> <A5B53838-B8A8-47B0-9E4A-72A794702EBD@nall.com> <1153751437.6122.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3CA9DB29-D76C-41BE-ABE7-2F710F6658D2@nall.com>
Cc: David Quigley <dpquigl@tycho.nsa.gov>,
        Michael C Thompson <thompsmc@us.ibm.com>, selinux@tycho.nsa.gov
From: Joe Nall <joe@nall.com>
Subject: Re: Existence of "helper" functions (specifcally MLS)
Date: Mon, 24 Jul 2006 10:25:18 -0500
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jul 24, 2006, at 9:30 AM, Stephen Smalley wrote:

> On Mon, 2006-07-24 at 09:15 -0500, Joe Nall wrote:
>> On Jul 24, 2006, at 8:45 AM, David Quigley wrote:
>>
>>> On Thu, 2006-07-20 at 15:51 -0500, Michael C Thompson wrote:
>>>> Hey all,
>>>>
>>>> I haven't looked extensively, but I was wondering if there exist  
>>>> any
>>>> funcitons (probably in libselinux?) which would do comparisons  
>>>> on MLS
>>>> labels and would return back whether or not one dominates another,
>>>> or if
>>>> the categories are equal (or a subset), etc.
>>>>
>>>> Thanks much,
>>>> Mike
>>>>
>>>
>>> Hello,
>>> 	Sorry for the late reply but I was at OLS all of last week. I
>>> currently
>>> have this implemented but it is not upstreamed yet. It required
>>> changes
>>> in both libselinux and in the kernel. I can generate a set of  
>>> patches
>>> for you if you need it before I can get it upstream however they are
>>> currently against 2.6.18-rc1.
>>
>> Why does this require kernel changes? I would expect this to be a
>> function comparing the levels and category bitmaps.
>
> Only the policy engine can interpret the security labels.  So you have
> two choices:  ask the kernel's policy engine via selinuxfs or use
> libsepol on the on-disk policy file.  Advantage of the former is  
> that a)
> the kernel has already parsed and loaded the policy into memory, so  
> you
> avoid that cost again, and b) you ensure that you are dealing with the
> same exact policy that the kernel is enforcing.

I understand this if you include non-MLS components, but how does the
interpretation of the MLS component of a context vary with policy on one
machine?

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
