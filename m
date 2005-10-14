Message-ID: <435017B2.7040107@cornell.edu>
Date: Fri, 14 Oct 2005 16:40:18 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEMANAGE ] Add a few direct dbases to handle
References: <434FF612.8010708@cornell.edu> <4350131E.8060708@tresys.com>
In-Reply-To: <4350131E.8060708@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I thought we agreed to have a direct only accessible part of the 
> handle,  such as
>
> struct semanage_direct_handle {
>     semanage_handle_t *handle;
>     /* direct stuff goes here */
> };
I'm a little confused... 
The dbase_config_t type is an a container for a database and its method 
table, which together form an interface.
The interface does not specify implementation, so you can implement this 
database differently using the policy server.

That patch also included code to init this database using the direct 
"constructor" - when you call <something>_direct_dbase_init(). That part 
was wrong, and if you look in the bugfix patch (#5), you will see that I 
moved the direct-specific part into direct_api.h, to be invoked on 
connect(), rather than create().
> So that this stuff is only exposed to direct api functions? The policy 
> server shouldn't be filling out databases that are accessible to the 
> user since it needs to mediate access.
I'm not sure I understand this.. s/"are"/"aren't"?

Note that those databases are needed regardless of backend - they're 
specified using an interface.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
