Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA18724
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 15:50:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA29911
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 19:49:18 GMT
Received: from mail.hallcomp.com (hallcomp.com [208.140.194.52])
        by jazzband.ncsc.mil  with ESMTP id TAA29907 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 19:49:17 GMT
Subject: RE: sysadm_tty_device_t
From: Timothy Wood <timothy@hallcomp.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: Ed Street <blacknet@simplyaquatics.com>,
        "'SE Linux'"
	 <selinux@tycho.nsa.gov>
In-Reply-To: <Pine.GSO.4.33.0207111336390.15869-100000@raven>
References: <Pine.GSO.4.33.0207111336390.15869-100000@raven>
Content-Type: text/plain; charset=koi8-r
Date: 11 Jul 2002 15:55:03 -0400
Message-Id: <1026417306.1659.18.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

В Чтв, 11.07.2002, в 13:39, Stephen Smalley написал:
> 
> On Thu, 11 Jul 2002, Ed Street wrote:
> 
> > And sysadm_tty_device_t?
> 
> That was my point.  The ttys start in tty_device_t.  If login or newrole
> creates a sysadm_r:sysadm_t shell, then it relabels the tty to
> sysadm_tty_device_t.  If login or newrole creates a user_r:user_t shell,
> then it relabels the tty to user_tty_device_t.  These relabeling
> operations are based on type_change rules in the policy configuration.
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 

So no matter what the file context is login and newrole relabel them
when they take control of the tty, correct?  If so, then it is really up
to the controlling program (or program that needs control in this case)
and so syslog needs premissions to relabel and/or control the tty,
yes/no?

Timothy,


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
