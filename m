Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBD4ODMA021611
	for <selinux@tycho.nsa.gov>; Mon, 12 Dec 2005 23:24:13 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBD4FoN7025148
	for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2005 04:15:51 GMT
Message-ID: <439E4AF6.40403@redhat.com>
Date: Mon, 12 Dec 2005 23:15:50 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Robert L Cochran <cochranb@speakeasy.net>
CC: Joe Orton <jorton@redhat.com>, Mark J Cox <mjc@redhat.com>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   SE Linux <selinux@tycho.nsa.gov>, Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: Adding two new booleans to httpd to tighten it's security.
References: <4399EFE6.5040206@redhat.com> <20051212110247.GA25100@redhat.com> <439E23F3.7090709@speakeasy.net>
In-Reply-To: <439E23F3.7090709@speakeasy.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Robert L Cochran wrote:
> Joe Orton wrote:
>
>> On Fri, Dec 09, 2005 at 03:58:14PM -0500, Daniel J Walsh wrote:
>>  
>>
>>> Currently policy allows httpd to connect to relay ports and to 
>>> mysql/postgres ports.
>>>
>>> Adding these booleans
>>>   * httpd_can_network_relay
>>>   * httpd_can_network_connect_db
>>>
>>> And turning this feature off by default.  This is going into 
>>> tonights reference policy and into FC4 test release.
>>>   
>>
>> Do you mean FC4 or FC5?  This should not go in an FC4 update 
>> off-by-default since it will break working setups.  Make it 
>> on-by-default if you want to ship this to FC4 users and 
>> off-by-default with a big release note for FC5.
>>
>> What's the difference between httpd_can_network_relay and 
>> httpd_can_network_connect?
>>
>> Do we still have the problem that httpd cannot reap idle children 
>> properly when the latter is set?  That really really does need to 
>> work by default.
>>
>> joe
>>
>> -- 
>> fedora-selinux-list mailing list
>> fedora-selinux-list@redhat.com
>> https://www.redhat.com/mailman/listinfo/fedora-selinux-list
>>
>>
>>  
>>
> I'd like to completely agree with Joe. I'm beginning to have quite a 
> lot invested in httpd, PHP and related database code and I don't want 
> SELinux breaking what is there without a lot of warning. For new 
> installs of FC4, I've been forced to turn off SELinux support for 
> these applications. They simply don't work otherwise.
>
> Bob Cochran
> Greenbelt. Maryland, USA
>
>
Have your reported your problems here or in bugzilla?

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
