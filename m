Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA19652
	for <selinux@tycho.nsa.gov>; Tue, 19 Mar 2002 19:13:41 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA22879
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 00:12:38 GMT
Received: from sendmail (savages.net [208.170.193.18])
        by jazzband.ncsc.mil  with ESMTP id AAA22875 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 00:12:37 GMT
Message-ID: <3C97D3B9.2030107@pcez.com>
Date: Tue, 19 Mar 2002 16:11:37 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: Russell Coker <russell@coker.com.au>, selinux <selinux@tycho.nsa.gov>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
References: <Pine.GSO.4.33.0203150854350.15480-100000@raven> <20020315231922.EE0931ECB7@lyta.coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

HI

This is what i'm doing with rpm.
There is a rpm domain.
it takes a passwd to enter the rpm domain
the I have two options.
	disable checking
	play games with preinstall scripts and postinstall scripts

I choose disable checking

If the package has a nonstandard .te, that is installed into the
/etc/selinux/policy  directory and the policy is reloaded.

After install and before post install I configure the new files to the correct
attributes

I then restart checking

The problem that I came across is the are too many O-ZOT trying to force a
machine to auto update with checking on


an example is
~ any time a app is dependant upon it's execution upon a app that does'nt know
about it when the .te files were created.


Just some ideas
Shaun Savage

Russell Coker wrote:
| On Fri, 15 Mar 2002 15:00, Stephen Smalley wrote:
|
|>>To solve this I was thinking of having an automatic transition from
|>>sysadm_t to dpkg_t when dpkg_exec_t programs are run.  Then there would
|>>be an automatic transition from dpkg_t when running initrc_exec_t
|>>binaries (all the start scripts) which stops run_init from needing a
|>>password.
|>>
|>>What do you think of this idea?
|>
|>I'm not sure I understand.  run_init (or something similar) still needs to
|>be used when running the init scripts so that they are executed from the
|>proper security context.  run_init re-authenticates for the same reason as
|>newrole - to ensure that the user really wants to perform the transition,
|>as opposed to some malicious code run by the user.  If you eliminate the
|>user interaction for dpkg, how do you provide the same guarantee?  Or, if
|>you are willing to give up that guarantee, then why not just drop the
|>authentication out of your copy of run_init entirely.
|
|
| OK.  What if I make it the proceedure to use run_init to run dpkg or dselect
| for package installation or replacement?
|
| The idea of dropping the authentication out of run_init or doing any major
| change to decrease the security of my setup is not something that I am
| prepared to consider.
|
| My problem is that in the usual Debian package installation process the
| program dselect will run dpkg multiple times, each invocation may install
| multiple packages.  Each package installation may run multiple scripts that
| may end up starting daemons, in many cases the daemon start scripts will be
| run with standard input directed to be from /dev/null.  So if there is to be
| any authentication in the package installation process then it has to be
| before dselect is started.
|
| Am I on the right track now?
|

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE8l9O3n6I06Opz+XURAozGAJ9UBCE7ityjP1h3FC8Cer1Ytc3bqQCgwYyG
e7Ftj0P5jCTHkSUhgH/oZ5w=
=U9j7
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
