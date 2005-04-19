Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3J4mf7C019140
	for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2005 00:48:41 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3J4iBZj017794
	for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2005 04:44:12 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: I am attempting to add a secadm_r
Date: Tue, 19 Apr 2005 14:43:37 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <425553ED.1040703@redhat.com> <1112893253.27110.62.camel@moss-spartans.epoch.ncsc.mil> <20050407174544.GY19784@lkcl.net>
In-Reply-To: <20050407174544.GY19784@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504191443.40548.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 08 April 2005 03:45, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
wrote:
> > What prevents you from doing what you describe via two usernames
> > in /etc/passwd that both map to uid 0 but have different role
> > authorizations in policy/users?
>
>  prevents... nothing ... i remember something appearing to go
>  wrong when i did that last - something to do with samba, it
>  ended up at the username "root" even though i'd logged in as
>  "root2".

It's annoying that $USER and $LOGNAME have the first entry in the passwd file 
that has the right UID.  Maybe the best thing to do would be to have 
~/.bashrc or /etc/profile set $USER and $LOGNAME based on $HOME.  There's 
nothing we can do about "id -un" though.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
