Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA9MFGIi026170
	for <selinux@tycho.nsa.gov>; Tue, 9 Nov 2004 17:15:16 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA9MDoxr021418
	for <selinux@tycho.nsa.gov>; Tue, 9 Nov 2004 22:13:53 GMT
Message-ID: <41914166.3070702@redhat.com>
Date: Tue, 09 Nov 2004 17:15:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>
Subject: Re: can_network patch
References: <41741A2C.8040408@redhat.com>	 <200410260138.19426.russell@coker.com.au>	 <20041025213122.GA2535@jmh.mhn.de>	 <200410270036.14935.russell@coker.com.au>	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>	 <418C621A.5060208@redhat.com> <1100036063.30448.72.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1100036063.30448.72.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Carter wrote:

>This patch is on the right track.
>
>On Sat, 2004-11-06 at 00:33, Daniel J Walsh wrote:
>  
>
>>This is the patch that eliminates connect from can_network.
>>
>>The batch basically does a couple of things
>>
>>can_network now calls
>>can_tcp_network
>>can_udp_network
>>    
>>
>
>I think can_network should have the same functionality as before.
>There should be new macros for the reduced permissions.
>It seems like we should have at least these macros:
>
>can_tcp_client (or can_tcp_out) - connect, etc
>can_tcp_server (or can_tcp_in) - bind, listen, accept, etc
>can_udp
>can_udp_connect - if connect is needed.
>
>  
>
>This patch has 34 lines adding connect permissions.  We should
>definitely seek to reduce the number of lines related to networking
>outside of the network macros.  I think Russell made a similar comment a
>while back.
>  
>
My goal with the redesign was to make connect equivalent to name_bind.

After examining this further and talking with James, I realize that this 
is not possible
without a modification to the kernel.

Basically I want name_connect permission, so the policy would be written 
such that
a domain can only "connect" to certain ports.   So a domain which did a 
connect(socket, DNS_PORT_T)
Would need a rule like
allow mydomain_t dns_port_t:socketc name_connect;

Then all domains that can_network would either have a name_bind or a 
name_connect  associated
with it and a lock down of the ports that they will use.

One goal of a lot of hackers now is to take over machines and use them 
as mail forwarders
(Spammers) or as launch sites for further attacks.  You don't even need 
root access to do this. 
Our current can_network() allows you all domains to connect to any port 
using UDP and TCP.

I have gotten partially there by breaking can_network into 
can_udp_network and
can_tcp_network.  Also eliminating the connect priveledge from all 
daemons that don't use it
makes them more secure. 

The port stuff that I added does not work as I expected and I am 
removing some of it.

>  
>
>>diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/core_macros.te policy-1.18.2.old/macros/core_macros.te
>>--- policy-1.18.2/macros/core_macros.te	2004-11-05 23:39:10.000000000 -0500
>>+++ policy-1.18.2.old/macros/core_macros.te	2004-11-05 23:57:55.360848660 -0500
>>@@ -132,22 +132,32 @@
>> #
>> # Permissions for using sockets.
>> # 
>>-define(`rw_socket_perms', `{ ioctl read getattr write setattr append bind connect getopt setopt shutdown }')
>>+define(`rw_socket_perms', `{ ioctl read getattr write setattr append bind getopt setopt shutdown }')
>> 
>> #
>> # Permissions for creating and using sockets.
>> # 
>>-define(`create_socket_perms', `{ create ioctl read getattr write setattr append bind connect getopt setopt shutdown }')
>>+define(`connected_socket_perms', `{ create rw_socket_perms }')
>>    
>>
>
>This doesn't make sense to me.  Why grant "create", if already
>connected?
>
>  
>
connected_socket_perms might not be a great name, but it is to be used 
with accept(socket) daemons,
versus connect(socket) domains.  We named it that because it is just 
removing the "connect" privledge, so the
socket must all ready be "connected" :^).

>>+
>>+#
>>+# Permissions for creating, connecting and using sockets.
>>+# 
>>+define(`create_socket_perms', `{ connected_socket_perms connect }')
>> 
>> #
>> # Permissions for using stream sockets.
>> # 
>>-define(`rw_stream_socket_perms', `{ ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept }')
>>+define(`rw_stream_socket_perms', `{ rw_socket_perms listen accept }')
>>+
>>+#
>>+# Permissions for creating and using stream sockets.
>>+# 
>>+define(`connected_stream_socket_perms', `{ create rw_stream_socket_perms }')
>> 
>>    
>>
>
>Same thing here.
>
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
