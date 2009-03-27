Message-ID: <49CC1F3B.1040906@ak.jp.nec.com>
Date: Fri, 27 Mar 2009 09:35:07 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: method@manicmethod.com, selinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Expose avc_netlink_loop() for applications (Re: Some
 ideas in SE-PostgreSQL enhancement)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49CB1796.2010507@ak.jp.nec.com> <49CC12C2.4050302@tycho.nsa.gov>
In-Reply-To: <49CC12C2.4050302@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> KaiGai Kohei wrote:
>>> 3. Simplifies netlink loops
>>>
>>> SE-PostgreSQL needs to implement its own userspace AVC due to
>>> some reasons. When the backend started up, it creates a worker
>>> process to receive messages from in-kernel SELinux via netlink
>>> socket. The worker process invalidates the userspace AVC of
>>> all the instance of PostgreSQL backend process when the state
>>> of SELinux is changed.
>>>
>>> However, I think the following loop to receive messages from
>>> netlink socket should be provided via libselinux.
>>>
>>>   http://code.google.com/p/sepgsql/source/browse/trunk/core/src/backend/security/sepgsql/avc.c#647
>>>
>>> If avc_netlink_loop() provided a callback function, I could push
>>> the code into the libselinux.
>>>
>>> TODO:
>>> - a set of new interface on libselinux:
>>> I would like to add a few new interfaces to handle netlink socket
>>> in libselinux, and expose them to application. I guess we can
>>> write the existing standard avc with the interfaces.
>>>     
>> The attached patch expose the following libselinux interfaces:
>>  - avc_netlink_open()
>>  - avc_netlink_close()
>>  - avc_netlink_loop()
>> and adds a new callback function on receiving a netlink message.
>>
>> It enables to simplifies the implementation of userspace object
>> managers which need to have its own avc and state monitoring process.
>>
>> The existing standard avc becomes to use the new callbacks,
>> so here is a limitation we cannot use them concurrently,
>> but it is not a realistic situation.
>>
>> Thanks,
>>   
> 
> Also note the new functions avc_netlink_acquire_fd(),
> avc_netlink_release_fd(), and avc_netlink_check_nb() that you can use to
> obtain the netlink file descriptor out and use it in a loop with select(2).
> 
> This means you don't have to use the threading callbacks to launch a
> worker thread to listen on netlink.
> 
> All said, this would be pseudo-code for your worker process:

I have two minor and major concern with this approach.

The minor one is it consumes unnecessary memory due to avc_init().
Because of some reasons, SE-PostgreSQL implements its own userspace
AVC, so this region is purely waste of space.

The major one is we cannot handle them in a sindle lock section.
When the application is callbacked via AVC_CALLBACK_SETENFORCE,
it will change the state of enforcing/permissive, and it resets
its own avc on AVC_CALLBACK_RESET. But I would like to handle
these operations in a single lock section.

If we reset the avc on AVC_CALLBACK_SETENFORCE, it finally
resets the avc twice on a single message. It is also unconfortable.

The design of callbacks (via selinux_set_callback()) can be
considerable, but I don't think it is a good idea to hide
the netlink stuff here.

In my patch, it adds SELINUX_CB_NETLINK for any messages.
But, if it would be SELINUX_CB_SETENFORCE and SELINUX_CB_POLICYLOAD,
we don't need to refer any netlink related stuffs from applications.

What is your opinion?

Thanks,

> reset_callback() {
> do_reset_stuff;
> }
> 
> setenforce_callback() {
> do_setenforce_stuff;
> }
> 
> sepgsqlStateMonitorMain() {
> 
> avc_set_callback(AVC_CALLBACK_RESET, reset_callback);
> avc_set_callback(AVC_CALLBACK_SETENFORCE, setenforce_callback);
> avc_open();
> 
> fd = avc_netlink_acquire_fd();
> while (true) {
> select(fd);
> avc_netlink_check_nb();
> }
> }

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
