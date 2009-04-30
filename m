Subject: Re: labeled network aware kernel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mark Webb <elihusmails@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <9f066ee90904292005i282d1339ld060cd90fa9e9dae@mail.gmail.com>
References: <9f066ee90904220426g563d2ebpa708ef8b6e1a4378@mail.gmail.com>
	 <C61510C5.A6A7F%csellers@tresys.com>
	 <9f066ee90904222001xb31b39ajf6953ca0767f3494@mail.gmail.com>
	 <1240609446.13724.20.camel@faith.austin.ibm.com>
	 <9f066ee90904292005i282d1339ld060cd90fa9e9dae@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 30 Apr 2009 08:01:11 -0400
Message-Id: <1241092871.27331.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-04-29 at 23:05 -0400, Mark Webb wrote:
> I am working to get the labelled IPSec working, following Josh
> Brindle's blog post
> (http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux).
>  I just want to get the client and server running on loopback, using a
> fully patched Fedora 10 machine.
> 
> I have the following keyfile that I pass into setkey:
> ----------
> spdflush;
> 
> flush;
> 
> spdadd 127.0.0.1 127.0.0.1 any
> -ctx 1 1 "system_u:object_r:default_t:s0"
> -P in ipsec esp/transport//require;
> 
> spdadd 127.0.0.1 127.0.0.1 any
> -ctx 1 1 "system_u:object_r:default_t:s0"
> -P out ipsec esp/transport//require;
> ----------
> 
> I enter the following commands:
> 
> --- Terminal 1 ---
> setenforce 0
> setkey -f <keyfile>
> ./server
> 
> --- Terminal 2 ---
> # ./client 127.0.0.1
> getpeercon: Protocol not available
> Received: Hello, (null) from (null)
> 
> --- Terminal 1 ---
> getsockopt: Protocol not available
> server: got connection from 127.0.0.1, (null)
> 
> Not sure what I am missing.  I have installed ipsec-tools and started
> /etc/init.d/racoon.
> 
> Any help would be appreciated.

IPSEC and loopback don't generally get along very well.  Try:
echo 0 > /proc/sys/net/ipv4/conf/lo/disable_policy
echo 0 > /proc/sys/net/ipv4/conf/lo/disable_xfrm

Might want to also read through an old bug report on this issue,
https://bugzilla.redhat.com/show_bug.cgi?id=218386

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
