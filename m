Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA13765
	for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 12:46:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA00734
	for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 17:44:12 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id RAA00730
	for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 17:44:09 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Wayne Salamon <wsalamon@tislabs.com>
Subject: Re: new policy
Date: Fri, 6 Dec 2002 18:45:56 +0100
Cc: <selinux@tycho.nsa.gov>, bam@snoopy.apana.org.au
References: <Pine.LNX.4.33.0212060928110.27194-100000@vox.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0212060928110.27194-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Message-Id: <200212061845.56709.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Dec 2002 15:53, Wayne Salamon wrote:
> On Fri, 6 Dec 2002, Russell Coker wrote:
> > Which are the pieces of policy that have no logical connection?
>
>   The fact that I want to place hwclock in it's own domain has no
> relationship to the fact that I have RPM in it's own domain, or an RPM
> policy for that matter. hwclock, the program, is independent of RPM
> programs, is it not? Or is there an interaction between the hwclock_t
> domain and the rpm_t domain that I am missing?

There apparently is.  Apparently there is functionality needed by the 
hwclock_t domain on Red Hat but not for other systems.  If this is not the 
case then the following comment is wrong.
# hwclock needs to search file_t directories when run from rc.sysinit on RH8

>  > Where exactly is the data-as-metadata issue?
>
>   Using the fact that rpm.te exists to say "this is a RedHat system" in
> order to conditionally build the policy. I can have RPM on Slackware, for
> example.

If you have the rpm program on Slackware would you use it for full package 
installation or just use it to build and unpack packages.

> Or I might have hwclock on a non-RedHat system.

If you have hwclock on a non-RedHat system then you don't need policy that is 
specific to Red Hat!

> I don't see the
> reason to conditionally include the hwclock policy piece based on the fact
> that we've included the RPM policy piece. rpm.te is data for the policy,
> not an indicator as to the nature of the OS distribution.

OK, let's get something else as an indicator of the OS distribution then.

> Or we could just "build everything"; it is an example policy,
> remember, and any serious use of SELinux needs a custom policy anyway.

Doing that would reduce the potential usage of SE Linux by at least 90%.

>   The issue goes beyond Debian-RedHat. It is possible that portions of the
> policy written for RedHat 7.3 do not apply to RedHat 8.0.

True.  But having special case code for different versions of Red Hat raises 
upgrade issues.

>   I'm porting SELinux and the policy over to a Slackware system for
> another project, and need to strip to policy down to exactly what I
> need. I suspect I'll have to remove some of the if(rpm.te) type rules in
> order to build what I want.

I don't think that you'll need to do that often (if at all).

>  > What do you think of Brian's work on XML for policy?
>
>   I haven't looked at it.  Does it solve the issues we are dealing with
> here, or is it just a representation of policy in an XML form?

Not sure.  Brian, would you like to comment?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
