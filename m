Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72E6srT012460
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 10:06:54 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72E6LXV021249
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 14:06:21 GMT
Subject: Re: user-directory _is_ home directory
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
In-Reply-To: <20040801143236.GA15949@lkcl.net>
References: <20040801143236.GA15949@lkcl.net>
Content-Type: text/plain
Message-Id: <1091455567.23449.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 02 Aug 2004 10:06:07 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-08-01 at 10:32, Luke Kenneth Casson Leighton wrote:
> okay, got a good one for you.
> 
> ... i notice that genhomedircon is working properly (hurrah)
> 
> however, it brings me a slight problem.
> 
> i've made /home _the_ home directory: there is one user, it's
> _the_ user.
> 
> i could alternatively make a ln -s from /home/theoneuser to /c or
> something but that would drive me up the wall because it is so
> ... so.... windows.
> 
> my question is: does anyone have any recommendations on how to deal
> with /home being a mount point, and also being a user's home directory.
> 
> naively i removed the HOME_ROOT macro from types.fc, and naturally,
> the /home mount point doesn't.  mount, that is.

Quite aside from the issue of whether or not you should directly use
/home in this manner, it would be interesting to understand exactly what
denial you are encountering and whether policy should be adjusted
accordingly.  e.g. it may well be true that mount is going to need
permission to directly mount on these directory types anyway for other
usage scenarios.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
