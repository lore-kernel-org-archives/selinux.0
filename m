Message-ID: <72222DC86846D411ABD300A0C9EB08A10152434E@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        Russell Coker
	 <russell@coker.com.au>
Cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>, SELinux@tycho.nsa.gov,
        "'hdholm@epoch.ncsc.mil'" <hdholm@epoch.ncsc.mil>
Subject: RE: Generic SELinux Package
Date: Fri, 19 Apr 2002 09:58:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Friday, April 19, 2002 9:51 AM, Stephen Smalley wrote:
> On Thu, 18 Apr 2002, Russell Coker wrote:
> 
> > It probably wouldn't be that difficult to make mount_root() not load the
> > policy when an initrd is being used and to then have change_root() do it
> > later.  In fact it seems to easy that I might have a hack  at it later
tonight
> > (although maybe Steve knows of something that'll make this extremely
> > difficult and painful).
> 
> I don't think that this would be difficult, but it seems less  desirable
> than the alternative you mention below, i.e. placing a  minimal policy on
> the initrd to allow bootstrapping and reloading the policy once the
> real root filesystem has been mounted.  It might be good to have an
> additional hook to permit the security module to try  reloading the policy
> itself after a change in the root filesystem, rather than 
> requiring init to do it.
> 

I am in favor of having a hook to permit the security module to try
reloading
the policy itself after a change in the root filesystem, rather than
requiring init
to do it. I beleive this would give a better solution the modifing init.
More secure
than a init script reloading the policy.


Mark Westerman

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
