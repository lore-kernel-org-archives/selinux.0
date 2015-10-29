From: Paul Moore <pmoore@redhat.com>
To: Stephen Smalley <stephen.smalley@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-security-module@vger.kernel.org,
 linux-audit@redhat.com, selinux <selinux@tycho.nsa.gov>,
 Paul Osmialowski <p.osmialowsk@samsung.com>
Subject: Re: [RFC PATCH v3 2/5] lsm: introduce hooks for kdbus
Date: Thu, 29 Oct 2015 16:38:05 -0400
Message-ID: <5463583.QkGWquAsRk@sifl>
In-Reply-To: <CAB9W1A3+oEuKD4QQfogFvrEkRkKF0=y0j86ueQNnePf3P_K+qg@mail.gmail.com>
References: <20151007230615.7823.74519.stgit@localhost>
 <2112989.AEUouYpuBm@sifl>
 <CAB9W1A3+oEuKD4QQfogFvrEkRkKF0=y0j86ueQNnePf3P_K+qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, October 20, 2015 04:41:14 PM Stephen Smalley wrote:
> On Mon, Oct 19, 2015 at 6:29 PM, Paul Moore <pmoore@redhat.com> wrote:
> > On Friday, October 09, 2015 10:56:12 AM Stephen Smalley wrote:
> >> On 10/07/2015 07:08 PM, Paul Moore wrote:
> >> > diff --git a/ipc/kdbus/connection.c b/ipc/kdbus/connection.c
> >> > index ef63d65..1cb87b3 100644
> >> > --- a/ipc/kdbus/connection.c
> >> > +++ b/ipc/kdbus/connection.c
> >> > @@ -108,6 +109,14 @@ static struct kdbus_conn *kdbus_conn_new(struct
> >> > kdbus_ep *ep,>
> >> > 
> >> >     if (!owner && (creds || pids || seclabel))
> >> >     
> >> >             return ERR_PTR(-EPERM);
> >> > 
> >> > +   ret = security_kdbus_conn_new(get_cred(file->f_cred),
> >> 
> >> You only need to use get_cred() if saving a reference; otherwise, you'll
> >> leak one here.
> > 
> > Yes, that was a typo on my part, thanks.
> > 
> >> Also, do we want file->f_cred here or ep->bus->node.creds (the latter is
> >> what is used by their own checks; the former is typically the same as
> >> current cred IIUC).  For that matter, what about ep->node.creds vs
> >> ep->bus-
> >> node.creds vs. ep->bus->domain->node.creds?  Can they differ?  Do we
> >> care?
> > 
> > We don't want file->f_cred, per our previous discussions.  I was working
> > on this patchset in small chunks and while I added credential storing in
> > the nodes, I forgot to update the hooks before I hit send, my apologies.
> > 
> > My current thinking is to pass both the endpoint and bus credentials, as I
> > believe they can differ.  Both the bus and the endpoint inherit their
> > security labels from their creator and while I don't have any specifics,
> > I think it is reasonable to imagine those two processes having different
> > security labels. Assuming we pass both credentials down to the LSM, I'm
> > currently thinking of> 
> > the following SELinux access controls for this hook:
> >   allow <current> bus_t:kdbus { connect };
> >   allow <current> ep_t:kdbus { use privileged activator monitor policy };
> 
> I think it would be simpler to apply an associate check when the
> endpoint is created between the endpoint label and the bus label
> (which will typically be the same), and then only check based on
> endpoint label for all subsequent permission checks involving that
> endpoint.  Then you don't have to worry about which label to use for
> all the other permission checks. And you get finer-grained control -
> per-endpoint rather than only per-bus.

After thinking about this for a bit, I agree.

> > ... besides the additional label, I added the kdbus:use permission and
> > dropped the kdbus:owner permission.  Considering that the endpoint label,
> > ep_t, in the examples above, could be different from the current process,
> > it seemed reasonable to want to control that interaction and I felt the
> > fd:use permission was the closest existing control so I reused the
> > permission name. I decided to drop the "owner" permission as it really
> > wasn't the useful for anything anymore, it simply indicates that the
> > current task is the DAC owner of the endpoint.
> 
> Can you 'use' an endpoint in any way other than to connect via it?
> If not, I'd just call that connect (won't conflict if you get rid of
> the separate bus check above), or distinguish it via separate classes
> or as connectthrough vs connectto.

I don't believe so; my understanding is that the main point of endpoints is to 
define special kdbus DAC policy.
 
> conn->owner is used to determine whether the caller can fake
> credentials, skip kdbus policy checking, create an activator, monitor,
> or policy holder connection, etc.  Our options are:
>
> 1. Apply a SELinux check when it is set to see if the caller is
> allowed to own the bus based on MAC labels and policy, and if not,
> refuse to create the connection (that's what checking the owner
> permission was doing).
> 
> 2. Separately apply MAC checks over each of those abilities (fake
> creds, override policy, create an activator, monitor, or policy
> holder, etc) when there is an attempt to exercise them (not all during
> connection creation), and selectively deny that ability.  More
> invasive, more potential for breakage for applications that don't
> expect failure if they could create the connection in the first place.
> 
> 3. Treat faking of DAC credentials and skipping of kdbus policy
> checking as not of interest to MAC, leaving it only controlled by the
> existing uid match or CAP_IPC_OWNER check.  Simple, but seems to lose
> some of the potential benefit of using SELinux for confining processes
> using kdbus.

I agree with you on #3 so let's rule that out.  The same with #2 as I fear we 
would likely get a nasty surprise at some point when the kdbus folks changed 
something and forgot to update the LSM hooks.  That leaves us with option #1 
and the following operations:

* fake credentials
We are already checking this with the kdbus:impersonate permission.

* skip kdbus policy checks
Being an "owner" allows you to skip the kdbus DAC checks, but the operation 
should still be subject to the LSM hooks.  This really is an issue regardless 
of what we do with respect to checking ownership.

* create an activator
This is still passed as a flag into the security_kdbus_conn_new() hook.

* create a monitor
This is still passed as a flag into the security_kdbus_conn_new() hook.

* create a policy holder
This is still passed as a flag into the security_kdbus_conn_new() hook.

For the sake of completeness we can still keep passing it down via the LSM 
hook, I'm just not sure that adding it to the SELinux policy provides any real 
benefit.

> privileged actually seems less interesting than owner these days,
> although I haven't done a thorough analysis.

The only thing that it appears to offer is the ability to set the connection's 
creating user to a specified value.  From what I'm able to tell, this seems 
more relevant to the DAC side of things than the MAC side, although if we feel 
that "owner" is significant then privileged will remain important as well.

> IIUC, creating a monitor or policy holder connection has bus-wide
> implications and we ought to control it so we can limit it to specific
> processes, not just all uid-0 processes for the system bus and not
> just all uid-<user> processes for the per-user bus.

Agreed.  We still pass those flags to the LSM.

> I'm not actually clear on the implications of activator connections or why
> they are limited in the same way.

My understanding is that they serve as some sort of placeholder for kdbus 
services.  Regardless, we continue to pass the flag through the LSM hook.

> >> > @@ -1435,12 +1444,12 @@ bool kdbus_conn_policy_own_name(struct
> >> > kdbus_conn
> >> > *conn,>
> >> > 
> >> >                     return false;
> >> >     
> >> >     }
> >> > 
> >> > -   if (conn->owner)
> >> > -           return true;
> >> > +   if (!conn->owner &&
> >> > +       kdbus_policy_query(&conn->ep->bus->policy_db, conn_creds, name,
> >> > +                          hash) < KDBUS_POLICY_OWN)
> >> > +           return false;
> >> > 
> >> > -   res = kdbus_policy_query(&conn->ep->bus->policy_db, conn_creds,
> >> > -                            name, hash);
> >> > -   return res >= KDBUS_POLICY_OWN;
> >> > +   return (security_kdbus_own_name(conn_creds, name) == 0);
> >> 
> >> Similar question here.  conn_creds is the credentials of the creator of
> >> the connection, typically the client/sender, right?
> >> conn->ep->bus->node.creds are the credentials of the bus owner, so don't
> >> we want to ask "Can I own this name on this bus?".
> > 
> > Yes, I think so.
> > 
> > From a SELinux point of view I imagine we would want access controls along
> > the lines of the following:
> >   allow current name_t:kdbus { own_name };
> >   allow current bus_t:kdbus { own_name };
> > 
> > ... do we want to use different permissions?  I doubt it would matter much
> > either way.
> 
> If we keep them both, then they need separate classes or separate
> permissions; I can't think of another case where we reuse the same
> class and permission for two different objects.
> 
> Not clear that this kind of pairwise checking will work well.  For
> example, I should be able to own any name I like on my own bus, but
> not on the system bus.

If we care both about the service and the bus on which it lives, I think we 
need to somehow factor both into the SELinux bus/service name mapping. 

Perhaps we transition the service names based on the bus; for example, it is 
really on the system bus services that we are likely to care about having 
special/non-default names, isn't it?  Service names on a user bus could simply 
take on the same label as the process.

If we don't think the transitions are the right solution, then I think we'll 
need to add the bus information to the service name/label mapping.  Perhaps 
<bus_label>/<service_name> to <service_label>?  Although my current thinking 
is that the transitions are the way to go.

> >> > @@ -1491,19 +1499,19 @@ bool kdbus_conn_policy_see_name_unlocked(struct
> >> > kdbus_conn *conn,>
> >> > 
> >> >                                      const struct cred *conn_creds,
> >> >                                      const char *name)
> >> >   
> >> >   {
> >> > 
> >> > -   int res;
> >> > +   if (!conn_creds)
> >> > +           conn_creds = conn->cred;
> >> > 
> >> >     /*
> >> >     
> >> >      * By default, all names are visible on a bus. SEE policies can
> >> >      only be
> >> >      * installed on custom endpoints, where by default no name is
> >> >      visible.
> >> >      */
> >> > 
> >> > -   if (!conn->ep->user)
> >> > -           return true;
> >> > +   if (conn->ep->user &&
> >> > +       kdbus_policy_query_unlocked(&conn->ep->policy_db, conn_creds,
> >> > name,
> >> > +                                   kdbus_strhash(name)) <
> >> > KDBUS_POLICY_SEE) +           return false;
> >> > 
> >> > -   res = kdbus_policy_query_unlocked(&conn->ep->policy_db,
> >> > -                                     conn_creds ? : conn->cred,
> >> > -                                     name, kdbus_strhash(name));
> >> > -   return res >= KDBUS_POLICY_SEE;
> >> > +   return (security_kdbus_conn_see_name(conn_creds, name) == 0);
> >> 
> >> Here they only define policy based on endpoints, not bus.  Not sure what
> >> we want, but we need at least one of their creds.  Same for the rest.
> > 
> > Once again, I'm not sure we care about the underlying bus at this point,
> > do we?  We've already authorized both the service and the client to
> > connect to the bus, now I think all we care about is can the client see
> > the service name. Do we really care about the label of the bus here?
> 
> Well, here we again have the issue that we should be able to see all
> names on our own bus, but not necessarily on the system bus.

See my comment above, but I think we need to map both the bus and service name 
to a service label.

-- 
paul moore
security @ redhat
