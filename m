Subject: Re: diff between name_bind,bind and node_bind
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastian Pfaff <sebastian.pfaff@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <B2B8AAE9-85F2-4A92-AA25-88C1493A2EB2@gmail.com>
References: <B2B8AAE9-85F2-4A92-AA25-88C1493A2EB2@gmail.com>
Content-Type: text/plain
Date: Tue, 07 Apr 2009 08:34:25 -0400
Message-Id: <1239107665.29028.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-04-07 at 09:46 +0200, Sebastian Pfaff wrote:
> hello,
> 
> i'm working on a tutorial for selinux. in this tutorial i use nc  
> (netcat) as simple server. but i wonder, why nc -l 5555** (nc runs in  
> a own domain) does not need the name_bind permission to bind a port.
> i already asked here regarding to this, but nobody has answered.
> 
> can someone tell me how name_bind,bind and node_bind work and where  
> the differences are?
> 
> i tried this  with socat (http://www.dest-unreach.org/socat/) too.  
> same effect. both socat and nc  "never"* need name_bind.
> 
> is it possible that this pb is relying on how nc and socat work?
> 
> tnx in advance && if you need  further information, please let me  
> know ...

Hopefully my other reply clears this up for you - name_bind is not
applied to ports in the auto-bind range.  You can see this quite clearly
from the code; look at security/selinux/hooks.c:selinux_socket_bind().

> * funny is, if i implement a boolean which allows nc or socat to use  
> any port or only a speficic port, then i can see a name_bind "entry"   
> when in permissive mode in my avc log.  but i can't reproduce it.  
> maybe this is another problem.

Permissive mode only logs each unique denial once by design, as you only
need one instance of each denial in order to generate policy and
otherwise permissive mode is prone to flooding of the system log / audit
log.

> ** same with echo "hello world" | socat - TCP-LISTEN: 
> 33331,bind=127.0.0.1 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
