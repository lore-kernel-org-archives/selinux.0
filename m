Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA21061
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 05:22:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id KAA21366
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 10:21:11 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id KAA21362
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 10:21:09 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Shaun Savage <savages@pcez.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
Date: Wed, 20 Mar 2002 10:41:08 +0100
References: <Pine.GSO.4.33.0203150854350.15480-100000@raven> <20020315231922.EE0931ECB7@lyta.coker.com.au> <3C97D3B9.2030107@pcez.com>
In-Reply-To: <3C97D3B9.2030107@pcez.com>
MIME-Version: 1.0
Message-Id: <20020320102215.78752232D@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Mar 2002 01:11, Shaun Savage wrote:
> This is what i'm doing with rpm.
> There is a rpm domain.
> it takes a passwd to enter the rpm domain
> the I have two options.
> 	disable checking
> 	play games with preinstall scripts and postinstall scripts
>
> I choose disable checking

By "disable checking" do you mean using avc_toggle to turn off policy 
enforcement?

If you do that to avoid hackery with the preinstall/postinstall scripts then 
how do you ensure that daemons are running in the correct domains afterwards? 
Do you require a reboot of the system after the package installation?

> If the package has a nonstandard .te, that is installed into the
> /etc/selinux/policy  directory and the policy is reloaded.

This is not something that I plan to do.  I don't have enough confidance in 
package developers doing the right thing to allow automatic .te installation 
for MY system, and don't expect anyone who uses my packages to have any more 
faith.

I am not even confidant that I can write .te's that will avoid breaking 
things in some situations for some people.

So I plan to make it mandatory for the administrator to view the .te's.  I 
would like to make /etc/selinux not writable for dpkg_t.

> After install and before post install I configure the new files to the
> correct attributes

I was thinking that I will need to run setfiles before and after the 
postinstall script in case it does any file replacement.

> The problem that I came across is the are too many O-ZOT trying to force a
> machine to auto update with checking on

O-ZOT?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
