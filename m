From: Paul Moore <paul@paul-moore.com>
To: vlad halilov <vlad.halilov@gmail.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: network, deep drive
Date: Mon, 20 May 2013 14:58:02 -0400
Message-ID: <2466345.2mjuuyBiSJ@sifl>
In-Reply-To: <CAHw9pMUEcHa_HExVs+yyJOVk8oVEkQ84o4aywemZ+ZvMYT0=LA@mail.gmail.com>
References: <CAHw9pMUEcHa_HExVs+yyJOVk8oVEkQ84o4aywemZ+ZvMYT0=LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday, May 19, 2013 05:10:45 PM vlad halilov wrote:
> That's some strange issue appears with labeled networking. I tried to test
> some basic rules before mlp expreiments, but got unexpected results. Base
> configuration (tx-like):

A few comments on your configuration below ...
 
> netlabelctl unlbl add interface:eth0 address:0.0.0.0/0
> 	label:system_u:object_r:node_t:s1
> netlabelctl unlbl add interface:eth0
> 	address:192.168.1.196/0 label:system_u:object_r:node_t:s4

Generally node_t is used for network nodes while netif_t is used for 
interfaces.  I would recommend changing from "node_t:s1" to "netif_t:s1" and 
"node_t:s4" to "netif_t:s4".

Also just for clarification, you do realize that 0.0.0.0/0 and 192.168.1.196/0 
are the same, yes?  In fact, you shouldn't even be able to configure the above 
you should get an "netlabelctl:error, File exists" error message (I do on my 
RHEL6 system).  Perhaps a cut-and-paste error when writing your email?

> netlabelctl map del default
> netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
> netlabelctl cipsov4 add pass doi:32 tags:1
> netlabelctl map add default address:127.0.0.0/8 protocol:cipsov4,32
> netlabelctl map add default address:192.168.1.96/32
> 	protocol:cipsov4,32 #eth0
> 
> Iptables allowed all, and have no any secmark rules.
> 
> So, some examples. Here, i have executed nc in listen: nc -l 5000 with
> user_u:user_r:user_t:s4 (additional policy that allow user_u to create
> socket, allowing node_t, ingress  & etc in effect)
> 
> 1) telnet from same user (user_u:user_r:user_t:s4)  and same context is
> succesfull. Two way exchange via 127.0.0.1 or 192.168.1.96 interfaces.
> Thats right.

Good.

> 2) telnet from external network from host (system_u:object_r:node_t:s4) same
> result, two way exchange. That's right too.

Good.

> 3) telnet from external network (system_u:object_r:node_t:s1)  established,
> but only one way (s1 -> s4). On trying to send string back from nc to
> telnet and got connection closed... that's right from one side of view but
> no deny avc in audit. Dontaudit rules disabled. One strange.

I assume that the external network/host is unlabeled and you are using the 
static/fallback labeling to label the incoming traffic?  If so, could you 
first correct your static/fallback configuration (see above) and try again?

> 4) telnet from same host but user context is ' user_u:user_r:user_t:s1' to
> 127.0.0.1 or 192.168.1.96 - timed out... hmm.. that's strange. All needed
> selinux context is allowed (or we got deny on step 1, but why we got
> different result withing step 3? So, second issue.

Any AVC denials?

> 5) And most strange.... telnet from same host, different user
> (user_u:user_r:user_t:s1:c0.c255) to any local address (127 or 192) got an
> error: no space left on device . ouch. what device.. what space. space
> space, i need space (sorry).

You configured CIPSO to use only tag type #1 which is limited to categories 
c0.c240.  If you want to use more than that you will need to look at the other 
tag types: enumerated (#2) or ranged (#5).  Note that you can specify a 
prioritized list of CIPSO tags in your netlabelctl command line, e.g. 
'tags:2,5,1'; see the man page and the CIPSO draft specification[1] for more 
details.

[1] http://netlabel.sourceforge.net/files/draft-ietf-cipso-ipsecurity-01.txt

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
