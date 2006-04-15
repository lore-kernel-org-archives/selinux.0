From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: semanage patch
Date: Sat, 15 Apr 2006 13:49:12 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
References: <200604142108.28814.russell@coker.com.au> <1145034536.18244.22.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1145034536.18244.22.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200604151349.17126.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 15 April 2006 03:08, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2006-04-14 at 21:08 +1000, Russell Coker wrote:
> > The attached patch against the semanage utility in rawhide allows it to
> > create and modify prefixes.
>
> Thanks, merged as of policycoreutils 1.30.6.  Note that adding further
> examples in the man page to the EXAMPLES section introduced by Thomas
> Bleher would be helpful.

Updating the man page is the next stage.

> > Also when testing semanage I noticed that it let me remove a SE Linux
> > user when a login still referred to it.  After doing so it then wouldn't
> > let me recreate the user (with a confusing error message).  But as that
> > bug didn't stop me from doing my work I haven't taken the time to fix it.
> >
> > As the complexity of the semanage utility continues to increase I think
> > that we need to split it into separate programs selogin, seuser, seport,
> > seinterface, sefcontext, and setranslation.  This will make the man page
> > easier to understand and generally increase ease of use.  It will also
> > allow shell command-completion to do more of the work for the sysadmin. 
> > What do you think?
>
> Not clear to me whether this will ultimately be helpful to users or more
> confusing.  iptables, auditctl, etc. don't split up the interface like
> this.  More useful to users would likely just be a more extensive
> description in the man page and more examples there.

iptables doesn't split the interface because there are two main functions, 
adding/removing rules from tables and setting table policy for built-in 
tables.  The latter being such a small part of iptables functionality that it 
doesn't justify a separate program.

It might be worth considering splitting auditctl into two programs, one for 
adding/removing rules and another for the rest.

There are other examples of the benefits and problems of the two approaches.  
The best example I can think of is raidtools2 vs mdadm.  With raidtools2 
there was a separate program for each operation, to add a device to a 
degraded array it was "raidhotadd /dev/mdX /dev/hdcX", to remove a device 
from an array that was complete it was "raidsetfaulty /dev/mdX /dev/hdcX ; 
raidhotremove /dev/mdX /dev/hdcX".  The fact that I can still remember all 
the old raidtools2 commands but can't remember any of the mdadm commands is 
noteworthy.

But back to semanage, most of the classes of operations have different 
parameters.  The -r option to specify range is the most commonly used 
parameter (used in all classes of operations apart from translation).  The 
next most common option is -t which is used in 3/6 of the operation classes.

I think that the great divergance of functionality between the different 
operations that semanage performs is justification for separate programs.  
The user and login sections could be kept in the same program because they 
are tightly linked (in fact having a single command that creates both a user 
and a login at the same time along with an optional Unix account would be 
beneficial).  But the other four are different enough that I think they 
deserve separate programs.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
