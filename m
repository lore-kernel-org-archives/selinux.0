Subject: Re: [ RESEND ] [ SEMANAGE ] Debugging system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <434D35B1.7060409@cornell.edu>
References: <434CC592.70001@cornell.edu>
	 <1129132332.3308.288.camel@moss-spartans.epoch.ncsc.mil>
	 <434D35B1.7060409@cornell.edu>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 12:04:40 -0400
Message-Id: <1129133080.3308.294.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-12 at 12:11 -0400, Ivan Gyurdiev wrote:
> It looks more complicated now.... and more disorganized.
> I guess it's fine, as long as it's easy to use.

Ok, from my POV, it is nicer, because:
a) No extraneous abstractions introduced, just using the handle as
designed,
b) Direct pass through to the callback with no internal buffering and no
new failure cases (memory allocation) introduced.

> The newline is part of the message - it's not a good idea to push it 
> into the messaging system. Eventually we will run into a case where we 
> don't want a newline printed, and the messaging system wouldn't be able 
> to handle that....happens every time I try to do this.

Hmm...I was thinking that the callback could add it as desired.  Each
invocation of the callback constitutes a separate message, and the
callback is free to introduce message separators as desired.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
