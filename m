Date: Thu, 5 Sep 2002 11:01:19 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carstengrohmann@gmx.de>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: isdn and script problem
In-Reply-To: <200209041823.SAA02819@jazzswing.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0209051042140.17915-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 4 Sep 2002, Carsten Grohmann wrote:

> this time I write rules to use isdn with SELinux.
> The rules for isdnlog and isdnctrl are additional.
>
> I've follow 2 problems:
> 1.
>   I add entries for ippp to net_contexts and types/network.te. The entries
>   based on the eth0-entries and the patch patch_ifippp0 contains this
>   changes.
>   I don't know how can I garant user_r, sysadm_r and system_r access to the
>   network interfaces. I think follow rule is not the way to go
>     allow netmsg_t netif_t:netif { tcp_recv udp_recv };
>   This are the correspond log messages:
>    Sep  4 15:13:09 max kernel: avc:  denied  { udp_recv } for
>    saddr=192.76.144.66 source=17664 daddr=213.6.81.177 dest=244 netif=ippp0
>    scontext=system_u:object_r:netmsg_t tcontext=system_u:object_r:netif_t
>    tclass=netif
>    Sep  4 15:13:09 max kernel: avc:  denied  { tcp_recv } for
>    saddr=81.88.35.41 source=17664 daddr=213.6.81.177 dest=44 netif=ippp0
>    scontext=system_u:object_r:netmsg_t tcontext=system_u:object_r:netif_t
>    tclass=netif

It looks like your changes to net_contexts haven't taken effect, since the
above log messages are still showing netmsg_t and netif_t.  The SELinux
kernel module only obtains the network interface SID and default message
SID from the security server when the device is first
initialized/accessed.  The SIDs are then cached in the network device's
security structure as long as the device remains registered.  Try
rebooting with the new policy.

> 2.
>   The ipppd runs at start and stop a shell script. This script runs in the
>   ipppd_t domain and start different programms most with can_exec.
> . Two of this route and ifconfig runs via daemon_auto_trans(ipppd_t,
>    ..., ....) in his own domain.
>   After this I recive this log entry:
>   Sep  4 15:13:30 max kernel: avc:  denied  { read } for  pid=1991
>   exe=/sbin/ifconfig path=/etc/ppp/pap-secrets dev=03:0a ino=102578
>   scontext=system_u:system_r:ifconfig_t
>   tcontext=system_u:object_r:pppd_secret_t tclass=file
>   And I don't understand why needs ifconfig access to the ppp password
>   files?

It probably doesn't need such access.  A possible cause for the log
message is that ipppd failed to close an open descriptor to pap-secrets
[or mark the descriptor as close-on-exec] before exec'ing ifconfig, so
SELinux is checking access on the descriptor inheritance.  I'd suggest
using a dontaudit rule to suppress the log message without allowing
access.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
