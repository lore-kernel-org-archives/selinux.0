MIME-Version: 1.0
In-Reply-To: <2112989.AEUouYpuBm@sifl>
References: <20151007230615.7823.74519.stgit@localhost>
 <20151007230829.7823.14385.stgit@localhost>
 <5617D58C.2070402@tycho.nsa.gov> <2112989.AEUouYpuBm@sifl>
Date: Tue, 20 Oct 2015 16:41:14 -0400
Message-ID: <CAB9W1A3+oEuKD4QQfogFvrEkRkKF0=y0j86ueQNnePf3P_K+qg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/5] lsm: introduce hooks for kdbus
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Paul Moore <pmoore@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-security-module@vger.kernel.org,
 linux-audit@redhat.com, selinux <selinux@tycho.nsa.gov>,
 Paul Osmialowski <p.osmialowsk@samsung.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Oct 19, 2015 at 6:29 PM, Paul Moore <pmoore@redhat.com> wrote:
> On Friday, October 09, 2015 10:56:12 AM Stephen Smalley wrote:
>> On 10/07/2015 07:08 PM, Paul Moore wrote:
>> > diff --git a/ipc/kdbus/connection.c b/ipc/kdbus/connection.c
>> > index ef63d65..1cb87b3 100644
>> > --- a/ipc/kdbus/connection.c
>> > +++ b/ipc/kdbus/connection.c
>> > @@ -108,6 +109,14 @@ static struct kdbus_conn *kdbus_conn_new(struct
>> > kdbus_ep *ep,>
>> >     if (!owner && (creds || pids || seclabel))
>> >
>> >             return ERR_PTR(-EPERM);
>> >
>> > +   ret = security_kdbus_conn_new(get_cred(file->f_cred),
>>
>> You only need to use get_cred() if saving a reference; otherwise, you'll
>> leak one here.
>
> Yes, that was a typo on my part, thanks.
>
>> Also, do we want file->f_cred here or ep->bus->node.creds (the latter is
>> what is used by their own checks; the former is typically the same as
>> current cred IIUC).  For that matter, what about ep->node.creds vs ep->bus-
>> node.creds vs. ep->bus->domain->node.creds?  Can they differ?  Do we care?
>
> We don't want file->f_cred, per our previous discussions.  I was working on
> this patchset in small chunks and while I added credential storing in the
> nodes, I forgot to update the hooks before I hit send, my apologies.
>
> My current thinking is to pass both the endpoint and bus credentials, as I
> believe they can differ.  Both the bus and the endpoint inherit their security
> labels from their creator and while I don't have any specifics, I think it is
> reasonable to imagine those two processes having different security labels.
> Assuming we pass both credentials down to the LSM, I'm currently thinking of
> the following SELinux access controls for this hook:
>
>   allow <current> bus_t:kdbus { connect };
>   allow <current> ep_t:kdbus { use privileged activator monitor policy };

I think it would be simpler to apply an associate check when the
endpoint is created between the endpoint label and the bus label
(which will typically be the same), and then only check based on
endpoint label for all subsequent permission checks involving that
endpoint.  Then you don't have to worry about which label to use for
all the other permission checks. And you get finer-grained control -
per-endpoint rather than only per-bus.  In the common case, the labels
will be the same and it won't matter, but if you want to support some
MAC form of their 'custom endpoints' with further restrictions, you
can do that by labeling the endpoints uniquely and using those labels
in your permission checks.

Otherwise, I have to ask whether you need two different classes above
(bus vs endpoint), and whether the privileged/activator/monitor/policy
permissions properly belong with the endpoint label or the bus label.
At least some of those are bus-wide properties, not endpoint-specific,
but that's ok as long as we have established a relationship between
the endpoint label and bus label.

> ... besides the additional label, I added the kdbus:use permission and dropped
> the kdbus:owner permission.  Considering that the endpoint label, ep_t, in the
> examples above, could be different from the current process, it seemed
> reasonable to want to control that interaction and I felt the fd:use
> permission was the closest existing control so I reused the permission name.
> I decided to drop the "owner" permission as it really wasn't the useful for
> anything anymore, it simply indicates that the current task is the DAC owner
> of the endpoint.

Can you 'use' an endpoint in any way other than to connect via it?
If not, I'd just call that connect (won't conflict if you get rid of
the separate bus check above), or distinguish it via separate classes
or as connectthrough vs connectto.

conn->owner is used to determine whether the caller can fake
credentials, skip kdbus policy checking, create an activator, monitor,
or policy holder connection, etc.  Our options are:
1. Apply a SELinux check when it is set to see if the caller is
allowed to own the bus based on MAC labels and policy, and if not,
refuse to create the connection (that's what checking the owner
permission was doing).

2. Separately apply MAC checks over each of those abilities (fake
creds, override policy, create an activator, monitor, or policy
holder, etc) when there is an attempt to exercise them (not all during
connection creation), and selectively deny that ability.  More
invasive, more potential for breakage for applications that don't
expect failure if they could create the connection in the first place.

3. Treat faking of DAC credentials and skipping of kdbus policy
checking as not of interest to MAC, leaving it only controlled by the
existing uid match or CAP_IPC_OWNER check.  Simple, but seems to lose
some of the potential benefit of using SELinux for confining processes
using kdbus.

privileged actually seems less interesting than owner these days,
although I haven't done a thorough analysis.

IIUC, creating a monitor or policy holder connection has bus-wide
implications and we ought to control it so we can limit it to specific
processes, not just all uid-0 processes for the system bus and not
just all uid-<user> processes for the per-user bus.  I'm not actually
clear on the implications of activator connections or why they are
limited in the same way.

>
>> > @@ -1435,12 +1444,12 @@ bool kdbus_conn_policy_own_name(struct kdbus_conn
>> > *conn,>
>> >                     return false;
>> >
>> >     }
>> >
>> > -   if (conn->owner)
>> > -           return true;
>> > +   if (!conn->owner &&
>> > +       kdbus_policy_query(&conn->ep->bus->policy_db, conn_creds, name,
>> > +                          hash) < KDBUS_POLICY_OWN)
>> > +           return false;
>> >
>> > -   res = kdbus_policy_query(&conn->ep->bus->policy_db, conn_creds,
>> > -                            name, hash);
>> > -   return res >= KDBUS_POLICY_OWN;
>> > +   return (security_kdbus_own_name(conn_creds, name) == 0);
>>
>> Similar question here.  conn_creds is the credentials of the creator of
>> the connection, typically the client/sender, right?
>> conn->ep->bus->node.creds are the credentials of the bus owner, so don't
>> we want to ask "Can I own this name on this bus?".
>
> Yes, I think so.
>
> From a SELinux point of view I imagine we would want access controls along the
> lines of the following:
>
>   allow current name_t:kdbus { own_name };
>   allow current bus_t:kdbus { own_name };
>
> ... do we want to use different permissions?  I doubt it would matter much
> either way.

If we keep them both, then they need separate classes or separate
permissions; I can't think of another case where we reuse the same
class and permission for two different objects.

Not clear that this kind of pairwise checking will work well.  For
example, I should be able to own any name I like on my own bus, but
not on the system bus.

>> Note that their policy checks are based on conn->ep->policy_db, i.e. the
>> policy associated with the endpoint, and conn->owner is only true if the
>> connection creator has the same uid as the bus.
>
> I don't think this is significant for us.
>
>> > @@ -1465,14 +1474,13 @@ bool kdbus_conn_policy_talk(struct kdbus_conn
>> > *conn,>
>> >                                      to, KDBUS_POLICY_TALK))
>> >
>> >             return false;
>> >
>> > -   if (conn->owner)
>> > -           return true;
>> > -   if (uid_eq(conn_creds->euid, to->cred->uid))
>> > -           return true;
>> > +   if (!conn->owner && !uid_eq(conn_creds->euid, to->cred->uid) &&
>> > +       !kdbus_conn_policy_query_all(conn, conn_creds,
>> > +                                    &conn->ep->bus->policy_db, to,
>> > +                                    KDBUS_POLICY_TALK))
>> > +           return false;
>> >
>> > -   return kdbus_conn_policy_query_all(conn, conn_creds,
>> > -                                      &conn->ep->bus->policy_db, to,
>> > -                                      KDBUS_POLICY_TALK);
>> > +   return (security_kdbus_conn_talk(conn_creds, to->cred) == 0);
>>
>> Here at least we have a notion of client and peer.  But we still aren't
>> considering conn->ep or conn->ep->bus, whereas they are querying both
>> policy dbs for their decision.  The parallel would be checking access to
>> the labels of both I suppose, unless we institute a control up front
>> over the relationship between the label of the endpoint and the label of
>> the bus.
>
> While accidental, as I forgot to update this patch as mentioned previously, I
> think the differences between kdbus DAC and kdbus MAC is okay.  At this point
> we've already authorized the individual nodes to connect to the bus and now we
> are authorizing them to talk to each other; at this control point, it is the
> interaction between the two nodes that we care about, I don't think we care
> about what bus they use, do we?

