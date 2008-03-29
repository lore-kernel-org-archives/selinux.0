Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2T65WH2031734
	for <selinux@tycho.nsa.gov>; Sat, 29 Mar 2008 02:05:32 -0400
Received: from fed1rmmtao107.cox.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2T65Rga002289
	for <selinux@tycho.nsa.gov>; Sat, 29 Mar 2008 06:05:28 GMT
Message-ID: <20080329020522.A3DQP.80555.imail@fed1rmwml42>
Date: Fri, 28 Mar 2008 23:05:22 -0700
From: "Lisa R." <lraykow@cox.net>
To: selinux@tycho.nsa.gov
Subject: Things were going great until...
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello.

I am on a Debian Etch box with SELinux in permissive mode.  I am using the Strict policy.

Of course I have no problem adding a user with something like:
useradd -c "SE Linux test user 1" -m -d /home/setest_1 -g users -s /bin/bash -u 1005 setest_1

I then create a new SElinux user group:
semanage user -a -R 'user_r' -P selinuxtest selinuxtest_u

Finally I create the login for setest_1:
semanage login -a -s selinuxtest_u setest_1

***I am doing this for example purposes***

The other day this all worked great. I verified by logging in as setest_1 and ensuring the security context showed selinuxtest_u.

However, later I created a very small policy module and added a new type mysetype_t.

I created the .pp file with make -c Makefile
I installed the .pp file with semodule -i mymodule.pp

I applied that type to everything under the /lisa directory with:
semanage fcontext -a -t mysetype_t "/lisa(/.*)?"

I verified the type was applied with ls -Z.

So no problems yet...

Today when I login as setest_1 the security context is that of what it defaults to when root creates the user.  The login I applied the other day is gone.

HOWEVER, if I do a semanage user -l and semanage login -l everything looks as it should. I see that the login for setest_1 is selinuxtest_u.

I tried to semanage fcontext -a -t mysetype_t "/somedirectory(/.*)?"
and that didn't work either.

HOWEVER, I did a restorecon on each individual file and that seemed to work.  

What is going on or how do I "restorecon" my logins so I can see any new logins I applied?

Thanks,
Lisa





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
