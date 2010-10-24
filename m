Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9PFQGdq027192
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 11:26:16 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o9ONh6nb013582
	for <selinux@tycho.nsa.gov>; Sun, 24 Oct 2010 23:43:07 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinux@tycho.nsa.gov
Subject: Re: Context settings after ssh login
Date: Mon, 25 Oct 2010 10:43:03 +1100
Cc: imsand@puzzle.ch
References: <C8D3542D.BAC90%csellers@tresys.com> <4CBF0235.2000802@gmail.com> <36626.193.5.216.100.1287662961.squirrel@mail.puzzle.ch>
In-Reply-To: <36626.193.5.216.100.1287662961.squirrel@mail.puzzle.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201010251043.03718.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 21 Oct 2010, imsand@puzzle.ch wrote:
> The problem of not being able to login must be in relation with permission
> denies while reading /etc/shadow
> type=AVC msg=audit(1287662213.439:407774): avc:  denied  { read } for 
> pid=10211 comm="sshd" n
> ame="shadow" dev=dm-2 ino=48107 scontext=system_u:system_r:sshd_t
> tcontext=system_u:object_r:s
> hadow_t tclass=file

The way it's supposed to work is that unix_chkpwd will read /etc/shadow and 
tell the caller (sshd or whatever) whether the password matched.  That means 
that sshd doesn't get read access to /etc/shadow and if it's compromised it 
can't give such data away to random attackers.

Using a compromised sshd to read /etc/shadow isn't one of the more likely 
attacks (the existence of such an exploit would rely on there being a sshd 
bug, and it being impossible to launch a shell with said bug).  But it's an 
easy one to protect against.

If you have a non-PAM system then you need to allow such access though.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
