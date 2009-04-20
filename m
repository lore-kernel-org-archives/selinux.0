Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3K77ZF0004556
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 03:07:36 -0400
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3K77XnK018001
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 07:07:34 GMT
Message-ID: <49EC1F11.6040003@ak.jp.nec.com>
Date: Mon, 20 Apr 2009 16:06:57 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>,
        Shintaro Fujiwara <shin216@xf7.so-net.ne.jp>
Subject: Re: daemons and MCS categories
References: <200605220930.05483.russell@coker.com.au> <1148910738.14262.67.camel@sgc.columbia.tresys.com>
In-Reply-To: <1148910738.14262.67.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry for opening the old discussion again.

If you don't ML logs in local, please see the archives:
  http://marc.info/?t=114825463100001&r=1&w=2

Christopher J. PeBenito wrote:
> I agree with James on this, I don't think we want to impose semantics in
> the MCS categories, and that this
> 
>> Another possibility is to have the ability to configure which categories are 
>> assigned to a daemon via run_init or some similar program.  It would not be 
>> difficult to read a config file that maps the domain of a daemon to the range 
>> that should be granted to it.
> 
> is useful so that if users do want to run a daemon with categories, they
> can.

Is it still unavailable on the current SELinux userspace utilities, isn't it?

If we could start the init-scripts via runcon by hand, it seems to me the
daemon processes performs with multi categories.

 | [root@saba ~]# runcon -l s0-s0:c0.c255 /etc/init.d/httpd restart
 | Stopping httpd:                                            [  OK  ]
 | Starting httpd:                                            [  OK  ]
 | [root@saba ~]# ps -AZ | grep httpd
 | unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c255 6458 ? 00:00:00 httpd
 | unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c255 6460 ? 00:00:00 httpd
 | unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c255 6461 ? 00:00:00 httpd
 | unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c255 6462 ? 00:00:00 httpd
 |      :

But it is unavailable when the system kicks init-script on startup time.
Is there any good idea?

In the recent days, I'm working for an apache module (mod_selinux.so) which
launches web application handler under an individual security context based
on http-authentication.
I'm looking for the way to assign a few dozens of categories on httpd server
processes which are launched at system startup time.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
