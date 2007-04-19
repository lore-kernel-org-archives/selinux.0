Subject: Re: [PATCH][RFC] selinux: preserve boolean values across policy
	reloads
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <4627B314.8050103@manicmethod.com>
References: <1177006579.27654.169.camel@moss-spartans.epoch.ncsc.mil>
	 <4627B314.8050103@manicmethod.com>
Content-Type: text/plain
Date: Thu, 19 Apr 2007 14:31:02 -0400
Message-Id: <1177007462.27654.187.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-19 at 14:21 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > At present, the userland policy loading code has to go through contortions to preserve
> > boolean values across policy reloads, and cannot do so atomically.  
> > As this is what we always want to do for reloads, let the kernel preserve them instead.
> >
> >   
> Are there situation where you may want to reset the boolean state to 
> policy defaults? I can't think of realistic scenarios but if one ever 
> comes up do we want to provide that facility?

You can always set them after the load if you want to force them back to
those defaults.  But I don't think anything is presently using
load_policy -b.

Alternative model is to make it a policy config flag (which I also
played with), but then you don't gain anything in libselinux wrt
removing/reducing the libsepol dependency - you still need sepol
interfaces to set/clear that flag.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
