Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h836HlLa022877
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 02:17:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h836GEpQ021108
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 06:16:14 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h836GCQX021100
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 06:16:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Jenkins, Steven" <JENKINSS@mail.etsu.edu>
Subject: Re: Type background of SELinux
Date: Wed, 3 Sep 2003 16:17:53 +1000
Cc: <selinux@tycho.nsa.gov>
References: <C5FA5FEED6F0884E9EB90BB3C010F1EF076F4283@etsuex1.etsu.edu>
In-Reply-To: <C5FA5FEED6F0884E9EB90BB3C010F1EF076F4283@etsuex1.etsu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309031617.53697.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Sep 2003 05:16, Jenkins, Steven wrote:
> Thanks -- that's explains what I was seeing in the actual code itself,
> but some of the language in the papers made me wonder if I was missing
> something.
>
> I'm still not clear how systems that can dynamically call libc (or other
> 'dangerous' libraries) are handled -- is the development/deployment
> process basically:
>
> 1- developer writes program
> 2- security administrator examines program to determine appropriate
>     security policy

I suspect that you may be misunderstanding some aspects of typical SE Linux 
operation, but your message was not particularly clear.

For example if I give you a shell account on one of my SE machines (which I 
can do on request) and you want to compile mutt to read your mail you may 
wonder what happens.

You will login with the SE Linux context of jenkinss:user_r:user_t (where 
user_t is the "domain" AKA "type" of the processes you run).  You will 
compile mutt and the executable will have type jenkinss:object_r:user_home_t, 
in the policy source macro file we have:
# Run programs developed by other users in the same domain.
can_exec($1_t, $1_home_t)

When this is instantiated with $1 == "user" the policy permits user_t to 
execute user_home_t in the same context.  So mutt will run in the user_t 
domain.

This requires no specific administrator interaction.  I would be happy to give 
you an account so you can work through this example and inspect the relevant 
policy source, contact me off-list if you are interested.

> That cost is very high in administrator time -- wouldn't it be more

The administrator only has to write policy for daemons and security 
significant programs such as gpg and ssh.  For regular applications compiled 
by a user nothing is required.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
