Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBD4MmMA021579
	for <selinux@tycho.nsa.gov>; Mon, 12 Dec 2005 23:22:48 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBD4EQN7025077
	for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2005 04:14:26 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id jBD4EQmo027170
	for <selinux@tycho.nsa.gov>; Mon, 12 Dec 2005 23:14:26 -0500
Message-ID: <439E4AAB.2080406@redhat.com>
Date: Mon, 12 Dec 2005 23:14:35 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
   Mark J Cox <mjc@redhat.com>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: Adding two new booleans to httpd to tighten it's security.
References: <4399EFE6.5040206@redhat.com> <20051212110247.GA25100@redhat.com>
In-Reply-To: <20051212110247.GA25100@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Orton wrote:
> On Fri, Dec 09, 2005 at 03:58:14PM -0500, Daniel J Walsh wrote:
>   
>> Currently policy allows httpd to connect to relay ports and to 
>> mysql/postgres ports.
>>
>> Adding these booleans
>>    * httpd_can_network_relay
>>    * httpd_can_network_connect_db
>>
>> And turning this feature off by default.  This is going into tonights 
>> reference policy and into FC4 test release.
>>     
>
> Do you mean FC4 or FC5?  This should not go in an FC4 update 
> off-by-default since it will break working setups.  Make it 
> on-by-default if you want to ship this to FC4 users and off-by-default 
> with a big release note for FC5.
>   
Ok plan is to add this to FC4 With relay and database network connect 
turned on by default.
> What's the difference between httpd_can_network_relay and 
> httpd_can_network_connect?
>   
They are just more specific.  They allow specific connections to relay 
ports (http, ftp, gopher etc) and database ports (mysql and postgres).
> Do we still have the problem that httpd cannot reap idle children 
> properly when the latter is set?  That really really does need to work 
> by default.
>
>   
Do you have a bugzilla for this?
> joe
>   


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
