From: Paul Moore <pmoore@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-security-module@vger.kernel.org, linux-audit@redhat.com,
 selinux@tycho.nsa.gov, Paul Osmialowski <p.osmialowsk@samsung.com>
Subject: Re: [RFC PATCH v3 2/5] lsm: introduce hooks for kdbus
Date: Mon, 19 Oct 2015 18:29:14 -0400
Message-ID: <2112989.AEUouYpuBm@sifl>
In-Reply-To: <5617D58C.2070402@tycho.nsa.gov>
References: <20151007230615.7823.74519.stgit@localhost>
 <20151007230829.7823.14385.stgit@localhost> <5617D58C.2070402@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, October 09, 2015 10:56:12 AM Stephen Smalley wrote:
> On 10/07/2015 07:08 PM, Paul Moore wrote:
> > diff --git a/ipc/kdbus/connection.c b/ipc/kdbus/connection.c
> > index ef63d65..1cb87b3 100644
> > --- a/ipc/kdbus/connection.c
> > +++ b/ipc/kdbus/connection.c
> > @@ -108,6 +109,14 @@ static struct kdbus_conn *kdbus_conn_new(struct
> > kdbus_ep *ep,> 
> >   	if (!owner && (creds || pids || seclabel))
> >   	
> >   		return ERR_PTR(-EPERM);
> > 
> > +	ret = security_kdbus_conn_new(get_cred(file->f_cred),
> 
> You only need to use get_cred() if saving a reference; otherwise, you'll
> leak one here.

Yes, that was a typo on my part, thanks.

> Also, do we want file->f_cred here or ep->bus->node.creds (the latter is
> what is used by their own checks; the former is typically the same as
> current cred IIUC).  For that matter, what about ep->node.creds vs ep->bus-
> node.creds vs. ep->bus->domain->node.creds?  Can they differ?  Do we care?

We don't want file->f_cred, per our previous discussions.  I was working on 
this patchset in small chunks and while I added credential storing in the 
nodes, I forgot to update the hooks before I hit send, my apologies.

My current thinking is to pass both the endpoint and bus credentials, as I 
believe they can differ.  Both the bus and the endpoint inherit their security 
labels from their creator and while I don't have any specifics, I think it is 
reasonable to imagine those two processes having different security labels.  
Assuming we pass both credentials down to the LSM, I'm currently thinking of 
the following SELinux access controls for this hook:

  allow <current> bus_t:kdbus { connect };
  allow <current> ep_t:kdbus { use privileged activator monitor policy };

... besides the additional label, I added the kdbus:use permission and dropped 
the kdbus:owner permission.  Considering that the endpoint label, ep_t, in the 
examples above, could be different from the current process, it seemed 
reasonable to want to control that interaction and I felt the fd:use 
permission was the closest existing control so I reused the permission name.  
I decided to drop the "owner" permission as it really wasn't the useful for 
anything anymore, it simply indicates that the current task is the DAC owner 
of the endpoint.

> > @@ -1435,12 +1444,12 @@ bool kdbus_conn_policy_own_name(struct kdbus_conn
> > *conn,> 
> >   			return false;
> >   	
> >   	}
> > 
> > -	if (conn->owner)
> > -		return true;
> > +	if (!conn->owner &&
> > +	    kdbus_policy_query(&conn->ep->bus->policy_db, conn_creds, name,
> > +			       hash) < KDBUS_POLICY_OWN)
> > +		return false;
> > 
> > -	res = kdbus_policy_query(&conn->ep->bus->policy_db, conn_creds,
> > -				 name, hash);
> > -	return res >= KDBUS_POLICY_OWN;
> > +	return (security_kdbus_own_name(conn_creds, name) == 0);
> 
> Similar question here.  conn_creds is the credentials of the creator of
> the connection, typically the client/sender, right?
> conn->ep->bus->node.creds are the credentials of the bus owner, so don't
> we want to ask "Can I own this name on this bus?".

Yes, I think so.

>From a SELinux point of view I imagine we would want access controls along the 
lines of the following:

  allow current name_t:kdbus { own_name };
  allow current bus_t:kdbus { own_name };

... do we want to use different permissions?  I doubt it would matter much 
either way.

> Note that their policy checks are based on conn->ep->policy_db, i.e. the
> policy associated with the endpoint, and conn->owner is only true if the
> connection creator has the same uid as the bus.

I don't think this is significant for us.

> > @@ -1465,14 +1474,13 @@ bool kdbus_conn_policy_talk(struct kdbus_conn
> > *conn,> 
> >   					 to, KDBUS_POLICY_TALK))
> >   		
> >   		return false;
> > 
> > -	if (conn->owner)
> > -		return true;
> > -	if (uid_eq(conn_creds->euid, to->cred->uid))
> > -		return true;
> > +	if (!conn->owner && !uid_eq(conn_creds->euid, to->cred->uid) &&
> > +	    !kdbus_conn_policy_query_all(conn, conn_creds,
> > +					 &conn->ep->bus->policy_db, to,
> > +					 KDBUS_POLICY_TALK))
> > +		return false;
> > 
> > -	return kdbus_conn_policy_query_all(conn, conn_creds,
> > -					   &conn->ep->bus->policy_db, to,
> > -					   KDBUS_POLICY_TALK);
> > +	return (security_kdbus_conn_talk(conn_creds, to->cred) == 0);
> 
> Here at least we have a notion of client and peer.  But we still aren't
> considering conn->ep or conn->ep->bus, whereas they are querying both
> policy dbs for their decision.  The parallel would be checking access to
> the labels of both I suppose, unless we institute a control up front
> over the relationship between the label of the endpoint and the label of
> the bus.

While accidental, as I forgot to update this patch as mentioned previously, I 
think the differences between kdbus DAC and kdbus MAC is okay.  At this point 
we've already authorized the individual nodes to connect to the bus and now we 
are authorizing them to talk to each other; at this control point, it is the 
interaction between the two nodes that we care about, I don't think we care 
about what bus they use, do we?

> > @@ -1491,19 +1499,19 @@ bool kdbus_conn_policy_see_name_unlocked(struct
> > kdbus_conn *conn,> 
> >   					 const struct cred *conn_creds,
> >   					 const char *name)
> >   
> >   {
> > 
> > -	int res;
> > +	if (!conn_creds)
> > +		conn_creds = conn->cred;
> > 
> >   	/*
> >   	
> >   	 * By default, all names are visible on a bus. SEE policies can only be
> >   	 * installed on custom endpoints, where by default no name is visible.
> >   	 */
> > 
> > -	if (!conn->ep->user)
> > -		return true;
> > +	if (conn->ep->user &&
> > +	    kdbus_policy_query_unlocked(&conn->ep->policy_db, conn_creds, name,
> > +					kdbus_strhash(name)) < KDBUS_POLICY_SEE)
> > +		return false;
> > 
> > -	res = kdbus_policy_query_unlocked(&conn->ep->policy_db,
> > -					  conn_creds ? : conn->cred,
> > -					  name, kdbus_strhash(name));
> > -	return res >= KDBUS_POLICY_SEE;
> > +	return (security_kdbus_conn_see_name(conn_creds, name) == 0);
> 
> Here they only define policy based on endpoints, not bus.  Not sure what
> we want, but we need at least one of their creds.  Same for the rest.

Once again, I'm not sure we care about the underlying bus at this point, do 
we?  We've already authorized both the service and the client to connect to 
the bus, now I think all we care about is can the client see the service name.  
Do we really care about the label of the bus here?

> > @@ -1530,10 +1541,13 @@ static bool kdbus_conn_policy_see(struct
> > kdbus_conn *conn,> 
> >   	 * peers from each other, unless you see at least _one_ name of the
> >   	 * peer.
> >   	 */
> > 
> > -	return !conn->ep->user ||
> > -	       kdbus_conn_policy_query_all(conn, conn_creds,
> > -					   &conn->ep->policy_db, whom,
> > -					   KDBUS_POLICY_SEE);
> > +	if (conn->ep->user &&
> > +	    !kdbus_conn_policy_query_all(conn, conn_creds,
> > +					 &conn->ep->policy_db, whom,
> > +					 KDBUS_POLICY_SEE))
> > +		return false;
> > +
> > +	return (security_kdbus_conn_see(conn_creds, whom->cred) == 0);
> > 
> >   }

Very similar to the kdbus_conn_talk hook above, the credentials above still 
look reasonable to me.

> > @@ -1567,18 +1584,22 @@ bool kdbus_conn_policy_see_notification(struct
> > kdbus_conn *conn,> 
> >   	case KDBUS_ITEM_NAME_ADD:
> >   	case KDBUS_ITEM_NAME_REMOVE:
> > 
> >   	case KDBUS_ITEM_NAME_CHANGE:
> > -		return kdbus_conn_policy_see_name(conn, conn_creds,
> > -					msg->items[0].name_change.name);
> > +		if (!kdbus_conn_policy_see_name(conn, conn_creds,
> > +						msg->items[0].name_change.name))
> > +			return false;
> > 
> >   	case KDBUS_ITEM_ID_ADD:
> > 
> >   	case KDBUS_ITEM_ID_REMOVE:
> > -		return true;
> > +		/* fall through for the LSM check */
> > +		break;
> > 
> >   	default:
> >   		WARN(1, "Invalid type for notification broadcast: %llu\n",
> >   		
> >   		     (unsigned long long)msg->items[0].type);
> >   		
> >   		return false;
> >   	
> >   	}
> > 
> > +
> > +	return (security_kdbus_conn_see_notification(conn_creds) == 0);
> > 
> >   }

This also seems okay.

> > diff --git a/ipc/kdbus/fs.c b/ipc/kdbus/fs.c
> > index 68818a8..4e84e89 100644
> > --- a/ipc/kdbus/fs.c
> > +++ b/ipc/kdbus/fs.c
> > @@ -200,6 +202,10 @@ static struct inode *fs_inode_get(struct super_block
> > *sb,> 
> >   	if (!(inode->i_state & I_NEW))
> >   	
> >   		return inode;
> > 
> > +	ret = security_kdbus_init_inode(inode, node->creds);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> 
> Need to put the inode.

Thanks.  It looks like I need to make a call to iget_failed() before 
returning.

-- 
paul moore
security @ redhat
