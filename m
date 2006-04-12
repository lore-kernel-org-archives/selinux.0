Message-ID: <443CF802.1090802@seb.ee>
Date: Wed, 12 Apr 2006 15:52:18 +0300
From: Tanel Kokk <tanel.kokk@seb.ee>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Re: Sendmail & SELinux policies, again
References: <443CB45E.5080400@seb.ee> <1144845820.20422.84.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1144845820.20422.84.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> If you just want to allow sendmail_t to receive from any port, then you
> can just use:
> allow sendmail_t port_type:tcp_socket { recv_msg };
OK.

> 
> port_type is then expanded to the set of all types that have the
> "port_type" attribute listed, either in their type declaration (ala type
> foo_t, port_type;) or in a separate typeattribute declaration (ala
> typeattribute foo_t port_type;).  All port types should have that
> attribute.
> 
> I think that the example sendmail policy does allow send_msg and
> recv_msg to all port types (via the can_network macro).  
> 
Can I just add such macro to my policy?

can_network(sendmail_t)

Where I can get example sendmail policies? CentOS doesn'n have these
ones for sendmail.


-- 
Tanel Kokk


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
