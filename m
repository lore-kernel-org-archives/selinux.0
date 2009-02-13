Subject: Re: [PATCH 2/2] SELinux: check seqno when updating an avc_node
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com
In-Reply-To: <1234534030.24702.17.camel@localhost.localdomain>
References: <20090212195005.25556.94754.stgit@paris.rdu.redhat.com>
	 <20090212195010.25556.87832.stgit@paris.rdu.redhat.com>
	 <1234534030.24702.17.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Feb 2009 10:06:18 -0500
Message-Id: <1234537578.31408.27.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-02-13 at 09:07 -0500, Stephen Smalley wrote:
> On Thu, 2009-02-12 at 14:50 -0500, Eric Paris wrote:
> > The avc update node callbacks do not check the seqno of the caller with the
> > seqno of the node found.  It is possible that a policy change could happen
> > (although almost impossibly unlikely) in which a permissive or
> > permissive_domain decision is not valid for the entry found.  Simply pass
> > and check that the seqno of the caller and the seqno of the node found
> > match.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> Changing enforcing/permissive mode doesn't change the seqno.
> Also, the "caller" seqno in this case (p_ae->avd.seqno) is just the
> policy seqno at the time the AVC entry was created, which may or may not
> be the latest seqno.  And we don't actually know what the seqno for the
> security_permissive_sid() call.  So I don't think this yields any
> improvement.
> 
> NAK.
> 
> > ---
> > 
> >  security/selinux/avc.c |    9 ++++++---
> >  1 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index e5cda02..703aba1 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -747,13 +747,15 @@ static inline int avc_sidcmp(u32 x, u32 y)
> >   * @event : Updating event
> >   * @perms : Permission mask bits
> >   * @ssid,@tsid,@tclass : identifier of an AVC entry
> > + * @seqno : sequence number when decision was made
> >   *
> >   * if a valid AVC entry doesn't exist,this function returns -ENOENT.
> >   * if kmalloc() called internal returns NULL, this function returns -ENOMEM.
> >   * otherwise, this function update the AVC entry. The original AVC-entry object
> >   * will release later by RCU.
> >   */
> > -static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass)
> > +static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass,
> > +			   u32 seqno)
> >  {
> >  	int hvalue, rc = 0;
> >  	unsigned long flag;
> > @@ -772,7 +774,8 @@ static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass)
> >  	list_for_each_entry(pos, &avc_cache.slots[hvalue], list) {
> >  		if (ssid == pos->ae.ssid &&
> >  		    tsid == pos->ae.tsid &&
> > -		    tclass == pos->ae.tclass){
> > +		    tclass == pos->ae.tclass &&
> > +		    seqno == pos->ae.avd.seqno){
> >  			orig = pos;
> >  			break;
> >  		}
> > @@ -913,7 +916,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
> >  			rc = -EACCES;
> >  		else if (!selinux_enforcing || security_permissive_sid(ssid))

- Lets says in policy #1 ssid is permissive.
- Above we just entered this avd into the avc_cache.
- Lets say that right here we race with security_load_policy().
- That is going to inc the seqno and is going to delete our node.  I
don't see anything sync'ing between these two thing.  Certainly not RCU
lock.
- In policy #2 ssid is NOT permissive.
- Another process requests the same permission and adds the new node
with seqno=#2.
- We call avc_update_node and update the new node with the decision we
made from the old policy.  Now the avc_cache has an entry that is wrong.

Now we know that the p_ae->avd.seqno has to be <= the current seqno
(thanks to all of that being done under the policy_rw lock.)   If the
callback finds the old deleted node who cares if it gets updated, it's
on it's way out.  If we find the new node with the higher seqno we just
do nothing.

It is possible that we instead raced before the permissive_sid call and
the decision is valid.  Well, that's find, we are still going to return
allow for this operation and the avc_cache can just get updated the next
time.

Where am I missing the synchronization between a policy load and the
differences in what we would find from the original lookup and the
permissive sid lookup and the entry in the avc_cache?

-Eric


> >  			avc_update_node(AVC_CALLBACK_GRANT, requested, ssid,
> > -					tsid, tclass);
> > +					tsid, tclass, p_ae->avd.seqno);
> >  		else
> >  			rc = -EACCES;
> >  	}



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
