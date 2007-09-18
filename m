Subject: Re: [PATCH -v2] kernel: selinux: policy selectable handling of
	unknown classes and perms
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, Steve G <linux_4ever@yahoo.com>
In-Reply-To: <1190132935.14037.8.camel@moss-spartans.epoch.ncsc.mil>
References: <1189695931.3391.46.camel@localhost.localdomain>
	 <1190132935.14037.8.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 18 Sep 2007 12:42:19 -0400
Message-Id: <1190133739.3451.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-18 at 12:28 -0400, Stephen Smalley wrote:

> > @@ -296,6 +312,9 @@ static ssize_t sel_write_load(struct file * file, const char __user * buf,
> >  	if (length)
> >  		goto out;
> >  
> > +	printk(KERN_INFO "Policy loaded with handle_unknown=%s\n",
> > +	       security_get_handle_unknown_txt());
> 
> I think this should have some well-defined prefix on it, like "SELinux:"
> or something, to make it easy to identify.  Steve Grubb might have an
> opinion on whether it should use printk or have its own audit message or
> be added to the load policy audit message.

Baah, yeah, it should have that prefix.

I talked to sgrubb about it, he said that since it wasn't something
which could be 'changed' (like setenforce or a boolean) it didn't need
an audit message.  I offered to tack it onto the policy load audit
message but he didn't at the time seem to feel it was portraying useful
information since we assume we know what policy was loaded and thus just
knowing it was loaded should be enough to tell us the handle_unknown
state.

He instead suggested an addition to sestatus or some other tool so it
could be read if the admin cared.

Do you have other feelings now steve?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
