Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5G5IkY2006223
	for <selinux@tycho.nsa.gov>; Tue, 16 Jun 2009 01:18:46 -0400
Received: from tyo202.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5G5IWkO022405
	for <selinux@tycho.nsa.gov>; Tue, 16 Jun 2009 05:18:33 GMT
Message-ID: <4A372B2F.9000804@ak.jp.nec.com>
Date: Tue, 16 Jun 2009 14:18:39 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Jason Johnson <jason.johnson.081@gmail.com>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Possible bug with fd class?
References: <aa22f0200906152148g77b0c37fo56c78fc5bb7dfa71@mail.gmail.com>
In-Reply-To: <aa22f0200906152148g77b0c37fo56c78fc5bb7dfa71@mail.gmail.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jason Johnson wrote:
> Hello all,
> 
> I am using SELinux on the latest debian.  It has a few access
> violations here and there, but the one that concerns me most is:
> 
> kernel: [1298522.518701] type=1400 audit(1245126419.780:229): avc:
> denied  { use } for  pid=29944 comm="syslog-ng" path="/dev/null"
> dev=tmpfs ino=634 scontext=system_u:system_r:syslogd_t:s0
> tcontext=system_u:system_r:logrotate_t:s0-s0:c0.c1023 tclass=fd
> 
> 
> /dev/null is:
> 
> # semanage fcontext -l|grep null_device_t
> /dev/null                                          character device
> system_u:object_r:null_device_t:s0
> /dev/full                                          character device
> system_u:object_r:null_device_t:s0
> 
> 
> I don't see a way with semanage to set anything about class "fd" and
> sesearch didn't seem to turn anything up.  How could /dev/null fd be
> in context logrotate_t?

The "fd" class represents a file descriptor object, not any filesystem
objects. For example, if you open the /tmp/aaa, this file belongs to
"file" class, but the file descriptor of the file belongs to "fd" class.

It seems to me the policy does not allow:

  logrotate_use_fds(syslogd_t)

> I could just add an allow for this on a local module, but my concern
> is: can a user program just set arbitrary fd's to it's own target
> context as well?

The fd class inherits the security context of the process which opened
itself.

> I appreciate any insight you all can give.
> 
> Sincerely,
> Jason
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
