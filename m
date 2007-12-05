Subject: Re: [PATCH 1/1] semanage_select_store fun
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        James Athey <jathey@tresys.com>
In-Reply-To: <1195667082.759.77.camel@moss-spartans.epoch.ncsc.mil>
References: <47435B32.9030205@manicmethod.com>
	 <1195651753.759.5.camel@moss-spartans.epoch.ncsc.mil>
	 <47446066.2030102@manicmethod.com>
	 <1195664448.759.63.camel@moss-spartans.epoch.ncsc.mil>
	 <1195667082.759.77.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 05 Dec 2007 12:50:36 -0500
Message-Id: <1196877036.16006.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-11-21 at 12:44 -0500, Stephen Smalley wrote:
> On Wed, 2007-11-21 at 12:00 -0500, Stephen Smalley wrote:
> > On Wed, 2007-11-21 at 11:44 -0500, Joshua Brindle wrote:
> > > Stephen Smalley wrote:
> > > > On Tue, 2007-11-20 at 17:09 -0500, Joshua Brindle wrote:
> > > >   
> > > >> So, I got a report here that python scripts that call 
> > > >> semanage_select_store will get a double free error when calling 
> > > >> semanage_handle_destroy because the swig wrapper free's the buffer 
> > > >> passed to semanage_select_store. I haven't seen this with semanage but 
> > > >> the bug does appear legitimate to me, we should have never been assuming 
> > > >> control of the buffer passed to semanage_select_store (especially 
> > > >> without documenting it).
> > > >>
> > > >> This is fun because semanage_select_store was originally a void but 
> > > >> clearly this needs to strdup() instead of just setting the pointer. This 
> > > >> patch can be applied trunk as it changes the API but the bug would still 
> > > >> exist in stable (and the person who reported this will unfortunately 
> > > >> have to patch it in their release of the stable repo).
> > > >>     
> > > >
> > > > Wait - we aren't changing API/ABI even in trunk at present, and to do
> > > > so, we'd either need to change .so version (incompatible change) or use
> > > > the per-symbol versioning technique to keep the old interface alive for
> > > > existing binaries while defaulting to the new interface for newer code.
> > > >
> > > > I also have to ask - if the problem lies in the swig wrapper, why not
> > > > fix it there?
> > > >
> > > >   
> > > 
> > > Because I'm scared of the swig wrapper :)
> > 
> > Well, we shouldn't be more afraid of changing the python bindings that
> > we are of changing the library API and ABI.
> 
> Ok, so maybe there is no way to fix this in the wrapper, as the wrapper
> has to create a temporary C string from the python string and then free
> it when done with the call.  Which would mean that we need to strdup all
> strings passed into the library.
> 
> > > But seriously we always strdup (afaik) strings passed in to libsemanage 
> > > so this is an inconsistency and should at least be documented.
> > 
> > The key create functions don't appear to do so, e.g.
> > semanage_seuser_key_create.  Don't know how widespread the issue is.
> > Why does semanage appear to work ok?
> 
> Hmm...well semanage -S/--store doesn't appear to work at all right now,
> not sure why.  As far as keys go, they are different in that we don't
> free the names in the key_free functions, so no double free there, but
> it still appears that they would be prematurely freed by the wrapper
> while still in use by the library.  Not sure then why we don't have lots
> of bug reports on semanage.
>  
> > > I suppose we can just start queuing up any api/abi changes for some 
> > > future so version, this certainly doesn't warrant bumping the version.
> > 
> > It could be done via per-symbol versioning rather than a .so version
> > change.
> > 
> > > OTOH I understand that we need a stable ABI in trunk but honestly I 
> > > don't know how this change would cause problems (how many external users 
> > > are there, how often is this error condition going to occur (esp 
> > > compared to how often the error condition it is fixing can occur), etc).
> > 
> > If we do need to make the change, then I think we want to systematically
> > fix all such occurrences at once, and do it cleanly via per-symbol
> > versioning or .so version bump.  Which suggests doing it in policyrep
> > first.  But if we can make a change to the swig wrapper instead to fix
> > the bug, then that would be nice for stable and for a short term fix for
> > trunk.
> 
> Let's do it this way then:
> - change the functions to strdup() internally always.  If the function
> presently returns void and the strdup fails, then abort().  If the
> function presently returns int, then return an error of course.  We can
> apply that change on the current trunk and stable.

Just merged a patch from Dan on trunk that does the above (except I used
assert rather than abort since we already use assert in places there)
for the select_store function.  But I assume we need this in every place
that libsemanage takes ownership of a pointer provided by the caller
rather than dup'ing it?

> - plan to change those void functions to return int, and queue that up
> in policyrep.  But that can come later.  Then we can turn those aborts
> into returns.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
