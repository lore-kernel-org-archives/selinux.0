Subject: Re: diff between name_bind,bind and node_bind
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastian Pfaff <sebastian.pfaff@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3D57D9DF-104E-4603-A49E-37EDA16139CC@gmail.com>
References: <B2B8AAE9-85F2-4A92-AA25-88C1493A2EB2@gmail.com>
	 <1239107665.29028.13.camel@localhost.localdomain>
	 <3D57D9DF-104E-4603-A49E-37EDA16139CC@gmail.com>
Content-Type: text/plain
Date: Tue, 07 Apr 2009 12:41:00 -0400
Message-Id: <1239122460.29028.30.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-04-07 at 16:39 +0200, Sebastian Pfaff wrote:
> hello stephen,
> 
> tnx for your answer. it helped me a lot. i already  did a "quick"  
> check of  hooks.c before but i was not sure about it. for me there are  
> some other unknowns. i only saw, that selinux does make some  
> differences between various port "types/classes".
> 
> is it possible to control  that process cannot bind to a port which is  
> in local port area (~32000-61000)?
> 
> so far i think it isn't possible.

Not without further kernel changes.  You can however prevent it from
creating or binding sockets in the first place, or you can use e.g.
secmark to label all packets destined to a given port as having a given
type and then have policy control what sockets can receive such packets.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
