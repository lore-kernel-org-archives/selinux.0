Subject: Re: [PATCH] Rename class_destroy to prevent namespace conflicts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <XMMS.LNX.4.64.0611291646170.24721@d.namei>
References: <XMMS.LNX.4.64.0611291628410.24574@d.namei>
	 <1164836098.23019.286.camel@moss-spartans.epoch.ncsc.mil>
	 <XMMS.LNX.4.64.0611291646170.24721@d.namei>
Content-Type: text/plain
Date: Thu, 30 Nov 2006 08:51:39 -0500
Message-Id: <1164894699.23019.322.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-29 at 16:47 -0500, James Morris wrote:
> On Wed, 29 Nov 2006, Stephen Smalley wrote:
> 
> > > Please review.
> > 
> > That's fine, although you might want to just add a qualifying prefix to
> > those functions, like policydb_ or sel_ or whatever.
> 
> Yep -- this seemed to be the least invasive, and adding a prefix just for 
> class_destroy would be inconsistent.

Ok,

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
