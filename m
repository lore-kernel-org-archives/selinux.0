Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i161GrRb020097
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 20:16:53 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i161FTQk003887
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 01:15:29 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id i161FTYo003881
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 01:15:29 GMT
Subject: Re: make relabel error
From: "Stephen C. Tweedie" <sct@redhat.com>
To: keen@internode.on.net
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <4021fa76.336.47d3.1608314121@internode.on.net>
References: <4021fa76.336.47d3.1608314121@internode.on.net>
Content-Type: text/plain
Message-Id: <1076030204.2003.222.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Date: 06 Feb 2004 01:16:44 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Thu, 2004-02-05 at 07:50, keen wrote:

> system_u:object_r:inetd_child_exec_t on line number 725
> /usr/sbin/setfiles:  invalid context
> system_u:object_r:inetd_child_exec_t on line number 726
> Exiting after 10 errors.
> make: *** [relabel] Error 1
> 
> What have I missed? Could anyone help me on this? Your
> attention is greatly appreciated. Thank you.

If you installed the policy rpm itself without an intervening reboot,
then the policy may not actually be loaded in the kernel, and the kernel
won't let you set contexts that aren't mentioned in its loaded policy. 
You need a "make load" before the "make relabel" to load the new policy.

Cheers, 
 Stephen



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
