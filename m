Subject: RE: User object manager context location
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158851467B@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158851467B@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 14:48:54 -0400
Message-Id: <1161974934.17018.67.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-27 at 14:18 -0400, Joshua Brindle wrote:  
> 
> I'm still not convinced by this, an object manager will potentially be
> labeling based on a config, picture an selinux aware apache that is
> labeling vhosts, the vhosts are in the config file and somehow would
> need to by synchronized with the contexts in the policy directory.

The userspace object manager in apache would take the name of the vhost,
or some appropriate string derived from the vhost configuration, and
call:

matchpathcon_new("my-vhost-name", SECCLASS_VHOST, &context)

Then the returned context would be converted to a SID and stored in the
vhost object, or whatever apache uses to keep track of vhosts.

I wouldn't want the vhosts contexts to be kept in the apache config file
because then the apache administrator would be able to change them.  The
security administrator should have sole control over policy.  There will
have to be some synchronization between config file and policy.

> Other
> object managers are going to store their contexts with the objects (eg.,
> postgresql). I don't know like disparity in the way labels are handled
> and I'm not comfortable forcing object managers to store their contexts
> in an external place.

As Stephen noted, the purpose of the mapping is just to determine the
appropriate context.  It would still converted to a SID and stored with
the object. 

> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
