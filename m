Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l04GkkRI011814
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 11:46:46 -0500
Received: from web36610.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l04GlVVJ016293
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 16:47:32 GMT
Date: Thu, 4 Jan 2007 08:47:15 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Latest diffs
To: russell@coker.com.au
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200701040905.40416.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <150714.60836.qm@web36610.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Russell Coker <russell@coker.com.au> wrote:

> On Thursday 04 January 2007 03:54, Daniel J Walsh
> <dwalsh@redhat.com> wrote:

> > Fixes for slocate on MLS
> 
> Isn't this just a bad idea?
> 
> Over the years there have been a number of issues
> with locate.  The design of 
> having all the data in a file that all users can
> access is risky at best.
> 
> Are there actually people who desire both the
> confidentiality protections that 
> MLS offers but who don't desire the integrity
> protection offered by turning 
> off locate?

Yup. Users of real deployed MLS systems want
everything to work, regardless of how "obviously
stoopid" it may appear to you and/or me. Since
locate is a facility that makes looking up
files faster (than "find / -name") and "everyone
knows that MLS makes the system slower" it is
very likely that users will believe they want it.

That doesn't mean that you have to give locate
the ability to show users information about
files they aren't cleared for, that would be
wrong. If noone is eager to make locate MLS
cognizant there's always the option of
polyinstantiating /var/lib/mlocate and running
multiple updatedb's. Whichever (if either)
scheme is best in keeping with the overall
SELinux application philosophy ought to serve
fine.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
