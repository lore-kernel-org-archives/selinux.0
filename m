Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9NCmw7S024941
	for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2007 08:48:58 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l9NCmw1t019335
	for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2007 12:48:58 GMT
Subject: SE-DBUS policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 23 Oct 2007 12:46:20 +0000
Message-Id: <1193143580.9466.47.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there any documentation on the SELinux behavior on dbus?  From some
discussion in the IRC channel, the policy templates (which is still
basically the NSA example policy stuff) don't match the code.

The templates creates a type:

type [connector domain prefix]_dbusd_[bus owner prefix]_t;

so if you have staff_r's connection to the system bus, you get
staff_dbusd_system_t.  Then there is a type_change so dbus knows what
label to give the connection:

type_change [domain] [bus owner prefix]_dbusd_t:dbus [connector type];

which results in something like this:

type user_mozilla_dbusd_system_t;
type_change user_mozilla_t system_dbusd_t:dbus user_mozilla_dbusd_system_t;

Then based on the template, I believe the premise was that the dbus
permissions would be between these derived types.  However, in the
policy there are no dbus:send_msg rules for these types (except for the
ones given in the templates), and instead rules are against the real
domains, (e.g. allow NetworkManager_t dhcpd_t:dbus send_msg;).  So I
looked in the dbus code, and I didn't see any calls to
security_compute_relabel().  It looks like this bit of policy is dead,
and the templates need to be revised.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
