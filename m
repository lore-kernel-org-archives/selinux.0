Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA15314
	for <selinux@tycho.nsa.gov>; Mon, 4 Mar 2002 09:36:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA18795
	for <selinux@tycho.nsa.gov>; Mon, 4 Mar 2002 14:35:15 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA18791 for <selinux@tycho.nsa.gov>; Mon, 4 Mar 2002 14:35:14 GMT
Date: Mon, 4 Mar 2002 09:36:05 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Lonnie Cumberland <lonnie@outstep.com>
cc: <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: Re: pppd_t domain
In-Reply-To: <4699.192.168.1.12.1015132950.squirrel@192.168.1.2>
Message-ID: <Pine.GSO.4.33.0203040925280.23292-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 3 Mar 2002, Lonnie Cumberland wrote:

> /usr/local/selinux/bin/checkpolicy:  loading policy configuration
> from policy.conf
>
> error in the statement ending on line 25168 (token ';'): unknown type
> mesg_t
>
> /usr/local/selinux/bin/checkpolicy:  error(s) encountered while
> parsing configuration
> make: *** [policy] Error 1

I'd suggest looking at line 25168 of policy.conf, as the error message
says.  According to the message, that line refers to an undefined type
mesg_t.  The most probable cause is that you made a typo while editing the
policy.

> You need something like the following in types/device.te:
> # net_device_t is the type of /dev/ppp
> type net_device_t, file_type;
>
> Also /dev/ppp has to have the SID
> system_u:object_r:net_device_t, use  devfs_contexts if you
> have devfs or file_contexts and a
> relabel otherwise (or  just a chsid as a faster alternative to
> a relabel).

When I merged Russell's pppd domain into our example policy, I renamed
his net_device_t type to ppp_device_t in device.te and pppd.te to be
more precise.  In file_contexts, I added:
/usr/sbin/pppd			system_u:object_r:pppd_exec_t
/dev/ppp			system_u:object_r:ppp_device_t

After editing file_contexts, you can then run 'make relabel' to relabel
the filesystem.  Or, to avoid taking the time to recheck the entire
filesystem, you can just relabel manually as follows:
chcon system_u:object_r:pppd_exec_t /usr/sbin/pppd
chcon system_u:object_r:ppp_device_t /dev/ppp

> Also, how do I add the pptp vpn daemon to this as well so that I
> will not get the errors in SELinux and so that my vpn can make
> the connection.

To place your pptpd daemon into the same domain as pppd, simply set the
executable type on the pptpd daemon.  You would add a line to
file_contexts for this daemon and run 'make relabel' or run chcon to set
the context on /usr/sbin/pptpd.  You then need to restart the daemon,
either by rebooting or by using run_init on the /etc/init.d script for the
daemon.  At that point, you will likely find that you still need to add
further permissions to the pppd_t domain for the pptpd daemon.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
