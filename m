Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k43CUcLf026792
	for <selinux@tycho.nsa.gov>; Wed, 3 May 2006 08:30:38 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k43CUX95026433
	for <selinux@tycho.nsa.gov>; Wed, 3 May 2006 12:30:35 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 9550E61B09
	for <selinux@tycho.nsa.gov>; Wed,  3 May 2006 22:30:29 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 13933-10 for <selinux@tycho.nsa.gov>;
	Wed, 3 May 2006 22:30:29 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id C4DE361B04
	for <selinux@tycho.nsa.gov>; Wed,  3 May 2006 22:30:28 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id A060CA8322
	for <selinux@tycho.nsa.gov>; Wed,  3 May 2006 22:30:33 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Making MCS mandatory
Date: Wed, 3 May 2006 22:30:29 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200605032230.30757.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have implemented a change to the MCS policy to make it mandatory.  So far in 
my own tests it does what it is supposed to do.  I would like to get some 
feedback from people on this list before putting it in to rawhide, it's the 
most significant change to MCS since it's inception...

The low level of the range for a process determines the default context
for a created file.  The default configuration of the MCS policy has a
low level of "s0" for all user login sessions.  I believe that the vast
majority of systems will not differ from the default in this regard.
Therefore what I propose below will not make an impact on most users.
Targeted policy is designed to be minimally invasive, I expect that at
least 90% of Fedora users don't notice it's presence or even know that
it is there.  MCS is an extension to the same theme, people who use
targeted policy can choose to ignore it (whether they have no interest
in SE Linux or just no interest in anything other than the domain-type
model) and it won't affect them.  Mandatory MCS will be just as
minimally invasive to MCS users.  People who really use MCS now (as
opposed to people who just have the default configuration and have
everything running at s0-s0:c0.c255) will probably have all accounts
with s0 as the low level and thus notice no immediate difference from my
changes.

The latest MCS policy does not permit increases in the high level of the
sensitivity range except through logging in again, but does allow
changes to the low level without restriction.

For MCS to be a mandatory policy there would need to be controls over
changing the low level of the range for a child process.  So if the
process was not permitted to lower the low level of it's range then it
would be mandatory for all files created by the user to have all
categories assigned to the low level of their range.  Similar
restrictions would also be needed on file relabel, ptrace, etc.

Finally if the low level of the process range is not dominated by the
level of a file then writes to the file would be denied.  This final
point could potentially make a Mandatory MCS system difficult to use,
however as such a configuration is optional (as explained in para 1) it
should not cause any problems.

The changes to the MCS constraints are:

For file write operations { write setattr append unlink link rename
create relabelto } I added ((l1 domby l2) or (t2 == mcstrustedobject)).

The mcstrustedobject attribute is an analogy of mlstrustedobject.  I am
only using it to override the mandatory access of the file (currently
the only file type in question that matches is security_t and I want the
high level enforced, if we extend MCS to control access to device nodes
then we will still want it this way as the devices in question all
default to s0).  Let me know if you think I should use a different
attribute name for this.

For process transition and dyntransition I changed ( h1 dom h2 ) to
( ( h1 dom h2 ) and ((l1 domby l2) or (t1 == mcssetlow)) ).  Note that I
haven't actually used the mcssetlow attribute yet.  If you think that
mcssetlow is a bad name then please suggest another.

For ptrace I added (l1 domby l2) to the constraint.  This prevents a
process from escaping from it's level by ptracing a process which runs
at a lower level.

Finally as an independent issue to MMCS I have put the more important
parts of /selinux as c0.c255.

Here is a summary of the differences between Mandatory MCS and MLS:

MLS bases read access controls on the effective clearance (the low level
of the range) and thus effective read access equals the minimum level
for writes.  This makes it impossible to relabel data to a lower level.
In MCS it is sometimes desirable that discretion to relabel data to a
lower level be granted.  So a user running at s0:c0.c10:s0:c0.c100 can
read a file that has s0:c11 and write the data to a file running at
s0:c0.c10.  This is considered a benefit in the MCS design, the user has
some categories for which they have discretionary access and some for
which the access is mandatory.  Which categories are mandatory is
initially determined by the administrator through semanage, but can also
be determined by the user for their child processes.  Under MMCS if my
shell runs at s0:c1-s0:c0.c10 I can run the command
"runcon -l s0:c1.c2-s0:c1.c4 bash" and then prevent all further
processes from accessing data with categories c0 and c5.c10 and also
forcing all written data to have categories c1.c2.

The RPMs for rawhide and the patch are at the following URL:
http://people.redhat.com/rcoker/pol/

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
