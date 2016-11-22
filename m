From: Steve Grubb <sgrubb@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul@paul-moore.com>, linux-audit@redhat.com,
 selinux@tycho.nsa.gov
Subject: Re: [PATCH] Fix AUDIT_MAC_POLICY_LOAD event formatting
Date: Tue, 22 Nov 2016 14:39:52 -0500
Message-ID: <1654303.4jsK0rGDo5@x2>
In-Reply-To: <1be21bc4-e70f-092f-13cb-458cc0beefad@tycho.nsa.gov>
References: <11128714.mipGzmS50p@x2> <67267460.FCN7LuPZon@x2>
 <1be21bc4-e70f-092f-13cb-458cc0beefad@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, November 22, 2016 9:55:11 AM EST Stephen Smalley wrote:
> On 11/22/2016 09:28 AM, Steve Grubb wrote:
> > On Tuesday, November 22, 2016 8:56:57 AM EST Stephen Smalley wrote:
> >> On 11/21/2016 04:50 PM, Paul Moore wrote:
> >>> On Mon, Nov 21, 2016 at 12:30 PM, Steve Grubb <sgrubb@redhat.com> wrote:
> >>>> The AUDIT_MAC_POLICY_LOAD event has dangling text that means the same
> >>>> thing as the event type and is missing the uid and results field. The
> >>>> bigger issue is that in some failure cases no event is emitted. This
> >>>> patch fixes the noted problems.
> >> 
> >> A potential problem with this patch is that it changes the semantic
> >> meaning of this audit record, from meaning "a policy was loaded into the
> >> kernel" to "there was an attempt to load a policy, check the res= field
> >> to determine whether it succeeded".  So anything in userspace that used
> >> the presence of this audit record to determine whether or not policy was
> >> successfully loaded (e.g. audit2allow -l) will be confused.
> > 
> > I really can't have implicit success. I need to have a field to point to
> > that says yes/no. It can be hard coded to res=1 (success), but it needs
> > to be there.
> 
> Ok.  Why is it you use res=1|0 in these records but success=yes|no in
> syscall records?

Success is only used in syscall records. It was created to disambiguate the 
exit field which can look like a failure on some arches but is actually OK. 
Originally the exit field was all that existed. We found that one or two arches 
actually have 2 return codes. The whole rest of the audit system uses res= to 
mean a crisp yes/no this did or didn't happen. This predates the creation of 
the success field. It could be argued success should have been res, but 
ausearch/report will use either to mean the same thing.

The new auparse field classifier work will also map both to mean the same thing. 
That is how I found AUDIT_MAC_POLICY_LOAD missing any kind of success/fail 
indication.


> >> While there were failure cases that would still generate the audit record
> >> previously, those were all selinuxfs node creation failures; the policy
> >> would nonetheless have been loaded into the kernel and would be active
> >> at that point, so saying res=0 is somewhat misleading.
> > 
> > OK. We can move the point where res=1 is set. But I would think that its a
> > requirement to have an audit record that states that policy failed to
> > load.
> > FMT_MSA.3 Static Attribute Initialization. Auditable events: All
> > modifications of the initial value of security attributes. I would think
> > this means changes such as booleans, modifying labels, loading a new
> > policy, or failure to load a policy.
> 
> Failure to load a policy is not a modification to the initial value of
> the security attribute, is it?

Sure. If the state is intended to enabled and enforcing and its not, that 
would be a surprising result that there was no indication in the audit trail. 
Also, if for some reason it booted fine and a new policy was loaded at some 
point in the future and it failed, then we have a modification to initial 
state.

> >> This overlapswith
> >> https://github.com/SELinuxProject/selinux-kernel/issues/1, which
> >> highlights the fact that we can end up in an intermediate state where
> >> policy is loaded but selinuxfs (particularly booleans, class/*, and
> >> policy_capabilities/*) has not been regenerated.
> > 
> > I see. That should be an audited event. If you have a datacenter with a
> > thousand machines, its best to get this in the audit trail so it can be
> > alerted on at a central collector.
> > 
> > So, what should we do about the patch? I'm willing to modify it.
> 
> At present, we only generate AUDIT_MAC_STATUS, AUDIT_MAC_LOAD, and
> AUDIT_MAC_CONFIG_CHANGE on success (or at least partial success).  If
> you truly need to audit failures, then it seems like you either need to
> a) do it through syscall audit filters, which already provide a success=
> field

I can't imagine what to audit on. There is an open syscall that has a path. 
But I suspect that does not fail because policy has not be written. There is a 
write syscall but triggering on that is pretty generic. This is not ideal.

> or b) add new audit message types for this purpose (e.g.
> AUDIT_MAC_STATUS_FAIL, AUDIT_MAC_LOAD_FAIL, ...).  To just add a res=
> field to the existing ones and change them to always be generated is a
> user-visible semantic change.

OK. This is do-able. I'll hard code the 'res' field for each of them.

-Steve
