Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Message-Id: <77E887A5-618A-42CD-96D6-D811282F18CB@gmail.com>
From: Sebastian Pfaff <sebastian.pfaff@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1239122320.29028.28.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: nc -l does not need permission name_bind to bind to a port!?
Date: Tue, 7 Apr 2009 18:57:00 +0200
References: <DE3691C6-1C5C-4C6C-BC7C-DC0B41698A25@gmail.com> <1239107410.29028.10.camel@localhost.localdomain> <49DB643E.4060907@redhat.com> <1239122320.29028.28.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ok, thank you for the quick answer. now everything is clear.

--
Sebastian Pfaff


Am 07.04.2009 um 18:38 schrieb Stephen Smalley:
>>
> It doesn't make sense to use a port in the local port range as a
> well-defined service port since such a port can be allocated at any  
> time
> for an unbound socket upon a send or connect.  Thus, it didn't seem
> useful to try to control the name binding of such ports - the port
> numbers in that range (should) have no inherent meaning tied to them,
> and thus spoofing them is of no interest.  You can already prevent a
> process from creating INET sockets altogether (create permission), or
> prevent them from using bind(2) altogether (bind permission).  You can
> also use secmark to e.g. label all packets destined for a given port
> with a given type, and then use policy to prevent receipt of such
> packets on sockets in certain domains.
>
> Regardless, if you truly wanted name_bind applied to all ports and you
> wanted to avoid trivial circumvention by way of calling send* on an
> unbound socket, then someone would need to modify the TCP and UDP
> get_port functions to invoke a LSM hook to filter/select the ports
> returned for auto-binding.  Merely checking name_bind in
> selinux_socket_bind() for such ports wouldn't be sufficient.
>
> -- 
> Stephen Smalley
> National Security Agency
>






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
