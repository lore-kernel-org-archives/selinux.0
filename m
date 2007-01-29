Subject: Re: semodule problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>
Cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <p0600202ac1e0148a87d6@[192.168.50.32]>
References: <p06002029c1e0096aebf1@[192.168.50.32]>
	 <45BA65FC.60705@tresys.com>  <p0600202ac1e0148a87d6@[192.168.50.32]>
Content-Type: text/plain
Date: Mon, 29 Jan 2007 08:12:10 -0500
Message-Id: <1170076330.8720.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-26 at 15:33 -0500, Rosalie Hiebel wrote:
> >Rosalie Hiebel wrote:
> >>I was able to successfully modify, load, and test policy rules 
> >>(using audit2allow to add rules) until I ran into a problem with 
> >>one particular rule I tried to add.   After adding this rule
> >>
> >>    allow testserver_t self:process { setcurrent };
> >>
> >>then semodule gave me the following error:
> >>
> >>   libsepol.check_assertion_helper: assertion on line 0 violated by
> >>             allow testserver_t testserver_t:process{ setcurrent };
> >>   libsepol.check_assertions: 1 assertion violations occurred
> >>   libsermanage.semanage_expand_ssandbox:Expand module failed
> >>
> >>Any clues what caused this?
> >>
> >>Thanks
> ># enabling setcurrent breaks process tranquility.  If you do not
> ># know what this means or do not understand the implications of a
> ># dynamic transition, you should not be using it!!!
> >neverallow { domain -set_curr_context } self:process setcurrent;
> >
> >This neverallow doesn't let anything use setcurrent unless it has 
> >the set_curr_context attribute (assigned using the 
> >domain_dyntrans_type interface). You typically shouldn't be using 
> >setcurrent anyway, is there something specific you are trying to do?
> 
> We are trying to have a process change the MLS portion of its context 
> to match that of a socket connection.

Hi,

It would be preferable if you used an exec-based transition instead, as
noted in the setcon(3) man page:
"Note  that use of this function requires that the entire application be
trusted to maintain any desired separation  between  the  old  and  new
security contexts, unlike exec-based transitions performed via
setexeccon(3).  When possible, decompose your applicaiton and use
setexeccon() and execve() instead."

Could you use xinetd with its labeled networking support to launch your
application in the right level based on the client?  Then you don't need
to trust your application to maintain multi-level separation; that can
be ensured by the operating system's confinement of each process at its
level.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
