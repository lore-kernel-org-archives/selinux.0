Date: Mon, 1 Jul 2002 16:13:23 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: /dev/mem error starting X11
In-Reply-To: <1025531480.13205.19.camel@phobos>
Message-ID: <Pine.GSO.4.33.0207011604050.14035-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 1 Jul 2002, Timothy Wood wrote:

> I just installed the latest 2.4-lsm package on an almost fresh install
> of RH7.3 (stock + gnome 2) and when I try to start X11 I get an error
> accessing /dev/mem (and as I just noticed /dev/apm_bios)

You need to set the type on the XFree86 program.  Justin Smith mentioned
this issue with RH7.3 previously on the list, along with a few other
changes he found necessary for RH7.3.  For a quick fix, just run:
chcon system_u:object_r:xserver_exec_t /usr/X11R6/bin/XFree86

To ensure that this type is preserved upon subsequent make relabel's, add
an appropriate entry to policy/file_contexts/program/xserver.fc.  We have
made this change in our internal tree, and it will be included in the
next public release.

> everything I keep getting an avc message dealing with dhcp.  The dhcp
> works, I'm just curious about the message if anyone can explain it.
>
> avc:  denied  { recvfrom } for  saddr=192.168.42.242 daddr=192.168.42.7
> netif=eth0 scontext=system_u:system_r:dhcpc_t
> tcontext=system_u:system_r:icmp_socket_t tclass=packet_socket

This indicates that dhcpcd is receiving a kernel-generated ICMP packet.
You can allow this via 'allow dhcpc_t icmp_socket_t:packet_socket
recvfrom;' in policy/domains/program/dhcpc.te.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
