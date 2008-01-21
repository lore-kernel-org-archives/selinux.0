Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0LIS3sd003059
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2008 13:28:03 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0LIS2Ts029441
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2008 18:28:02 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m0LIS1fK032584
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2008 13:28:01 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m0LIS0P9001697
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2008 13:28:01 -0500
Received: from vpn-14-217.rdu.redhat.com (vpn-14-217.rdu.redhat.com [10.11.14.217])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m0LIRvF0018113
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2008 13:27:58 -0500
From: Steve Grubb <sgrubb@redhat.com>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: New audit plugin for prelude
Date: Mon, 21 Jan 2008 13:27:26 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200801211327.26295.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I just wanted to drop a line to mention a new plugin that I've created for the 
audit event dispatcher that can pick off AVC's and format a message for the 
prelude IDS system via IDMEF. This is available in audit-1.6.6.tar.gz. This 
is in the latest audit package on rawhide.

To test it, you have to put selinux in permissive mode for now since we don't 
have policy around it yet. I have started a prelude HOWTO here:

http://people.redhat.com/sgrubb/audit/prelude.txt

This plugin + prelude will allow an admin to watch a whole roomful of 
computers if they are configured to send events to a common prelude manager. 
The plugin also detects and sends IDMEF events for apps that terminate 
abnormally (gcc stack overflow/glibc FORTIFY_SOURCE/plain old segfault), 
logins, MAX failed logins reached, MAX concurrent sessions reached, and AVCs.

I am open to feedback on the message as this is proof of concept right now. I 
will be enhancing the plugin to detect more events and give better 
information.

Thanks,
-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
