Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA23190
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2002 11:03:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA02541
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2002 16:02:25 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA02537
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2002 16:02:25 GMT
Date: Thu, 7 Feb 2002 11:02:06 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: USB device files
In-Reply-To: <20020207003937.1CB3F388D16@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0202071049071.6028-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 7 Feb 2002, Russell Coker wrote:

> Is there any way of automatically labelling the device nodes on the usbdevfs
> which is mounted on /proc/bus/usb for USB systems?
>
> Something like the method used for devfs would be good for the next release...

Do you have any suggestions as to what a reasonable file labeling
hierarchy might look like for usbdevfs?  I'm not sure what types to
define and assign in the example policy.

I would also like to have a more general mechanism for some of these
pseudo filesystem types.  Unfortunately, there doesn't seem to be a lot of
commonality among them in terms of the appropriate file labeling behavior.
Perhaps we could generalize the current devfs labeling support to also
address usbdevfs?  We might also want to use this support for the portions
of /proc outside of the /proc/PID directories (which should
continue to inherit their SID from associated task) and the /proc/sys tree
(which should use the same SID as the corresponding sysctl variable).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
