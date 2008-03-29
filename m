Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2TIqsfo022157
	for <selinux@tycho.nsa.gov>; Sat, 29 Mar 2008 14:52:54 -0400
Received: from fed1rmmtao105.cox.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2TIqkDZ023260
	for <selinux@tycho.nsa.gov>; Sat, 29 Mar 2008 18:52:47 GMT
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20080329185241.GBAF18642.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>
          for <selinux@tycho.nsa.gov>; Sat, 29 Mar 2008 14:52:41 -0400
Message-ID: <20080329145240.CDLBH.81847.imail@fed1rmwml42>
Date: Sat, 29 Mar 2008 14:52:40 -0400
From: "Lisa R." <lraykow@cox.net>
To: selinux@tycho.nsa.gov
Subject: Login Identities not applied when logging in...
In-Reply-To: <20080329020522.A3DQP.80555.imail@fed1rmwml42>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello again.

I realized that I need to run a restorecon after I semanage fcontext so that resolved my labeling issue.

However, I still have a problem with my logins.  They aren't being applied when I login.

When I semanage user -l as root I see my custom "selinux user" associated with the custom label.

When I semange login -l as root I see my custom "selinux user" associated with the "login name" that I created with adduser.

However, when I login and run id -Z as my new user I see the default security context set when I created the user under root.

All I am trying to do is apply a new login to one of my users but it won't take.

I tried a reboot...

Did I break something or do I need to apply something?

This worked the other day without a problem (likely story but it did).

Thanks,
Lisa
j

---- "Lisa R." <lraykow@cox.net> wrote: 
> Hello.
> 
> I am on a Debian Etch box with SELinux in permissive mode.  I am using the Strict policy.
> 
> Of course I have no problem adding a user with something like:
> useradd -c "SE Linux test user 1" -m -d /home/setest_1 -g users -s /bin/bash -u 1005 setest_1
> 
> I then create a new SElinux user group:
> semanage user -a -R 'user_r' -P selinuxtest selinuxtest_u
> 
> Finally I create the login for setest_1:
> semanage login -a -s selinuxtest_u setest_1
> 
> ***I am doing this for example purposes***
> 
> The other day this all worked great. I verified by logging in as setest_1 and ensuring the security context showed selinuxtest_u.
> 
> However, later I created a very small policy module and added a new type mysetype_t.
> 
> I created the .pp file with make -c Makefile
> I installed the .pp file with semodule -i mymodule.pp
> 
> I applied that type to everything under the /lisa directory with:
> semanage fcontext -a -t mysetype_t "/lisa(/.*)?"
> 
> I verified the type was applied with ls -Z.
> 
> So no problems yet...
> 
> Today when I login as setest_1 the security context is that of what it defaults to when root creates the user.  The login I applied the other day is gone.
> 
> HOWEVER, if I do a semanage user -l and semanage login -l everything looks as it should. I see that the login for setest_1 is selinuxtest_u.
> 
> I tried to semanage fcontext -a -t mysetype_t "/somedirectory(/.*)?"
> and that didn't work either.
> 
> HOWEVER, I did a restorecon on each individual file and that seemed to work.  
> 
> What is going on or how do I "restorecon" my logins so I can see any new logins I applied?
> 
> Thanks,
> Lisa
> 
> 
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
