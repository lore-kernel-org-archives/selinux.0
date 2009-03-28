Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2S0s7dh022466
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 20:54:07 -0400
Message-ID: <49CD752D.1070104@tycho.nsa.gov>
Date: Fri, 27 Mar 2009 20:54:05 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: method@manicmethod.com, selinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Expose avc_netlink_loop() for applications (Re: Some
 ideas in SE-PostgreSQL enhancement)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49CB1796.2010507@ak.jp.nec.com> <49CC12C2.4050302@tycho.nsa.gov> <49CC1F3B.1040906@ak.jp.nec.com>
In-Reply-To: <49CC1F3B.1040906@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:

[snip]

> I have two minor and major concern with this approach.
>
> The minor one is it consumes unnecessary memory due to avc_init().
> Because of some reasons, SE-PostgreSQL implements its own userspace
> AVC, so this region is purely waste of space.
>   

avc_init() does set up the cache but it remains empty since it is not
used by the worker process for any lookups. I don't think the memory
overhead of an empty cache should be that large. But see below.


> The major one is we cannot handle them in a sindle lock section.
> When the application is callbacked via AVC_CALLBACK_SETENFORCE,
> it will change the state of enforcing/permissive, and it resets
> its own avc on AVC_CALLBACK_RESET. But I would like to handle
> these operations in a single lock section.
>
> If we reset the avc on AVC_CALLBACK_SETENFORCE, it finally
> resets the avc twice on a single message. It is also unconfortable.
>
> The design of callbacks (via selinux_set_callback()) can be
> considerable, but I don't think it is a good idea to hide
> the netlink stuff here.
>
> In my patch, it adds SELINUX_CB_NETLINK for any messages.
> But, if it would be SELINUX_CB_SETENFORCE and SELINUX_CB_POLICYLOAD,
> we don't need to refer any netlink related stuffs from applications.
>
> What is your opinion?
>   


Considering your point, I'd rather create SETENFORCE and POLICYLOAD
callbacks for selinux_set_callback(). However, they should be called in
addition to the normal processing in avc_netlink_process(), not
replacing the code flow. The savings from not updating a few globals and
calling avc_ss_reset (which returns immediately if the userspace AVC is
not running) are not that big.

You could optionally make avc_netlink_open() and avc_netlink_close()
public functions, which would allow to avoid calling avc_init().



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
