Date: Tue, 23 Mar 2004 10:32:45 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Jaroslav Kucera <xkucera4@informatics.muni.cz>
cc: SELinux@tycho.nsa.gov
Subject: Re: IP connection restrictions
In-Reply-To: <Pine.SGI.4.58.0403230015100.1566883@aisa.fi.muni.cz>
Message-ID: <Xine.LNX.4.44.0403230720250.23975-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 Mar 2004, Jaroslav Kucera wrote:

> Hi!
> 
> Is there a possibility to restrict any program from connecting to
> specified IPv4 or IPv6 adresses (or allow to connect only to allowed IP
> adresses) using SELinux features only?
> I know that this can be used for TCP or UDP ports, but that's not the
> right thing I need...

You can control the ability of domains to send and receive TCP, UDP and 
'rawip' messages to and from an IPv4 node (IPv6 support is almost ready).

This is done with tcp/udp/rawip_send/recv permissions in the node 
class.  e.g.

allow staff_ssh_t node_internal_t:node { tcp_send udp_send rawip_send };
allow staff_ssh_t node_internal_t:node { tcp_recv udp_recv rawip_recv };

A 'rawip' message in SELinux policy includes anything that is not TCP or 
UDP, including ICMP.


- James
-- 
James Morris
<jmorris@redhat.com>




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
