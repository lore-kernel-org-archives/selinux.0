Subject: Re: [PATCH -v2] kernel: selinux: policy selectable handling of
	unknown classes and perms
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, Steve G <linux_4ever@yahoo.com>,
        Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1190133739.3451.9.camel@localhost.localdomain>
References: <1189695931.3391.46.camel@localhost.localdomain>
	 <1190132935.14037.8.camel@moss-spartans.epoch.ncsc.mil>
	 <1190133739.3451.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 18 Sep 2007 13:26:18 -0400
Message-Id: <1190136378.14037.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-18 at 12:42 -0400, Eric Paris wrote:
> On Tue, 2007-09-18 at 12:28 -0400, Stephen Smalley wrote:
> 
> > > @@ -296,6 +312,9 @@ static ssize_t sel_write_load(struct file * file, const char __user * buf,
> > >  	if (length)
> > >  		goto out;
> > >  
> > > +	printk(KERN_INFO "Policy loaded with handle_unknown=%s\n",
> > > +	       security_get_handle_unknown_txt());
> > 
> > I think this should have some well-defined prefix on it, like "SELinux:"
> > or something, to make it easy to identify.  Steve Grubb might have an
> > opinion on whether it should use printk or have its own audit message or
> > be added to the load policy audit message.
> 
> Baah, yeah, it should have that prefix.
> 
> I talked to sgrubb about it, he said that since it wasn't something
> which could be 'changed' (like setenforce or a boolean) it didn't need
> an audit message.  I offered to tack it onto the policy load audit
> message but he didn't at the time seem to feel it was portraying useful
> information since we assume we know what policy was loaded and thus just
> knowing it was loaded should be enough to tell us the handle_unknown
> state.

Except that my libsemanage patch allows you to change the flag from the
one in the base module via a semanage.conf setting.  Unless we chose to
not merge that support and only allow it to be inherited from base
module.

> 
> He instead suggested an addition to sestatus or some other tool so it
> could be read if the admin cared.
> 
> Do you have other feelings now steve?
> 
> -Eric
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
