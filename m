Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA19022
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 16:08:32 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA01124
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 20:07:02 GMT
Received: from mail.hallcomp.com (hallcomp.com [208.140.194.52])
        by jazzband.ncsc.mil  with ESMTP id UAA01120 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 20:07:02 GMT
Subject: RE: sysadm_tty_device_t
From: Timothy Wood <timothy@hallcomp.com>
To: blacknet@simplyaquatics.com
Cc: "'Stephen Smalley'" <sds@tislabs.com>,
        "'SE Linux'" <selinux@tycho.nsa.gov>
In-Reply-To: <00dd01c22914$a9b23b30$0a01a8c0@ed>
References: <00dd01c22914$a9b23b30$0a01a8c0@ed>
Content-Type: text/plain; charset=koi8-r
Date: 11 Jul 2002 16:12:52 -0400
Message-Id: <1026418372.1663.39.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

В Чтв, 11.07.2002, в 15:53, Ed Street написал:
> Hello,
> 
> That's what it seems to be.  It does look like an accident waiting to
> happen as well.
> 
> Ed

I would not nessicarily call it an accident waiting to happen.  More
like something that needs configured if you want it.  You have to
remember that basic idea here is no access to something you don't need
(as far as processes are concerned).  Syslog really only needs access to
the log files it writes to, with the exception of severe kernel
messages.  The latter I suppose works (/dev/console not /dev/tty*) but I
have never noticed any kernel warnings or avc messages denying syslog
write to /dev/console.  So I could easily be wrong about that. 

Timothy,

> 
> => -----Original Message-----
> => From: Timothy Wood [mailto:timothy@hallcomp.com]
> => Sent: Thursday, July 11, 2002 3:55 PM
> => To: Stephen Smalley
> => Cc: Ed Street; 'SE Linux'
> => Subject: RE: sysadm_tty_device_t
> => 
> => В Чтв, 11.07.2002, в 13:39, Stephen Smalley написал:
> => >
> => > On Thu, 11 Jul 2002, Ed Street wrote:
> => >
> => > > And sysadm_tty_device_t?
> => >
> => > That was my point.  The ttys start in tty_device_t.  If login or
> => newrole
> => > creates a sysadm_r:sysadm_t shell, then it relabels the tty to
> => > sysadm_tty_device_t.  If login or newrole creates a user_r:user_t
> => shell,
> => > then it relabels the tty to user_tty_device_t.  These relabeling
> => > operations are based on type_change rules in the policy
> configuration.
> => >
> => > --
> => > Stephen D. Smalley, NAI Labs
> => > ssmalley@nai.com
> => >
> => 
> => So no matter what the file context is login and newrole relabel them
> => when they take control of the tty, correct?  If so, then it is really
> up
> => to the controlling program (or program that needs control in this
> case)
> => and so syslog needs premissions to relabel and/or control the tty,
> => yes/no?
> => 
> => Timothy,
> 
> 



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
