Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j67DZ4gA010624
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2005 09:35:04 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j67DWBT1003164
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2005 13:32:11 GMT
Subject: Re: Useradd patchset - seeking comments..
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Roger Brunell <rog_brunell@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050707121927.21316.qmail@web33203.mail.mud.yahoo.com>
References: <20050707121927.21316.qmail@web33203.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 09:30:05 -0400
Message-Id: <1120743005.514.9.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>   Please be sure that anything in libselinux is general enough to work in ALL
> the distros. Currently each new Debian user has to figure out what
> /etc/default/useradd is; why it would be there; and what format it needs to
> have. That is a RHism. As a script, at least, each Debian explorer can track
> down the script, and have a chance of figuring it out. 

Changes in libselinux provide the functionality necessary to integrate
useradd with libselinux, not the other way around. They allow 
manipulation of the selinux data files.

>   And just as a simple question, what if there are multiple storage loactions
> for home directories? /u1/home;/u2/home/;/staff/private/home; What then?

My changes don't handle HOME_ROOT expansion - that's done by 
genhomedircon. Looking at what the script currently does, yes
it is RedHat specific, and does read the file that you argue about.
However, that's not the result of my changes.

>  How
> about:
> 
>   setenv SE_USER_HOMES  /u1/home;/u2/home/;/staff/private/home;
> 
> or better; a /etc/selinux/config line
> 
>   SE_USER_HOMES=/u1/home;/u2/home/;staff/private/home;

I believe genhomedircon parses the passwd file to get those.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
