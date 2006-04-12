Subject: Re: Sendmail & SELinux policies, again
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tanel Kokk <tanel.kokk@seb.ee>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <443CB45E.5080400@seb.ee>
References: <443CB45E.5080400@seb.ee>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 08:43:40 -0400
Message-Id: <1144845820.20422.84.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-04-12 at 11:03 +0300, Tanel Kokk wrote:
> Hello
> 
> Everything works fine with sendmail & SELinux most of time. However, 
> sometimes SELinux in our server rejects such activities:
> 
> Apr 12 03:40:08 mx.internal audit(1144802408.867:9): avc:  denied  { 
> recv_msg } for  saddr=201.37.237.52 src=5989 daddr=192.168.xxx.xxx 
> dest=8025 netif=eth0 scontext=user_u:system_r:sendmail_t 
> tcontext=system_u:object_r:pegasus_https_port_t tclass=tcp_socket
> 
> Apr 12 03:40:11 mx.internal audit(1144802411.714:10): avc:  denied  { 
> recv_msg } for  saddr=201.37.237.52 src=5989 daddr=192.168.xxx.xxx 
> dest=8025 netif=eth0 scontext=user_u:system_r:sendmail_t 
> tcontext=system_u:object_r:pegasus_https_port_t tclass=tcp_socket
> 
> Apr 12 03:40:17 mx.internal audit(1144802417.727:11): avc:  denied  { 
> recv_msg } for  saddr=201.37.237.52 src=5989 daddr=192.168.xxx.xxx 
> dest=8025 netif=eth0 scontext=user_u:system_r:sendmail_t 
> tcontext=system_u:object_r:pegasus_https_port_t tclass=tcp_socket
> 
> , where mx.internal [192.168.xxx.xxx] is our email gateway and dest=8025 
> is port, where sendmail actually listening from (iptables forwards port 
> 25 to 8025 in transparent way).
> 
> With audit2allow I get:
> allow sendmail_t pegasus_https_port_t:tcp_socket recv_msg;
> 
> I found that there are some specific ports, which are defined as:
> portcon tcp 5989  system_u:object_r:pegasus_https_port_t
> portcon tcp 3306 system_u:object_r:mysqld_port_t
> portcon tcp 5432 system_u:object_r:postgresql_port_t
> portcon tcp 5988  system_u:object_r:pegasus_http_port_t
> portcon tcp 3128  system_u:object_r:http_cache_port_t
> portcon tcp 8080  system_u:object_r:http_cache_port_t
> portcon tcp 1-1023 system_u:object_r:reserved_port_t
> 
> So as I understand, when source connection come from so called 
> "specific" port (for example 5989) and goes to port 25, then this 
> connection will be rejected by default. What is that good for?
> 
> IMHO it is quite possible, that source port would be something like 
> 3128, 5988 or 3306.
> 
> I just thought to add such policies for sendmail_t:
> 
> allow sendmail_t pegasus_https_port_t:tcp_socket recv_msg;
> allow sendmail_t mysqld_port_t:tcp_socket recv_msg;
> allow sendmail_t postgresql_port_t:tcp_socket recv_msg;
> allow sendmail_t pegasus_http_port_t:tcp_socket recv_msg;
> allow sendmail_t http_cache_port_t:tcp_socket recv_msg;
> 
> Is it good solusion?

If you just want to allow sendmail_t to receive from any port, then you
can just use:
allow sendmail_t port_type:tcp_socket { recv_msg };

port_type is then expanded to the set of all types that have the
"port_type" attribute listed, either in their type declaration (ala type
foo_t, port_type;) or in a separate typeattribute declaration (ala
typeattribute foo_t port_type;).  All port types should have that
attribute.

I think that the example sendmail policy does allow send_msg and
recv_msg to all port types (via the can_network macro).  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
