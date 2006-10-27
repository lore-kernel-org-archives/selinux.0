Subject: RE: User object manager context location
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <1161974934.17018.67.camel@moss-huskies.epoch.ncsc.mil>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158851467B@exchange.columbia.tresys.com>
	 <1161974934.17018.67.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 14:58:53 -0400
Message-Id: <1161975533.17018.70.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-27 at 14:48 -0400, Eamon Walsh wrote:
> On Fri, 2006-10-27 at 14:18 -0400, Joshua Brindle wrote:  
> > 
> > I'm still not convinced by this, an object manager will potentially be
> > labeling based on a config, picture an selinux aware apache that is
> > labeling vhosts, the vhosts are in the config file and somehow would
> > need to by synchronized with the contexts in the policy directory.
> 
> The userspace object manager in apache would take the name of the vhost,
> or some appropriate string derived from the vhost configuration, and
> call:
> 
> matchpathcon_new("my-vhost-name", SECCLASS_VHOST, &context)
> 
> Then the returned context would be converted to a SID and stored in the
> vhost object, or whatever apache uses to keep track of vhosts.
> 
> I wouldn't want the vhosts contexts to be kept in the apache config file
> because then the apache administrator would be able to change them.  The
> security administrator should have sole control over policy.  There will
> have to be some synchronization between config file and policy.

I should say further that there would be sane defaults involved, so
things would work out of the box.  So you'd have some default context
for vhosts in the policy, just like unlabeled_t for files.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
