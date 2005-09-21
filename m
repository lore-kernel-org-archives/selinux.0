Subject: Re: [ SEMANAGE ] Fix record handlers, add status codes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <43317A06.7080208@cornell.edu>
References: <432FCF8F.8070909@cornell.edu>  <432FD4D1.5000604@cornell.edu>
	 <1127313768.2550.29.camel@moss-spartans.epoch.ncsc.mil>
	 <43317A06.7080208@cornell.edu>
Content-Type: text/plain
Date: Wed, 21 Sep 2005 11:36:39 -0400
Message-Id: <1127316999.2550.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-21 at 11:19 -0400, Ivan Gyurdiev wrote:
> I need to determine what's necessary for me to introduce error reporting 
> in future semanage code. In particular:
> 
> - I need to pass down the semanage handle (which does not exist yet) 
> down for state. That's pending Joshua's patch.

Or you could just drop in a stub for now, and he can fill it in later.

> - I need to decide whether to use write_error, or DEBUG, and put the 
> appropriate debug system in debug.h

The earlier thread seemed to be going toward the latter, with the
modifications you mentioned below.

> - If (DEBUG) -> needs to be modified to support state, and provide a 
> buffering callback

Right, caller-supplied state object and level/priority value.  Callback
can implement buffering as desired.

> - Independently, I still might need to reduce the number and placement 
> of error messages to make the error message more suitable for the end user.

Right, try to get to the point where the call chain DEBUG calls can be
purely debug level/priority info and can be discarded for error
reporting to the user/client.

> Basically, error messages a constant PITA, that I'd rather ignore for 
> the moment, partly because of the lack of handle object. There's more 
> important things to take care of... such as the justification for adding 
> a database-like engine in the first place. I think this will be easier 
> to justify once I add an avrule record, to allow policy rules to be 
> parsed and loaded into policy (only avtab rules, no booleans, and no 
> m4). This will also need some code moved (at least duplicated for now... 
> ) from checkpolicy into sepol. The idea of this engine thing is to allow 
> handling of any text file that looks like a collection of records in a 
> consistent manner, with 90% of all code being shared (everything minus 
> the parsing of a single record). It should be trivial to add new 
> structured files, and write arbitrary handlers in C, otherwise the 
> objective is not accomplished.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
