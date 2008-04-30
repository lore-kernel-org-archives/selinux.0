Subject: Re: refpolicy roles / RBAC separation RFC
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <1209560233.25678.277.camel@moss-spartans.epoch.ncsc.mil>
References: <1209484450.6110.47.camel@gorn>  <48175B0A.4080800@redhat.com>
	 <1209496821.25678.249.camel@moss-spartans.epoch.ncsc.mil>
	 <4818637C.30108@redhat.com>
	 <1209560233.25678.277.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 30 Apr 2008 10:54:09 -0400
Message-Id: <1209567249.1053.29.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-04-30 at 08:57 -0400, Stephen Smalley wrote:
> On Wed, 2008-04-30 at 08:18 -0400, Daniel J Walsh wrote:
> > If I want to run a confined role say webadm_r, I would not allow
> > webadm_r to touch any files in /root, so I don't see that I need
> > protection.  Similarly webadm_r can not touch entries in the Homedir so
> > it can not attack other roles.  If you need to create an admin role
> > which administrates more then one confined domain, then you would
> > generate a new admin role or enhance an existing admin role.  For
> > example if you want to allow the webadm_r:webadm_t to be able to admin
> > mysql,  you simply create a policy module with
> > 
> > mysql_admin(webadm_t, webadm_r, { webadm_devpts_t webadm_tty_device_t })
> 
> Just noticed this - is the plan to retain the derived types for
> ttys/ptys, or are those also going away as part of this elimination of
> per-role types?
> 
> If you retain the derived types on ttys/ptys, then I'm not sure how you
> eliminate the per-role program domains, as one of the reasons for them
> to exist is to preserve isolation of the ttys/ptys.

I plan on removing derived-typed terminals.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
