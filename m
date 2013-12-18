References: <1387381759.80678.YahooMailNeo@web163404.mail.gq1.yahoo.com>
 <cede51375f174d7da793c4f9d95664ef@AMXPR03MB136.eurprd03.prod.outlook.com>
Message-ID: <1387388840.53437.YahooMailNeo@web163406.mail.gq1.yahoo.com>
Date: Wed, 18 Dec 2013 09:47:20 -0800 (PST)
From: Andy Ruch <adruch2002@yahoo.com>
Subject: Re: selinux control for network interface using SOCK_RAW
To: Colin Powers <Colin.Powers@nexor.com>,
 "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
In-Reply-To: <cede51375f174d7da793c4f9d95664ef@AMXPR03MB136.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Reply-To: Andy Ruch <adruch2002@yahoo.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>






On Wednesday, December 18, 2013 10:33 AM, Colin Powers <Colin.Powers@nexor.com> wrote:

I'd be interested to see what others have to say on this too.
> 
>You can achieve what you are doing using iptables and SECMARK, see the links below:
>http://selinuxproject.org/page/NB_Networking
>http://james-morris.livejournal.com/11010.html
>http://www.linux.com/learn/tutorials/421152-using-selinux-and-iptables-together
> 
>The basic idea being that you:
>·         Create a type, for example, eth0_packet_t
>·         Use iptables to label all packets on eth0 as eth0_packet_t
>·         Grant permissions on eth0_packet_t as necessary, e.g. allow my_app_t eht0_packet_t : packet {send recv}
> 
>I'd be very interested to hear others' opinions on whether this is best practice!
> 
>Cheers
>Colin
> 
>From:Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of Andy Ruch
>Sent: 18 December 2013 15:49
>To: SELinux ML
>Subject: selinux control for network interface using SOCK_RAW
> 
>Hello,
> 
>I'm trying to restrict an application to only have access to some network interfaces. I'm running a custom policy on a RHEL 6.3 system. The application is opening the socket as AF_PACKET and SOCK_RAW. However, selinux doesn't seem to be controlling any raw access to the interfaces.
> 
>I've confirmed using apol that there are no rules for the interface type that would allow access. I've also confirmed that the only attribute on the interface is netif_type and that the only access to netif_type is from kernel_t. 
> 
>I've granted the application:
>    allow my_app_t self:packet_socket { connected_socket_perms };
>    allow my_app_t self:capability { net_raw };
>
>I was expecting to have to do something like:
>    allow my_app_t my_iface_t:netif { some_permission };
> 
>Is there any way for me to enforce network interface separation? Or does packet_socket always allow access to all interfaces?
> 
>Thanks,
>Andy Ruch
>
>_______________________________________________
>Selinux mailing list
>Selinux@tycho.nsa.gov
>To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
>

Thanks for the response. I'm using packet labeling for when I open standard TCP/UDP connections. However, because this is a raw packet socket, I believe I'm handling the data before it gets to IPTables. I need a way to restrict which interface I'm allowed to bind a packet_socket to.
