Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2NHqbFR001880
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2008 13:52:37 -0400
Received: from web36601.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m2NHqZKo013744
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2008 17:52:35 GMT
Date: Sun, 23 Mar 2008 10:25:50 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Removing DAC.
To: cinthya aranguren <cinthya.aranguren@gmail.com>, selinux@tycho.nsa.gov
Cc: LSM List <linux-security-module@vger.kernel.org>
In-Reply-To: <50771f160803230854n18bd2a07q34eb154fc016f351@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <613578.78683.qm@web36601.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- cinthya aranguren <cinthya.aranguren@gmail.com> wrote:

> Hi,
> 
> Is there any way to avoid o remove DAC controls ? I'd like to have only one
> security scheme in my system. I mean a pure SElinux system. not DAC + MAC.
> only MAC.

No.

Well, not today.

The LSM, which is the interface that SELinux uses to plug into
the rest of the kernel is explicity designed to allow additional
restrictions but not replacement or override of existing
restrictions. In the early days of LSM both restrictive models,
like what we have today, and authoritiative models, which would
allow replacement of traditional DAC where considered. The
authoritative model was rejected based on how easy it would be
for proprietary modules that had nothing to do with security to
exploit the interface.

I am currently putting some work into separating the LSM into
a pair of interface sets, one for the privilege model and one
for the additional restrictions. Once in place it could be
possible to create a privilege scheme that reports to the 
traditional DAC that everyone has DAC override, and leave it
to SELinux (or whatever restrictive model you might prefer)
to make the only decision.

That work is not done, nor is there any assurance that it
might be accepted when it is. Since it would result in a
system where the privilege module and the access restriction
module could team up to provide an authoritative model
it is within reason that the arguments that blocked an
authoritative LSM could be raised again with the same result.

Now I'll ask the 37 cent question:

Why would you want to do that?



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
