Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l26GDpC1004539
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 11:13:51 -0500
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l26GFGxq013044
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 16:15:17 GMT
Received: by wr-out-0506.google.com with SMTP id 37so1982683wra
        for <selinux@tycho.nsa.gov>; Tue, 06 Mar 2007 08:15:13 -0800 (PST)
Message-ID: <e739902b0703060815m5bbe83bdsed886eafe6dac00d@mail.gmail.com>
Date: Tue, 6 Mar 2007 08:15:12 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Question about the process : share permission.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello all,

I am trying to understand what the process : share permission does.
In the SELinux by example book, it says the process : share permission
allows state sharing with cloned or forked processes.

I looked looked through the refpolicy tree and only found one instance
of the process : share permission, it is in the kernel_share_state
interface.   This interface is only called by the system/init module.

At first I thought this permission had to do with shared libraries
and/or forking processes, but I see there is also a process : fork
permission and there is a libs_use_shared_libs interface function to
allow the loading and execution of shared libraries.

I am just curious to understand what the process : share permission
allows/prevents.

Thanks!

- Ryan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
