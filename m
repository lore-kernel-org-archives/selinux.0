Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA02750
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 09:08:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA23067
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 13:07:46 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA23063
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 13:07:45 GMT
Date: Thu, 8 Aug 2002 09:01:02 -0400 (EDT)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Samarth  Sharma <samarth7880@rediffmail.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: your mail
In-Reply-To: <20020808112849.16449.qmail@webmail26.rediffmail.com>
Message-ID: <Pine.LNX.4.33.0208080850160.9323-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8 Aug 2002, Samarth  Sharma wrote:

> hi,
>   A security aware application like the sshd daemon acts as an
> object manager for all its related processes..is this correct?? or
> are object managers are a part of the kernel.
>   if sshd does act as an object manager who enforces the access
> decisions for the sshd daemon..
>   Also if the daemon does act as an object manager does it not
> involve incorporating policy logic in the manager therby violating
> the primary principle of Flask architecture..

  All object access by processes will be controlled by the SELinux
module.  Security aware applications can make use of extended system calls
provided with SELinux to control security IDs on objects, but only as far
as the policy allows. Therefore, there is no violation, or bypassing, of
the controls provided by the Flask architecture.

  The application can control labeling of objects, but not the enforcement
of the policy based on those labels.


-- 
Wayne Salamon
wsalamon@tislabs.com


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
