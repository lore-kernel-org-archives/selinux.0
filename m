Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9PIP9XZ006018
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2004 14:25:09 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9PIP1mE021269
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2004 18:25:01 GMT
Subject: Re: [patches] SE-DBUS policy revamp [1/2]
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
In-Reply-To: <1098569359.8447.47.camel@x-infinity.verbum.private>
References: <1098569359.8447.47.camel@x-infinity.verbum.private>
Content-Type: multipart/mixed; boundary="=-DhhteKamEZewVbzGdKTT"
Date: Mon, 25 Oct 2004 11:41:45 -0400
Message-Id: <1098718905.18089.21.camel@decepticon.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-DhhteKamEZewVbzGdKTT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2004-10-23 at 18:09 -0400, Colin Walters wrote:

> I think the policy actually came out cleaner after macroizing
> can_dbusd_converse.

Should have tested the session bus in addition to the system one.
Here's an interdiff.



--=-DhhteKamEZewVbzGdKTT
Content-Disposition: attachment; filename=dbus-policy-revamp-2.patch
Content-Type: text/x-patch; name=dbus-policy-revamp-2.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -u policy.hacked/macros/base_user_macros.te policy.hacked/macros/base_user_macros.te
--- policy.hacked/macros/base_user_macros.te	2004-10-23 15:33:47.271394352 -0400
+++ policy.hacked/macros/base_user_macros.te	2004-10-25 11:12:35.032343856 -0400
@@ -191,17 +191,22 @@
 can_network($1_t)
 can_ypbind($1_t)
 
-# Grant permissions to access the system DBus
 ifdef(`dbusd.te', `
+# Grant permissions to access the system bus
 dbusd_client(system, $1)
-dbusd_client($1, $1)
+# Create derived domain for session bus, allow access
 dbusd_domain($1)
+dbusd_client($1, $1, $1)
+# Allow any service acquisition on session bus
+# until we have user programs running in separate
+# domains
+allow $1_dbusd_$1_t $1_dbusd_t:dbus { acquire_svc };
 ifdef(`hald.te', `
 can_dbusd_converse(system, hald, $1)
 ') dnl end ifdef hald.te
-ifdef(`cupsd.te',`
+ifdef(`cups.te',`
 # Only one-way conversation from cupsd -> user
-allow cupsd_system_dbusd_t $1_dbusd_system_t:dbus { send_msg };
+allow cupsd_dbusd_system_t $1_dbusd_system_t:dbus { send_msg };
 can_dbusd_converse(system, cupsd_config, $1)
 ')
 ') dnl end ifdef dbus.te

--=-DhhteKamEZewVbzGdKTT--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
