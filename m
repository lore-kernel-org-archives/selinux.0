Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72J52rT015334
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 15:05:04 -0400 (EDT)
Date: Mon, 2 Aug 2004 16:44:38 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
Subject: Re: user-directory _is_ home directory
Message-ID: <20040802154438.GH4194@lkcl.net>
References: <20040801143236.GA15949@lkcl.net> <1091455567.23449.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091455567.23449.70.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 02, 2004 at 10:06:07AM -0400, Stephen Smalley wrote:
> On Sun, 2004-08-01 at 10:32, Luke Kenneth Casson Leighton wrote:

> > okay, got a good one for you.
> > 
> > ... i notice that genhomedircon is working properly (hurrah)
> > 
> > however, it brings me a slight problem.
> > 
> > i've made /home _the_ home directory: there is one user, it's
> > _the_ user.

> > [... ]

> > my question is: does anyone have any recommendations on how to deal
> > with /home being a mount point, and also being a user's home directory.
> > 
> > naively i removed the HOME_ROOT macro from types.fc, and naturally,
> > the /home mount point doesn't.  mount, that is.
> 
> Quite aside from the issue of whether or not you should directly use
> /home in this manner, 

 *grin*.

> it would be interesting to understand exactly what
> denial you are encountering and whether policy should be adjusted
> accordingly.  e.g. it may well be true that mount is going to need
> permission to directly mount on these directory types anyway for other
> usage scenarios.

 ah.  the problem that i had was that after i removed the line starting
 HOME_ROOT from types.fc, coincidentally, /home would not mount.

 now, whether these two things are interconnected i do not know.

 but it _does_ remind me of an issue that i have tracked down.

 i noticed that pump was not dying on shutdown.

 it was keeping /var from being unmounted at shutdown.

 at boot-up time, /var could NOT BE MOUNTED.

 only after a second shutdown could it be mounted.

 by replacing pump with dhclient3, i got rid of the symptoms, but
 not the problem.


 now, something happened to /home that likewise caused it to not
 be mountable at startup time.

 except that this time it was not clearable by a reboot.

 only by manually mounting it could the problem be cleared.

 subsequently, the problem has gone away.

 .... except it worries me that i might have to wait for it to happen
 again.

 l.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
