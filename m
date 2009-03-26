Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2QNShiM027445
	for <selinux@tycho.nsa.gov>; Thu, 26 Mar 2009 19:28:43 -0400
Message-ID: <49CC0FAA.9020401@tycho.nsa.gov>
Date: Thu, 26 Mar 2009 19:28:42 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: method@manicmethod.com, selinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Expose avc_netlink_loop() for applications (Re: Some
 ideas in SE-PostgreSQL enhancement)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49CB1796.2010507@ak.jp.nec.com>
In-Reply-To: <49CB1796.2010507@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
>> 3. Simplifies netlink loops
>>
>> SE-PostgreSQL needs to implement its own userspace AVC due to
>> some reasons. When the backend started up, it creates a worker
>> process to receive messages from in-kernel SELinux via netlink
>> socket. The worker process invalidates the userspace AVC of
>> all the instance of PostgreSQL backend process when the state
>> of SELinux is changed.
>>
>> However, I think the following loop to receive messages from
>> netlink socket should be provided via libselinux.
>>
>>   http://code.google.com/p/sepgsql/source/browse/trunk/core/src/backend/security/sepgsql/avc.c#647
>>
>> If avc_netlink_loop() provided a callback function, I could push
>> the code into the libselinux.
>>
>> TODO:
>> - a set of new interface on libselinux:
>> I would like to add a few new interfaces to handle netlink socket
>> in libselinux, and expose them to application. I guess we can
>> write the existing standard avc with the interfaces.
>>     
>
> The attached patch expose the following libselinux interfaces:
>  - avc_netlink_open()
>  - avc_netlink_close()
>  - avc_netlink_loop()
> and adds a new callback function on receiving a netlink message.
>
> It enables to simplifies the implementation of userspace object
> managers which need to have its own avc and state monitoring process.
>
> The existing standard avc becomes to use the new callbacks,
> so here is a limitation we cannot use them concurrently,
> but it is not a realistic situation.
>
> Thanks,
>   



The userspace AVC already has support for a callback function whenever
the cache is reset: AVC_CALLBACK_RESET.

Why don't you simply run the normal userspace AVC in the
sepgsqlStateMonitorMain() process, and register a callback function for
reset. Then all the netlink stuff is hidden from you.

The only thing necessary is then to add an additional callback function
AVC_CALLBACK_SETENFORCE to handle the other case.



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
