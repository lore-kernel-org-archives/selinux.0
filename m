Message-ID: <4D90B543.2030808@gmail.com>
Date: Mon, 28 Mar 2011 09:20:19 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
        qingtao.cao@windriver.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: Fix regression for Xorg
References: <4D878244.4060502@gmail.com> <4D8A36E9.3070601@gmail.com>	 <4D8AACD9.60505@gmail.com> <1300975137.8157.38.camel@moss-pluto>	 <4D8B70C8.3000800@gmail.com> <1300997637.8157.44.camel@moss-pluto>	 <4D8BA7F0.5090307@gmail.com> <1300998293.8157.48.camel@moss-pluto>	 <4D8BACFD.6090400@gmail.com>  <4D8C09A3.5090304@windriver.com>	 <1301055989.22099.4.camel@moss-pluto> <1301056481.22099.8.camel@moss-pluto>	 <1301062423.22099.19.camel@moss-pluto>  <4D8D5799.3030509@gmail.com>	 <1301316132.23818.7.camel@moss-pluto> <1301322279.23818.19.camel@moss-pluto>
In-Reply-To: <1301322279.23818.19.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/28/2011 07:24 AM, Stephen Smalley wrote:
> On Mon, 2011-03-28 at 08:42 -0400, Stephen Smalley wrote:
>> On Fri, 2011-03-25 at 20:03 -0700, Justin P. Mattock wrote:
>>> not sure whats going on now.. but loading up the latest on my iMac with
>>> the below patch makes no difference I still hit the bug macbook pro
>>> works fine(maybe something with the different video drivers or something)
>>>
>>> full dmesg of my iMac here:
>>> http://fpaste.org/SNFC/
>>
>> Hi Justin,
>>
>> I did before and after testing using the compute_create utility from
>> libselinux/utils, and it showed that the kernel returned the wrong
>> context prior to the patch and the right context afterward.  I'm
>> guessing you aren't booting the right kernel or didn't apply the patch
>> correctly.
>>
>> You can run:
>> compute_create `id -Z` `id -Z` x_drawable
>> and see whether the returned context has object_r or not.
>
> Also, I tested before and after the patch with Xorg, and confirmed that
> the compute_sid errors vanished when using a kernel with the patch
> applied.
>

I will retest that patch on that machine..(I was seeing crud with git)
other than that on the macbook patch works fine.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
