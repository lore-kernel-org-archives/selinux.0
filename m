Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA22462
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 10:31:50 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA04105
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 15:30:29 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA04101
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 15:30:28 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Shaun Savage <savages@pcez.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
Date: Wed, 20 Mar 2002 16:31:29 +0100
References: <Pine.GSO.4.33.0203150854350.15480-100000@raven> <20020320133514.46E8075B8@lyta.coker.com.au> <3C989C1D.30500@pcez.com>
In-Reply-To: <3C989C1D.30500@pcez.com>
MIME-Version: 1.0
Message-Id: <20020320153129.C4B3EC61D@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Mar 2002 15:26, Shaun Savage wrote:
> | Check in what sense?  Checking for syntax errors should be easy enough,
> | checking for dependencies with other .te's without actually compiling it
> | will be difficult, checking for stupid mistakes should be possible, but
> | checking for subtle mistakes or malicious omissions will be impossible.
>
> I look at the policy as a giant state machine.  The checking could/should
> be done off line.  By using the same concepts used in VLSI design, a
> software program could look for nasties. Sounds like a great thesis :) Any
> one want to send me to school again? I have work on it some and have a few
> things worked out but  it would be a two year effort to have something that
> would get the  test coverage needed.

I recall a message from an IBMer some time ago about some work in that 
general direction.

> | The average admin can't properly deal with standard unix permissions. 
> | The average admin can't compile their own kernel.  Is SE Linux ever going
> | to be for the average admin?
>
> Yes, I would like a distro that works out the the box. all the admin does
> is add users, create virtual web sites. .... They don't mess with the
> system.  The packages are tested and verifed before it get to the sysadmin.
>
> I would like to see SELinux in the schools, hospitals, police/fire
> stations, in ~ dept. of fish and wildlife offices.

What is needed for that is a set of "teacher machine" policy files for SE 
Linux, a set of "student workstation" policy files, a set of "student 
time-share machine" policy files and a set of Police policy files.  All these 
would have to be quite different (although teacher machines and Police 
machines would have similar requirements).

>  But that the 99.99%,
> where Mr Msadmin can just click a button the system drops to admin mode,
> drag the new package to the ~ install box and its done. World peace, and a
> chicken in every pot. :)

That requires huge amounts of work writing policy files.  Some of my policy 
files have taken me more than a day's work.  I am getting better at it now, 
but I've still got to do Postfix which will be really painful.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
