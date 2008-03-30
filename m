Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2U62s3g026942
	for <selinux@tycho.nsa.gov>; Sun, 30 Mar 2008 02:02:55 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2U62kI6023773
	for <selinux@tycho.nsa.gov>; Sun, 30 Mar 2008 06:02:47 GMT
Message-ID: <47EF2D02.6070708@redhat.com>
Date: Sun, 30 Mar 2008 08:02:42 +0200
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Lisa R." <lraykow@cox.net>
CC: selinux@tycho.nsa.gov
Subject: Re: Login Identities not applied when logging in...
References: <20080329145240.CDLBH.81847.imail@fed1rmwml42>
In-Reply-To: <20080329145240.CDLBH.81847.imail@fed1rmwml42>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Lisa R. wrote:
> Hello again.
> 
> I realized that I need to run a restorecon after I semanage fcontext so that resolved my labeling issue.
> 
> However, I still have a problem with my logins.  They aren't being applied when I login.
> 
> When I semanage user -l as root I see my custom "selinux user" associated with the custom label.
> 
> When I semange login -l as root I see my custom "selinux user" associated with the "login name" that I created with adduser.
> 
> However, when I login and run id -Z as my new user I see the default security context set when I created the user under root.
> 
> All I am trying to do is apply a new login to one of my users but it won't take.
> 
> I tried a reboot...
> 
> Did I break something or do I need to apply something?
> 
> This worked the other day without a problem (likely story but it did).
>
I you want to change the default context that the root user logs in
with, you will need to edit /etc/selinux/*/contexts/users/root

> Thanks,
> Lisa
> j
> 
> ---- "Lisa R." <lraykow@cox.net> wrote: 
>> Hello.
>>
>> I am on a Debian Etch box with SELinux in permissive mode.  I am using the Strict policy.
>>
>> Of course I have no problem adding a user with something like:
>> useradd -c "SE Linux test user 1" -m -d /home/setest_1 -g users -s /bin/bash -u 1005 setest_1
>>
>> I then create a new SElinux user group:
>> semanage user -a -R 'user_r' -P selinuxtest selinuxtest_u
>>
>> Finally I create the login for setest_1:
>> semanage login -a -s selinuxtest_u setest_1
>>
>> ***I am doing this for example purposes***
>>
>> The other day this all worked great. I verified by logging in as setest_1 and ensuring the security context showed selinuxtest_u.
>>
>> However, later I created a very small policy module and added a new type mysetype_t.
>>
>> I created the .pp file with make -c Makefile
>> I installed the .pp file with semodule -i mymodule.pp
>>
>> I applied that type to everything under the /lisa directory with:
>> semanage fcontext -a -t mysetype_t "/lisa(/.*)?"
>>
>> I verified the type was applied with ls -Z.
>>
>> So no problems yet...
>>
>> Today when I login as setest_1 the security context is that of what it defaults to when root creates the user.  The login I applied the other day is gone.
>>
>> HOWEVER, if I do a semanage user -l and semanage login -l everything looks as it should. I see that the login for setest_1 is selinuxtest_u.
>>
>> I tried to semanage fcontext -a -t mysetype_t "/somedirectory(/.*)?"
>> and that didn't work either.
>>
>> HOWEVER, I did a restorecon on each individual file and that seemed to work.  
>>
>> What is going on or how do I "restorecon" my logins so I can see any new logins I applied?
>>
>> Thanks,
>> Lisa
>>
>>
>>
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEUEARECAAYFAkfvLQIACgkQrlYvE4MpobMAPACWIePIB5I2yfWq6jFn4S8J+cLd
ZACfequgBnpKVXE4UO2NuY3f3kY1XOc=
=FALo
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
