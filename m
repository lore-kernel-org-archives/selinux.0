Message-ID: <43317A06.7080208@cornell.edu>
Date: Wed, 21 Sep 2005 11:19:34 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] Fix record handlers, add status codes
References: <432FCF8F.8070909@cornell.edu>  <432FD4D1.5000604@cornell.edu> <1127313768.2550.29.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1127313768.2550.29.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Thanks, merged.
>
>What do you view as still undecided for the debug system?
>  
>
I need to determine what's necessary for me to introduce error reporting 
in future semanage code. In particular:

- I need to pass down the semanage handle (which does not exist yet) 
down for state. That's pending Joshua's patch.
- I need to decide whether to use write_error, or DEBUG, and put the 
appropriate debug system in debug.h
- If (write_error) -> needs to be modified to support multiple error 
messages
- If (DEBUG) -> needs to be modified to support state, and provide a 
buffering callback
- Independently, I still might need to reduce the number and placement 
of error messages to make the error message more suitable for the end user.

Basically, error messages a constant PITA, that I'd rather ignore for 
the moment, partly because of the lack of handle object. There's more 
important things to take care of... such as the justification for adding 
a database-like engine in the first place. I think this will be easier 
to justify once I add an avrule record, to allow policy rules to be 
parsed and loaded into policy (only avtab rules, no booleans, and no 
m4). This will also need some code moved (at least duplicated for now... 
) from checkpolicy into sepol. The idea of this engine thing is to allow 
handling of any text file that looks like a collection of records in a 
consistent manner, with 90% of all code being shared (everything minus 
the parsing of a single record). It should be trivial to add new 
structured files, and write arbitrary handlers in C, otherwise the 
objective is not accomplished.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
