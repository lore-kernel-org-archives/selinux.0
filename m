Subject: Re: semodule problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>, selinux@tycho.nsa.gov
In-Reply-To: <45BA65FC.60705@tresys.com>
References: <p06002029c1e0096aebf1@[192.168.50.32]>
	 <45BA65FC.60705@tresys.com>
Content-Type: text/plain
Date: Fri, 26 Jan 2007 15:40:33 -0500
Message-Id: <1169844033.15390.389.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-26 at 15:35 -0500, Joshua Brindle wrote:
> Rosalie Hiebel wrote:
> > I was able to successfully modify, load, and test policy rules (using 
> > audit2allow to add rules) until I ran into a problem with one 
> > particular rule I tried to add.   After adding this rule
> >
> >    allow testserver_t self:process { setcurrent };
> >
> > then semodule gave me the following error:
> >
> >   libsepol.check_assertion_helper: assertion on line 0 violated by
> >             allow testserver_t testserver_t:process{ setcurrent };
> >   libsepol.check_assertions: 1 assertion violations occurred
> >   libsermanage.semanage_expand_ssandbox:Expand module failed
> >
> > Any clues what caused this?
> >
> > Thanks
> # enabling setcurrent breaks process tranquility.  If you do not
> # know what this means or do not understand the implications of a
> # dynamic transition, you should not be using it!!!
> neverallow { domain -set_curr_context } self:process setcurrent;
> 
> This neverallow doesn't let anything use setcurrent unless it has the 
> set_curr_context attribute (assigned using the domain_dyntrans_type 
> interface). You typically shouldn't be using setcurrent anyway, is there 
> something specific you are trying to do?

And, to clarify, neverallow statements are assertions in the policy that
are checked whenever it is built, including when modules are added.
They are helpful in catching errors or unsafe rules.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
