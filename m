Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>,
   selinuxdev <selinux-dev@tresys.com>
In-Reply-To: <43D4FEBF.6020309@tresys.com>
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com>
	 <1137770413.3648.140.camel@moss-spartans.epoch.ncsc.mil>
	 <1137784500.31152.6.camel@twoface.columbia.tresys.com>
	 <1137790181.3648.250.camel@moss-spartans.epoch.ncsc.mil>
	 <43D1553B.3090701@tresys.com>
	 <1138026975.20815.62.camel@moss-spartans.epoch.ncsc.mil>
	 <43D4ED7A.3090805@tresys.com>
	 <1138030160.20815.97.camel@moss-spartans.epoch.ncsc.mil>
	 <43D4F8DD.30705@tresys.com>
	 <1138031978.20815.103.camel@moss-spartans.epoch.ncsc.mil>
	 <43D4FEBF.6020309@tresys.com>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 11:18:54 -0500
Message-Id: <1138033134.20815.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-01-23 at 11:05 -0500, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Mon, 2006-01-23 at 10:40 -0500, Joshua Brindle wrote:
> > 
> >>speaking of the create_store code path, That function is no longer in 
> >>use and it was primarily used for bootstrapping non-managed systems so I 
> >>didn't remove it yet but we can probably just require the package 
> >>manager or make scripts to initialize the store and remove this from the 
> >>library entirely.
> > 
> > 
> > Hmm...I missed that side effect.  Moving aside my module store and
> > trying to re-install the base module from /usr/share/selinux does indeed
> > fail against the new libsemanage (upon connect).  So the policy package
> > would have to pre-create the directory tree and the lock files so that
> > the connect could succeed?  I'm not sure that is truly what we want.
> > 
> 
> before it was implicitly happening if it didn't exist (which will now 
> result in an 'unmanaged system' return which should tell the client not 
> call connect and therefore not initialize the store (i love bootstrap 
> issues btw). I'm alright with making an explicit option to initialize it 
> via semanage or semodule (preferably semodule).. would this be better?

Why do we want changed behavior upon _connect at all?  Why not leave
connect alone (i.e. still call create_store(...,1) there), and just
change clients as desired to call access_check() when you don't want
such bootstrapping (which it seems is desirable as the default for
semodule -b)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
