MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: User object manager context location
Date: Fri, 27 Oct 2006 15:13:21 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158851468B@exchange.columbia.tresys.com>
In-Reply-To: <1161975533.17018.70.camel@moss-huskies.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <ewalsh@tycho.nsa.gov>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Eamon Walsh [mailto:ewalsh@tycho.nsa.gov] 
> 
> On Fri, 2006-10-27 at 14:48 -0400, Eamon Walsh wrote:
> > On Fri, 2006-10-27 at 14:18 -0400, Joshua Brindle wrote:  
> > > 
> > > I'm still not convinced by this, an object manager will 
> potentially 
> > > be labeling based on a config, picture an selinux aware 
> apache that 
> > > is labeling vhosts, the vhosts are in the config file and somehow 
> > > would need to by synchronized with the contexts in the 
> policy directory.
> > 
> > The userspace object manager in apache would take the name of the 
> > vhost, or some appropriate string derived from the vhost 
> > configuration, and
> > call:
> > 
> > matchpathcon_new("my-vhost-name", SECCLASS_VHOST, &context)
> > 
> > Then the returned context would be converted to a SID and stored in 
> > the vhost object, or whatever apache uses to keep track of vhosts.
> > 
> > I wouldn't want the vhosts contexts to be kept in the apache config 
> > file because then the apache administrator would be able to change 
> > them.  The security administrator should have sole control over 
> > policy.  There will have to be some synchronization between 
> config file and policy.
> 

Apache can impose access control on relabeling vhosts just like semanage
would. It's important to note that there is no enforcement of contexts
attached to policy packages (and no short or mid term plans to add it
AFAIK). Semanage could be used to add them but defaults have to come
from policy packages if we do it that way..

> I should say further that there would be sane defaults 
> involved, so things would work out of the box.  So you'd have 
> some default context for vhosts in the policy, just like 
> unlabeled_t for files.

I still don't buy this, if for no other reason than the object labeling
(even defaults) are owned by the application, not semanage, not the
policy. These are a resource of the application. What will matchpathcon
return if there is no file for that object class? Is it going to default
to an initial sid that may not even make sense for that object class? 

The sychronization is a bad user burden to impose and IMHO isn't going
to fly, even if it's the better security solution.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
