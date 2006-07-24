Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6OEFtIH030055
	for <selinux@tycho.nsa.gov>; Mon, 24 Jul 2006 10:15:55 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k6OEFrM8005416
	for <selinux@tycho.nsa.gov>; Mon, 24 Jul 2006 14:15:54 GMT
In-Reply-To: <1153748747.1641.18.camel@moss-terrapins.epoch.ncsc.mil>
References: <44BFECE8.80501@us.ibm.com> <1153748747.1641.18.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A5B53838-B8A8-47B0-9E4A-72A794702EBD@nall.com>
Cc: Michael C Thompson <thompsmc@us.ibm.com>, selinux@tycho.nsa.gov
From: Joe Nall <joe@nall.com>
Subject: Re: Existence of "helper" functions (specifcally MLS)
Date: Mon, 24 Jul 2006 09:15:33 -0500
To: David Quigley <dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jul 24, 2006, at 8:45 AM, David Quigley wrote:

> On Thu, 2006-07-20 at 15:51 -0500, Michael C Thompson wrote:
>> Hey all,
>>
>> I haven't looked extensively, but I was wondering if there exist any
>> funcitons (probably in libselinux?) which would do comparisons on MLS
>> labels and would return back whether or not one dominates another,  
>> or if
>> the categories are equal (or a subset), etc.
>>
>> Thanks much,
>> Mike
>>
>
> Hello,
> 	Sorry for the late reply but I was at OLS all of last week. I  
> currently
> have this implemented but it is not upstreamed yet. It required  
> changes
> in both libselinux and in the kernel. I can generate a set of patches
> for you if you need it before I can get it upstream however they are
> currently against 2.6.18-rc1.

Why does this require kernel changes? I would expect this to be a  
function comparing the levels and category bitmaps.

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
