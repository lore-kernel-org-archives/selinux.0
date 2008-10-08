Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m98D6CdK027645
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2008 09:06:12 -0400
Received: from goalkeeper.city-fan.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m98D4xWc007763
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2008 13:05:01 GMT
Message-ID: <48ECB037.2070203@city-fan.org>
Date: Wed, 08 Oct 2008 14:05:59 +0100
From: Paul Howarth <paul@city-fan.org>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] Milter Mail Filters
References: <484D4B53.5020006@city-fan.org>	 <1216385922.21191.125.camel@gorn>  <48982587.30605@city-fan.org>	 <1220621188.28287.79.camel@gorn.columbia.tresys.com>	 <48C6A124.7090707@city-fan.org>  <48D78F39.3040801@city-fan.org> <1223302377.2165.5.camel@gorn>
In-Reply-To: <1223302377.2165.5.camel@gorn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Mon, 2008-09-22 at 13:27 +0100, Paul Howarth wrote:
>> Updated patch: sendmail, when run as "newaliases", tries to getattr() 
>> milter sockets as well as the directories they live in, so I changed
>> the 
>> milter_getattr_all_data_dirs interface to milter_getattr_all_sockets.
>>
>> I also moved the call to this interface in mta.te out from the middle
>> of 
>> a bunch of postfix-related lines.
>>
>> Paul.
> 
> I think my last two comments are
> 
> * you can't require milter_port_t.  It doesn't seem like a generic port
> type would be useful anyway, otherwise there would be a port defined.

So I should change "allow milter_$1_t milter_port_t:tcp_socket 
name_bind;" to "corenet_tcp_bind_generic_port($1_milter_t)"?

I can do that but I don't understand why milter_port_t should be any 
different than say stunnel_port_t, which also doesn't have a default 
port defined, and would be used in a similar way, i.e. an admin would 
set up an application to use a specific port (a milter running over tcp 
needs to have a port specified, just a tunnel set up using stunnel does 
- they don't just bind to random generic ports).

> * milter vs milters inconsistency of naming

I'll rename the module and the file to milter then, though I'd hoped 
that "milter" would have been accepted as an abbreviation of "milters".

> * derived types should have the prefix first, eg, $1_milter_t not
> milter_$1_t.

I'll change those.

Paul.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
