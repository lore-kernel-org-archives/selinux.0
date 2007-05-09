Subject: Re: policyrep questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1178663380.2379.11.camel@localhost.localdomain>
References: <1178663380.2379.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 09 May 2007 11:29:15 -0400
Message-Id: <1178724555.16433.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-08 at 18:29 -0400, Karl MacMillan wrote:
> I have a few questions as I continue to do the policyrep patches.
> 
> 1) The free functions for the objects may need to return an error (which
> I hate, but there is no good way to avoid this). This will break
> compatibility with the existing string based sepol objects (like
> sepol_bool). Any problems breaking this compatibility?

Not a problem (.so version has already changed in -policyrep and we have
already made other incompatible changes).

OTOH, what could/would a caller do if a free function failed?  At that
point, it will leak memory unless it aborts altogether, right?  So
possibly we gain nothing from returning an error status to the caller?
What do other libraries do under similar conditions?  Or do they avoid
it through different data structure and API design?

> 2) The general form of the free functions will be:
> 
> int sepol_object_free(struct sepol_handle *h, struct sepol_object *o);
> 
> Is the handle necessary? The general form is to pass a handle wherever
> an error is possible, but it seems like overkill in this case.

Only if you plan to generate an error message from within the function.

> 3) The existing objects copy the passed in strings where I was hoping to
> avoid the copy. Any opinions either way? I'm currently leaning towards
> copying because that kind of change will create hard to track down bugs
> for no good reason.

Yes, I think copying the data and managing its lifecycle within the
library is safer.

> 4) We assume NULL-terminated strings all over the place - should we be
> providing apis with length? Alternatively, should we provide a better
> string object (since we are currently re-inventing the wheel, why not?).
> We could pull in something like James Antills Vstr library -
> http://www.and.org/vstr/ (read and be amazed at the diligence of James).
> It just seems crazy that our apis are not the safest.

I'm not clear that tracking length separately is advantageous for these
APIs.  What specific advantages would accrue to libsepol from using
vstr?  What is the cost (incl. dependencies)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
