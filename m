From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH] newrole suid breakdown
Date: Sat, 7 Oct 2006 01:16:34 +1000
Cc: Steve Grubb <sgrubb@redhat.com>, Michael C Thompson <thompsmc@us.ibm.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        jdesai@us.ibm.com
References: <452432FA.1060009@us.ibm.com> <200610051748.06669.sgrubb@redhat.com> <1160146343.12253.85.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160146343.12253.85.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200610070116.39485.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 07 October 2006 00:52, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Russell had alternatively suggested moving newrole into its own package
> and only installing it (always suid) if installing a -strict or -mls
> policy (i.e. make it a dependency of those policy packages), so that a
> default install does not include it at all (as -targeted has no need for
> newrole functionality).   Concerns there might include: a) mere
> installation of -strict or -mls on a system does not mean that they are
> the active policy, so one could still end up with the suid newrole on a
> machine running targeted, b) not all users of -strict necessarily want
> pam_namespace functionality.   Also not sure about whether that poses
> any packaging or dependency issues.

You are correct that if my suggestion is followed then a very small portion of 
the machines running targeted policy or without SE Linux will have newrole 
installed setuid-root.

But let's put things in perspective.  A typical install of Fedora has about 30 
setuid-root programs (mine has 36).  The same typical Fedora install can be 
expected to have some setgid programs that give access to important groups 
and some possible indirect chains of execution that lead from non-root to 
root.

Of those programs many of them are of old implementation or old design, for 
example when writing this message I realised that I had several setuid-root 
programs from the rsh package.  I had never desired rsh to be installed, it 
must have either been dragged in by dependencies or be part of a default 
install.

Also there are a number of daemons that run as root (dhclient and cups are on 
most workstations).

I agree that we don't want to reduce security through making a mistake, but 
there are plenty of better avenues of attack than newrole.  It might be a 
better use of our time to just accept that a few people will have a 
setuid-root copy of newrole installed when they don't need it and save our 
time for other things.  After all most Fedora users get a kerberos version of 
su installed when they don't need it.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
