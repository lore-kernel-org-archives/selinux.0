Subject: Re: [PATCH] repost: new sockcreate interface to specify context of
	socket when they are created
From: Eric Paris <eparis@parisplace.org>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, kmacmillan@tresys.com, sds@tycho.nsa.gov
In-Reply-To: <Pine.LNX.4.64.0606211135140.10057@d.namei>
References: <1150902506.27852.35.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606211135140.10057@d.namei>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 11:54:40 -0400
Message-Id: <1150905280.16892.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-06-21 at 11:37 -0400, James Morris wrote:
> On Wed, 21 Jun 2006, Eric Paris wrote:
> 
> >     S_(SECCLASS_PROCESS, PROCESS__SETEXEC, "setexec")
> >     S_(SECCLASS_PROCESS, PROCESS__SETFSCREATE, "setfscreate")
> > +   S_(SECCLASS_PROCESS, PROCESS__SETSOCKCREATE, "setsockcreate")
> 
> Did you manually place this here, or was it done by mkaccess_vector.sh in 
> the policy package?
> 
> 
Manually.   /me goes to look at mkaccess_vector.sh

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
