Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA21470
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 07:38:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA17205
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 12:37:13 GMT
Received: from sendmail (savages.net [208.170.193.18])
        by jazzband.ncsc.mil  with ESMTP id MAA17201 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 12:37:12 GMT
Message-ID: <3C988239.2080200@pcez.com>
Date: Wed, 20 Mar 2002 04:36:09 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
References: <Pine.GSO.4.33.0203150854350.15480-100000@raven> <20020315231922.EE0931ECB7@lyta.coker.com.au> <3C97D3B9.2030107@pcez.com> <20020320102215.78752232D@lyta.coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Russell Coker wrote:
| On Wed, 20 Mar 2002 01:11, Shaun Savage wrote:
|
|>This is what i'm doing with rpm.
|>There is a rpm domain.
|>it takes a passwd to enter the rpm domain
|>the I have two options.
|>
disable checking
|>
play games with preinstall scripts and postinstall scripts
|>
|>I choose disable checking
|
|
| By "disable checking" do you mean using avc_toggle to turn off policy
| enforcement?
|

Yes

| If you do that to avoid hackery with the preinstall/postinstall scripts then
| how do you ensure that daemons are running in the correct domains afterwards?
| Do you require a reboot of the system after the package installation?
|
|
I should/will be in single user mode.

even though single user mode is not a reeboot,  It does bring the system off line.


| This is not something that I plan to do.  I don't have enough confidance in
| package developers doing the right thing to allow automatic .te installation
| for MY system, and don't expect anyone who uses my packages to have any more
| faith.


Most people are not as smart as you. They don't understand how a .te is written.
I am thinking about a "verify" program that would check the validity of the new
.te before it is shipped.

|
| I am not even confidant that I can write .te's that will avoid breaking
| things in some situations for some people.
|

I can't ether

| So I plan to make it mandatory for the administrator to view the .te's.  I
| would like to make /etc/selinux not writable for dpkg_t.

would you have a wrapper domain that can write it?

The problem here I think is ease of use.  Only a really sharp admin would know
what going on even on a simple package. I can't explain the http package now ;-)
I know that most people would not look at the .te unless you forced them. and
even then only a very few would know what they are looking at.

In situations that REQUIRE super verified security, then the packages them self
will be "certified" for that platform and configuration. What "certified" means,
I don't know.

Most other users want the concept of security. They will believe you when you
say it is secure. (except me, I don't beleive it when I say it:) If the average
admin is to use SELinux then it needs to be as easy as a Redhat or debian install.

Say MSWindows is 75% secure, plain linux offers 99% secure, then SELinux is
might be 99.999% secure. but if the admin is harder then MSWindows, the average
user will not use it.
I would personally, want it 99.99% and as easy as M$. to get people to use it.
It least they are USING Linux, with better security.
If 99.9999% is needed then the paper work would kill the developer.



|
| I was thinking that I will need to run setfiles before and after the
| postinstall script in case it does any file replacement.
|
good idea, the thing I have done has not needed it, but I will assume there will
be thoses that do.

|
|
| O-ZOT?
I don't swear

|

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE8mII4n6I06Opz+XURAv5+AKCk+QnYSykE4Vy9sViLrW4GEyujzgCeMPQ/
7fWYeWFu1wzxKghsp5ArjRk=
=TAj+
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
