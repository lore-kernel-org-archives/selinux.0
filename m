Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA21014
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2001 10:27:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA22309
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2001 14:26:45 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA22305
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2001 14:26:44 GMT
Date: Tue, 29 May 2001 10:26:32 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Jan Petranek <jan.petranek@student.uni-tuebingen.de>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: SELinux on a Workstation Reprise
In-Reply-To: <Pine.LNX.4.30.0105291349590.18681-100000@linux42.zdv.uni-tuebingen.de>
Message-ID: <Pine.SOL.3.95.1010529100827.17107H-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 29 May 2001, Jan Petranek wrote:

> the discussion about the topic was quite fruitful to me, so I decided on
> installing SELinux on my desktop and to trying to find a suitable policy.
> 
> So... has anyone actually _done_ this before?

As one of the SELinux developers, I ran SELinux on my desktop starting 
in June 2000 up until very recently (when I switched over to running
the prototype SELinux security module that we are developing for
the LSM-patched kernel - no, it isn't ready for general use).  The example
policy configuration was largely based on that experience.  So it should
provide a good starting point for your own use.  I would suggest that you
perform an ordinary install of SELinux on your desktop following the
INSTALL instructions, checking for processes in inappropriate domains
(instruction 17) and for permission failures in your /var/log/messages
file or dmesg output. You will likely find that you need to define some
new domains for processes and adjust your configuration for your specific
needs.  Be careful not to grant permissions just because they
are being requested - make sure that you understand why a
particular permission is needed and whether it is acceptable
to grant that permission or whether you can find a workaround
to allow the desired functionality without sacrificing the
protection.
 
Feel free to ask lots of questions on this list about specific
problems you encounter in configuring SELinux for your desktop,
and please share any improvements you make to the policy configuration
so that we can incorporate them back into the example configuration
(with proper attribution, of course).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
