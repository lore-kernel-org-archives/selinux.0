Subject: Re: Policy database
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Stefano Carucci <stecarucci@hotmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <SNT115-W60065DFB4C91354C52FD4FC11B0@phx.gbl>
References: <SNT115-W60065DFB4C91354C52FD4FC11B0@phx.gbl>
Content-Type: text/plain
Date: Wed, 22 Jul 2009 14:13:41 -0400
Message-Id: <1248286421.28321.486.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-07-22 at 10:13 +0000, Stefano Carucci wrote:
> Hello all!
>  
> I would like to ask you experts some details about how the policy is managed (stored and retrieved) by the security server. 
> If you can recommend some documentation where these topics are addressed in details I would be very grateful. 
> 
> These are the ideas I (haven't) got while looking through the code.
> If the needed policy rule is not present in the AVC, then it has to be retrieved by... the Access Vector Table (ss/avtab.h/c), right?
> The avtab is a "simple" hash-table, where all rules are stored and searched through the key {ssid,tsid,obj_class} for the access vector. Is it correct? 
> What I expected was something faster to search... like a database...
> On the other side, the policy should be stored in a binary policy file. So how is the set of rules retrieved from this binary file?
> I also read about a policy database, that, as far as I understood is meant for configuration parameters only. It doesn't work as a rules repository, right?
> 
> I would be very thankful guys if you can help me understand this mechanism.

If the decision is not present in the AVC, then the
security_compute_av() function (which may be renamed soon to
sel_compute_av) of the security server is called.
Internally, this searches the base avtab and the conditional avtab for
matching entries to determine the initial access vectors from the TE
policy and then potentially further prunes permissions from the allowed
vector based on constraints and role allow rules. Originally it would
only perform a single lookup of the base avtab, as each entry was
unique, but this changed when we pushed type attributes down into the
kernel policy for memory savings. 

The avtab is part of the policydb.

The entire policy is loaded by having userspace write it to the pseudo
file /selinux/load, which gets handled within the kernel by
sel_write_load() and ultimately by security_load_policy() (which may be
renamed soon to sel_load_policy).

The original implementation was described in:
http://www.nsa.gov/research/_files/selinux/papers/slinux/node11.shtml

I think there might be some discussion of the logic in the SELinux by
Example book, but I'm not sure how detailed it is and naturally it
wouldn't include subsequent changes.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
