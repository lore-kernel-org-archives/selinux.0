Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA21685
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 08:35:26 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA19506
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 13:34:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id NAA19499 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 13:34:22 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Shaun Savage <savages@pcez.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
Date: Wed, 20 Mar 2002 14:35:13 +0100
References: <Pine.GSO.4.33.0203150854350.15480-100000@raven> <20020320102215.78752232D@lyta.coker.com.au> <3C988239.2080200@pcez.com>
In-Reply-To: <3C988239.2080200@pcez.com>
MIME-Version: 1.0
Message-Id: <20020320133514.46E8075B8@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Mar 2002 13:36, Shaun Savage wrote:
> | If you do that to avoid hackery with the preinstall/postinstall scripts
> | then how do you ensure that daemons are running in the correct domains
> | afterwards? Do you require a reboot of the system after the package
> | installation?
>
> I should/will be in single user mode.
>
> even though single user mode is not a reeboot,  It does bring the system
> off line.

Single user mode is effectively a reboot for users of the system.

> | This is not something that I plan to do.  I don't have enough confidance
> | in package developers doing the right thing to allow automatic .te
> | installation for MY system, and don't expect anyone who uses my packages
> | to have any more faith.
>
> Most people are not as smart as you. They don't understand how a .te is
> written. I am thinking about a "verify" program that would check the
> validity of the new .te before it is shipped.

Check in what sense?  Checking for syntax errors should be easy enough, 
checking for dependencies with other .te's without actually compiling it will 
be difficult, checking for stupid mistakes should be possible, but checking 
for subtle mistakes or malicious omissions will be impossible.

> | So I plan to make it mandatory for the administrator to view the .te's. 
> | I would like to make /etc/selinux not writable for dpkg_t.
>
> would you have a wrapper domain that can write it?

I was thinking of having the usual sysadm_t domain write it.  But you may be 
right, it might make sense to have a special domain to do it.

> The problem here I think is ease of use.  Only a really sharp admin would
> know what going on even on a simple package. I can't explain the http
> package now ;-) I know that most people would not look at the .te unless
> you forced them. and even then only a very few would know what they are
> looking at.

That's OK, if they want to just blindly copy the files then that's their 
choice.

> In situations that REQUIRE super verified security, then the packages them
> self will be "certified" for that platform and configuration. What
> "certified" means, I don't know.

You still can't do pre-packaged .te's that are complete and fully 
restrictive.  Consider the issue of which source of password data to use 
through nss.  Consider the issue of which Apache modules are loaded.  These 
things can require substantial and subtle changes to many settings.

> Most other users want the concept of security. They will believe you when
> you say it is secure. (except me, I don't beleive it when I say it:) If the
> average admin is to use SELinux then it needs to be as easy as a Redhat or
> debian install.

The average admin can't properly deal with standard unix permissions.  The 
average admin can't compile their own kernel.  Is SE Linux ever going to be 
for the average admin?

> | I was thinking that I will need to run setfiles before and after the
> | postinstall script in case it does any file replacement.
>
> good idea, the thing I have done has not needed it, but I will assume there
> will be thoses that do.

Another thing is that I need to patch setfiles to take a list of file names 
on standard input.  Checking the entire file system after replacing a single 
package does not make sense.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
