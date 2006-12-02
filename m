Message-ID: <4570F4A4.40001@tresys.com>
Date: Fri, 01 Dec 2006 22:36:04 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: ewalsh@tycho.nsa.gov
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        kaigai@kaigai.gr.jp
Subject: Re: [PATCH 0/5] libselinux: labeling API for userspace object	managers
 (try 2)
References: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil>	 <456F976D.9020905@tresys.com>  <457060BB.5090305@mentalrootkit.com> <1165008252.2794.309.camel@moss-huskies.epoch.ncsc.mil>
In-Reply-To: <1165008252.2794.309.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> On Fri, 2006-12-01 at 12:04 -0500, Karl MacMillan wrote:
>> Joshua Brindle wrote:
>>> If we go forward with this do we really expect every object manager that 
>>> has context matching more complicated than exact matches to upstream 
>>> changes to libselinux? This doesn't seem to scale well.. Policy server 
>>> would need a backend, do you know if dbus and X would need new backends? 
>>> I still don't think this is the right approach, LDAP and rdbms's, for 
>>> example, would likely have their initial contexts in the schema.
> 
> Exact string matching with a default fallback match meets the needs of
> both dbus and X in their current forms.  However I've said that I
> support adding regex matching to the generic backend as well.  I really
> think that this will satisfy the requirements in most cases.  The only
> major holdup I can think of is where there might be an arbitrary number
> of keys involved (see database discussion below).
> 

unfortunately policy server couldn't even use regex, it uses a special 
labeling scheme that determines specificity based on the type hierarchy 
(dots). I'm not saying that a single object manager justifies ditching 
this but I keep coming back to the fact that object managers own their 
labels, period. It is up to them how they want to store, manage, etc them.

>> I agree that this would be problematic - very specific libselinux 
>> dependencies are going to be a nightmare for distributions. Seems like 
>> it should be possible to have a callback style api that would allow 
>> sufficient customization for almost all object managers.
> 
> I will try to work in such callbacks on the next go-round.  Thanks for
> the suggestion.
> 

I agree that callbacks are better, I still disagree with the notion that 
  this is the correct route.

>>> I can think of few object managers that this scheme works with. Things 
>>> like groupware apps, chat servers, mail servers, etc are going to have 
>>> labeling done at runtime (based on who creates an object or where it 
>>> comes from), 
> 
> security_compute_create() can be used to do the labeling in the case
> where you have a related object.  The proposed interface is _only_ for
> the case where security_compute_create() is not sufficient because
> additional meaning is vested in some string name, path, key, etc.
> 

Yes, security_compute_create() would be used, but the labels would be 
stored in the object manager somewhere (on disk db, memory, etc).

>> databases will certainly store contexts in their schema, etc. 
> 
> What if you change policies and your database needs to be relabeled?
> What if you are importing bulk data?  It's just like the filesystem,
> there will have to be a "setfiles" equivalent built into the DBMS, and
> for each row, some mapping from the column contents to the security
> context for that row.
> 

This is tricky, setfiles is generally used to relabel system files, 
running it on user files is not suggested because of customizations 
made, etc (and in fact we have labeling exceptions for custom labels 
anyway). Running an equivalent on a database would result in a major 
loss of state (who created what, what levels rows are, etc). I think 
databases are going to need something more sophisticated than blind 
relabeling via an initial contexts file.

> This brings up the point that perhaps lookups should support more than
> one key, and perhaps numeric keys as well as string keys.  KaiGai, do
> you have any input based on the Postgres work?
>  
> 

what would supporting more than one key help?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
