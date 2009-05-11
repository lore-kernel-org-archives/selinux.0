Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4B5COwc021013
	for <selinux@tycho.nsa.gov>; Mon, 11 May 2009 01:12:25 -0400
Received: from tyo202.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4B5CP42006017
	for <selinux@tycho.nsa.gov>; Mon, 11 May 2009 05:12:26 GMT
Message-ID: <4A07B36C.1080305@ak.jp.nec.com>
Date: Mon, 11 May 2009 14:11:08 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: dwalsh@redhat.com, method@manicmethod.com
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>, russell@coker.com.au,
        SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: daemons and MCS categories
References: <200605220930.05483.russell@coker.com.au> <1148910738.14262.67.camel@sgc.columbia.tresys.com> <49EC1F11.6040003@ak.jp.nec.com> <49ED29CC.6080507@ak.jp.nec.com> <49EED77F.5060407@ak.jp.nec.com>
In-Reply-To: <49EED77F.5060407@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Are anyone interested in the daemon process with mcs categories?

My proposition tries to cover general daemon processes, but my
major concern is apache/httpd performing without any categories.
If we focus on the apache/httpd, we can add the following policy
within the mod_selinux.pp, and it enables to run httpd_t with
mcs categories.

  optional_policy(`
      init_ranged_daemon_domain(httpd_t,httpd_exec_t,s0 - mcs_systemhigh)
  ')

The mod_selinux.so is an apache/httpd module which enables to
change its own security context prior to launching contents
handler. We can set up the module to drop all the categories
for unauthorized http clients, and rest of requests to perform
with appropriate categories.

The above rule will be available only when mod_selinux is installed.
I don't think it gives any impact for existing stuffs.

Any comments?

KaiGai Kohei wrote:
> The attached patch is a proof-of-concept for the facility to launch
> daemon processes with a certaon mcs ranges.
> 
> The selinux-daemon-mcs-run_init.patch add run_init a new option which
> specifies the name of daemon.
> 
>   # run_init -n httpd /etc/init.d/httpd restart
> 
> When -n option is given, run_init lookups under the
> /etc/selinux/<policy type>/contexts/initrc/<daemon>, and replaces the
> range to be assigned on the init script.
> 
>   [root@saba run_init]# cat /etc/selinux/targeted/contexts/initrc/httpd
>   s0-s0:c0.c31
>   [root@saba run_init]# ./run_init -n httpd /etc/init.d/httpd restart
>   Authenticating kaigai.
>   Password:
>   Stopping httpd:                                            [  OK  ]
>   Starting httpd:                                            [  OK  ]
>   [root@saba run_init]# ps -AZ | grep httpd
>   system_u:system_r:httpd_t:s0-s0:c0.c31 11303 ? 00:00:00 httpd
>   system_u:system_r:httpd_t:s0-s0:c0.c31 11305 ? 00:00:00 httpd
>   system_u:system_r:httpd_t:s0-s0:c0.c31 11308 ? 00:00:00 httpd
>   system_u:system_r:httpd_t:s0-s0:c0.c31 11309 ? 00:00:00 httpd
>   system_u:system_r:httpd_t:s0-s0:c0.c31 11310 ? 00:00:00 httpd
>      :
> 
> The selinux-daemon-mcs-rc-script.patch is a short hack to the system
> init script. It launches the required script with "runcon -l", if
> per-daemon range is configured.
> 
> These reworks typicall enable web-application (launched by httpd) to
> perform in a certain restrictive category of MCS.
> Currently, mod_selinux's security policy module assigns "mcssetcats"
> on httpd_t, but it is fundamentally denger and nonsense. :(
> 
> So, I would like to see the daemon processes with appropriate categories.
> 
> Thanks,
> 
> KaiGai Kohei wrote:
>> KaiGai Kohei wrote:
>>> Sorry for opening the old discussion again.
>>>
>>> If you don't ML logs in local, please see the archives:
>>>   http://marc.info/?t=114825463100001&r=1&w=2
>>>
>>> Christopher J. PeBenito wrote:
>>>> I agree with James on this, I don't think we want to impose semantics in
>>>> the MCS categories, and that this
>>>>
>>>>> Another possibility is to have the ability to configure which categories are 
>>>>> assigned to a daemon via run_init or some similar program.  It would not be 
>>>>> difficult to read a config file that maps the domain of a daemon to the range 
>>>>> that should be granted to it.
>>>> is useful so that if users do want to run a daemon with categories, they
>>>> can.
>>> Is it still unavailable on the current SELinux userspace utilities, isn't it?
>> Shall we start to implement an extention of run_init and others based on
>> the above Russell's idea?
>>
>> Now, I have a plan to store configuration files at:
>>   /etc/selinux/${POLICY_TYPE}/contexts/initrc/${DAEMON}
>>    or
>>   /etc/selinux/${POLICY_TYPE}/contexts/initrc_contexts with format extensions
>>
>> and, add a new option to run_init as:
>>   run_init [-n <daemon>] <script> [<args> ...]
>>
>>   It intends to see the per-daemon default range, instead of the initrc_contexts.
>>
>> and, add a bit of hacks on the /etc/rc.d/rc script which launches daemon scripts
>> when run-level is changed. (Maybe, it is necessary to launch them via "runcon -l"
>> when the given daemon has its own range.)
>>
>> The last also need to have a discussion in the Fedora developer's list.
>> Dan, do you think it is a hopefull proposition?
>>
>> Thanks,
>>
>>> If we could start the init-scripts via runcon by hand, it seems to me the
>>> daemon processes performs with multi categories.
>>>
>>>  | [root@saba ~]# runcon -l s0-s0:c0.c255 /etc/init.d/httpd restart
>>>  | Stopping httpd:                                            [  OK  ]
>>>  | Starting httpd:                                            [  OK  ]
>>>  | [root@saba ~]# ps -AZ | grep httpd
>>>  | unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c255 6458 ? 00:00:00 httpd
>>>  | unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c255 6460 ? 00:00:00 httpd
>>>  | unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c255 6461 ? 00:00:00 httpd
>>>  | unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c255 6462 ? 00:00:00 httpd
>>>  |      :
>>>
>>> But it is unavailable when the system kicks init-script on startup time.
>>> Is there any good idea?
>>>
>>> In the recent days, I'm working for an apache module (mod_selinux.so) which
>>> launches web application handler under an individual security context based
>>> on http-authentication.
>>> I'm looking for the way to assign a few dozens of categories on httpd server
>>> processes which are launched at system startup time.
>>>
>>> Thanks,

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