Perhaps not.

>
>> > @@ -1491,19 +1499,19 @@ bool kdbus_conn_policy_see_name_unlocked(struct
>> > kdbus_conn *conn,>
>> >                                      const struct cred *conn_creds,
>> >                                      const char *name)
>> >
>> >   {
>> >
>> > -   int res;
>> > +   if (!conn_creds)
>> > +           conn_creds = conn->cred;
>> >
>> >     /*
>> >
>> >      * By default, all names are visible on a bus. SEE policies can only be
>> >      * installed on custom endpoints, where by default no name is visible.
>> >      */
>> >
>> > -   if (!conn->ep->user)
>> > -           return true;
>> > +   if (conn->ep->user &&
>> > +       kdbus_policy_query_unlocked(&conn->ep->policy_db, conn_creds, name,
>> > +                                   kdbus_strhash(name)) < KDBUS_POLICY_SEE)
>> > +           return false;
>> >
>> > -   res = kdbus_policy_query_unlocked(&conn->ep->policy_db,
>> > -                                     conn_creds ? : conn->cred,
>> > -                                     name, kdbus_strhash(name));
>> > -   return res >= KDBUS_POLICY_SEE;
>> > +   return (security_kdbus_conn_see_name(conn_creds, name) == 0);
>>
>> Here they only define policy based on endpoints, not bus.  Not sure what
>> we want, but we need at least one of their creds.  Same for the rest.
>
> Once again, I'm not sure we care about the underlying bus at this point, do
> we?  We've already authorized both the service and the client to connect to
> the bus, now I think all we care about is can the client see the service name.
> Do we really care about the label of the bus here?

Well, here we again have the issue that we should be able to see all
names on our own bus, but not necessarily on the system bus.
