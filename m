Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBJ5lvRb010559
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 00:47:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBJ5l7jx018186
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 05:47:07 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hBJ5l5SR018173
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 05:47:06 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Shane Wegner <shane-keyword-selinux.9d5a25@cm.nu>, selinux@tycho.nsa.gov
Subject: Re: Domain Transitions (or the Exim4 policy)
Date: Fri, 19 Dec 2003 16:47:45 +1100
References: <20031219024548.GA24510@cm.nu>
In-Reply-To: <20031219024548.GA24510@cm.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312191647.45107.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 19 Dec 2003 13:45, Shane Wegner <shane-keyword-selinux.9d5a25@cm.nu> 
wrote:
> I am new to this list and SELinux in general but have
> managed to get it running on a Debian cid system using
> Russell's packages and policies.  Those policies did come
> with a sendmail policy which I have attempted to modify for
> exim4.  I believe I have the file permissions pretty much
> figured out but the domain transitions are a bit confusing.

Why did you change it to exim4_t?  It seems to me that as exim and sendmail 
operate in the same manner it would be better to have a single policy to use 
for them both.  This will make it easier to maintain the policy.

> The two things I am not sure of is when exim calls
> procmail, there is a domain transition to procmail_t which
> is rather restrictive.  My own personal .procmailrc file
> for example runs tmda which is a python program which in
> turn can send out response emails.  procmail_t by default
> doesn't want any part of this and when procmail calls
> sendmail which is a symbolic link back to exim4, there is
> no transition back to exim4_t so exim doesn't have the

It should transition to system_mail_t.

> permissions it needs.  Further, when a user sends mail, say
> echo Hello world |mail
> exim4 gets spawned but this time in the user_t domain,
> again without the necessary permissions to write to its
> spool.

In the sendmail policy it would transition to user_mail_t domain.

> I'm thinking maybe procmail should run as user_r:user_t as
> a users procmail process should be able to do anything the
> logged in user can do.  Would that be a better way of doing
> things?

Then if someone manages to take control over procmail they get complete access 
to your account.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
