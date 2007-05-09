Subject: Re: policyrep questions
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1178724555.16433.19.camel@moss-spartans.epoch.ncsc.mil>
References: <1178663380.2379.11.camel@localhost.localdomain>
	 <1178724555.16433.19.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 09 May 2007 11:51:00 -0400
Message-Id: <1178725860.19377.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-09 at 11:29 -0400, Stephen Smalley wrote:
> On Tue, 2007-05-08 at 18:29 -0400, Karl MacMillan wrote:
> > I have a few questions as I continue to do the policyrep patches.
> > 
> > 1) The free functions for the objects may need to return an error (which
> > I hate, but there is no good way to avoid this). This will break
> > compatibility with the existing string based sepol objects (like
> > sepol_bool). Any problems breaking this compatibility?
> 
> Not a problem (.so version has already changed in -policyrep and we have
> already made other incompatible changes).
> 
> OTOH, what could/would a caller do if a free function failed?

It's not clear - it will be _very_ hard to guarantee that the data
structures are in some sort of semi-valid state so that the free
function could be called again.

>   At that
> point, it will leak memory unless it aborts altogether, right?  So
> possibly we gain nothing from returning an error status to the caller?

Basically - the worst case is a leak. And bear in mind, this is a
failure case caused by the inability to allocate a couple of bytes.
Chances are we are about to hit many other unrecoverable errors.

To make this worse - there are several cases where I ignore failures in
free functions. In error paths that free an object I usually want to
return the original error and not the error on free - so I ignore the
return from the free functions.

> What do other libraries do under similar conditions?  Or do they avoid
> it through different data structure and API design?
> 

No idea. It is hard to fully encapsulate all structs and avoid this
issue I think. Even if I made it so that the library could internally
put all of the structs on the stack users of the library would be faced
with exactly the same set of issues.

I vote to suppress all of these free errors (which don't occur often -
most of these functions have error returns just for the consistency that
is needed for the object system).

> 
> > 4) We assume NULL-terminated strings all over the place - should we be
> > providing apis with length? Alternatively, should we provide a better
> > string object (since we are currently re-inventing the wheel, why not?).
> > We could pull in something like James Antills Vstr library -
> > http://www.and.org/vstr/ (read and be amazed at the diligence of James).
> > It just seems crazy that our apis are not the safest.
> 
> I'm not clear that tracking length separately is advantageous for these
> APIs.

It might be more efficient in many cases. Obviously we can't protect
against malicious callers, but forcing people to pass length makes them
aware of the issues I think.

>   What specific advantages would accrue to libsepol from using
> vstr?

We are going to start wanting to build up some complex strings as part
of the policyrep work. That kind of concatenation is painful with the C
string APIS (and inefficient). Vstr is also designed to be easy /
efficient to use to push strings across the network.

>   What is the cost (incl. dependencies)?
> 

I don't think there are any deps. It's not in fedora yet, but it will be
soon.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
