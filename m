Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA06683
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2001 09:08:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA10239
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2001 13:07:16 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id NAA10235
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2001 13:07:16 GMT
Date: Thu, 30 Aug 2001 09:08:28 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Conan Callen <ccallen@windowpane.com>
cc: selinux@tycho.nsa.gov
Subject: Re: Successful install 
In-Reply-To: <01ac01c130d4$5885ac80$3a8314d1@nwlink.com>
Message-ID: <Pine.SOL.3.95.1010830085039.24840C-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 29 Aug 2001, Conan Callen wrote:

> I finished the install this morning, selinux is up and runing. 
> It all seems to be running ok.

Good.  Be sure to verify that none of your daemons were left in
the initrc_t domain by checking the ps -e --context output.  If
so, then you'll need to define domains for those daemons or disable
them if you don't want to use them.  Also check your /var/log/messages
file for 'avc: denied' messages to see if you need to add any
permissions to the example policy for your particular system.
When you think the policy is ready, you can toggle the system
into enforcing mode with avc_toggle (or rebuild the kernel with
CONFIG_FLASK_DEVELOP undefined).

> I read earlier that selinux had no support for x windows, is this still 
> true with this latest drop? Is anyone working on a secured desktop?

In the example policy released with the new prototype, I commented out
some of the permissions needed by the X server because they are very
dangerous.  See the lines preceded by 'Commented out by default' in
policy/domains/program/xserver.te.  You can uncomment those permissions
if you want, but the consequence is that a bug in the X server can be
catastrophic to the security of your system.  Also, this only allows
you to run X via startx after a normal login - it doesn't deal with
running an X display manager.  Mark Westerman has made some modifications
to gdm for this purpose and put them on the sourceforge site.

The X server really needs to be partitioned up more, so that only
a small section of code needs to be granted these highly sensitive
permissions.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
