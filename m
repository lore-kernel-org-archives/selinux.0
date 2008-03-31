Subject: Re: Things were going great until...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Lisa R." <lraykow@cox.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080329020522.A3DQP.80555.imail@fed1rmwml42>
References: <20080329020522.A3DQP.80555.imail@fed1rmwml42>
Content-Type: text/plain
Date: Mon, 31 Mar 2008 10:20:06 -0400
Message-Id: <1206973206.5610.30.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-03-28 at 23:05 -0700, Lisa R. wrote:
> Hello.
> 
> I am on a Debian Etch box with SELinux in permissive mode.  I am using the Strict policy.
> 
> Of course I have no problem adding a user with something like:
> useradd -c "SE Linux test user 1" -m -d /home/setest_1 -g users -s /bin/bash -u 1005 setest_1
> 
> I then create a new SElinux user group:
> semanage user -a -R 'user_r' -P selinuxtest selinuxtest_u

Isn't there already a SELinux user defined in your policy that maps to
user_r that you can use?  Like user_u?

> Finally I create the login for setest_1:
> semanage login -a -s selinuxtest_u setest_1

>From the rest of the thread, it sounds like your pam (and presumably
sshd) just lacks the support for seusers and thus ignores semanage login
entries.

In which case you can either update your pam and friends, or you can
just directly add a semanage user entry for setest_1 and drop the
indirection of selinuxtest_u altogether.  

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
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
