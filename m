Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i76ET3rT012408
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 10:29:04 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i76ET3O0023721
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 14:29:03 GMT
Subject: Re: Now that SELinux supports booleans should we replace tunables
	with booleans?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>, selinux-dev@tresys.com
In-Reply-To: <411393AB.6020305@tresys.com>
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>
	 <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>
	 <1091800968.8590.39.camel@moss-spartans.epoch.ncsc.mil>
	 <411393AB.6020305@tresys.com>
Content-Type: text/plain
Message-Id: <1091802482.8590.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 06 Aug 2004 10:28:02 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-06 at 10:20, Joshua Brindle wrote:
> If they are going to be changed they should probably also be changed to 
> match the get/set convention used by most other selinux apps.

I can see renaming change_bool to setsebool or something similar, and
adding a new getsebool <boolean> that just displays the value of the
specified boolean.  show_bools is a little different in that it shows
all booleans and their values, so possibly listsebools.  toggle_sebool
has no equivalent.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
