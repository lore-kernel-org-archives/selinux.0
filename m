Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA16191
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 14:51:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA23292
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 18:49:53 GMT
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.106])
	by jazzswing.ncsc.mil  with ESMTP id SAA23288
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 18:49:52 GMT
Subject: Re: IBM's Multics paper
To: Russell Coker <russell@coker.com.au>
Cc: Tracy R Reed <treed@ultraviolet.org>, SE Linux <selinux@tycho.nsa.gov>,
        Paul A Karger <pkarger@us.ibm.com>
Message-ID: <OF63233BC2.ACC04FBD-ON85256C30.0064667B@us.ibm.com>
From: Trent Jaeger <jaegert@us.ibm.com>
Date: Tue, 10 Sep 2002 14:22:11 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

                                                                                                               
                                                                                                               
                                                                                                               


My lovely mail client makes it hard for me to respond to all your points in
one email, so I am going to try one at a time.

> On Tue, 10 Sep 2002 16:44, Trent Jaeger wrote:
>> The numbers for this paper are from the policy files, policy.conf
>> (pre-processed), and ss_policy (compiled) and they are for the complete
>> SELinux example policy as stated in the paper.

Russell replied:
>That is more numbers than seem to be expressed in the paper.  Also as
Steve
>pointed out the complete policy should be compared to the size of part of
the
>file system meta-data that represents ACLs.

The point Paul is trying to make is that the mandatory policy implemented
by Multics (was MLS) was represented by an simple algorithm executing in
the kernel and its integrity depended on an ACL on one file.  Therefore, it
is not necessary to include all ACLs in the analysis.

Now I agree with Paul that this is a fair comparison, but I believe that a
simple mandatory policy can be expressed for SELinux and verified against
the current TE policy to achieve the same goal.  We just haven't done it
yet.  Most of the rest of the note was about how I am starting to go about
it.

Trent.
----------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive
Hawthorne, NY 10532
jaegert@watson.ibm.com
(914) 784-7225, FAX (914) 784-7595




Russell Coker <russell@coker.com.au> on 09/10/2002 01:46:03 PM

Please respond to Russell Coker <russell@coker.com.au>

To:    Trent Jaeger/Watson/IBM@IBMUS
cc:    Tracy R Reed <treed@ultraviolet.org>, SE Linux
       <selinux@tycho.nsa.gov>, Paul A Karger/Watson/IBM@IBMUS
Subject:    Re: IBM's Multics paper





> I agree that the policy can be cut-down (and should be based on your
> security target), but I am not aware of any principled approaches for
> cut-down. This is the interface that administrators see at present.

My latest Debian install scripts will prompt the administrator at install
time
for the removal of unwanted policy files.  However these are still a bit
experimental and I have not published them here yet (and I don't think I
wrote them before the paper in question was written).

> Personally, I believe that access decisions must be made at the SELinux
> policy level, but I think that the point that Paul is trying to make is
> that  strong security guarantees must be expressed in a way that average
> system administrators can maintain (many folks on this list are well
above
> average :->).  I don't think that the strong system security guarantees
in
> Multics were dependent on the fine-grained policy, so this should not be
> the case for SELinux either.

How can an average sysadmin be expected to determine the details of policy?
We are working on ways of allowing them to easily manage things at a high
level (including policy for certain services etc), and we can also use
macros
for basic configuration of such services.  But when it comes to issues such
as whether a daemon should have an "allow" or an "dontaudit" rule
concerning
access to the sysadm tty types it's something that none of us can agree on
yet!  So expecting a typical sysadmin to do the right thing is probably
expecting too much.

Securing complex systems is inherantly complex and requires a great
understanding.

> A number of folks are awarelooking into policy management, but let me
just
> update you on my recent efforts that are consistent with this discussion.
I
> am doing a simple Biba integrity verification on the Apache policy
relative
> the rest of the SELinux example policy (assuming trusted system and
> authentication services).  Interestingly, the only violations are: (1)
> shared files: /tmp, tmpfs_t, writeable_t; (2) a number of logging and
> system status files; (3) interactions with many services that would not
be
> run with Apache (possible cut-downs).  Shared /tmp is a well-known UNIX
> problem, but its solution is independent of SELinux (although it would be
a
> significant benefit).  Log files could be handled as exceptions, likely,
> although I am still looking at this.

Interesting, I look forward to when you publish this.

I think that the Apache policy needs to be changed regardless of these
issues,
it's got a number of usability issues.

> An issue that I am interested in is policy interactions with other
> services.  For example, sendmail can edit files in /etc that Apache is
> permitted to read.  This could be handled by editing the policy, but if
you
> are running a highly secure Apache server do you really want to run
> sendmail too?

Use Postfix or Qmail and this problem should go away...

>  Rather than editing the policy to create your own
> specialized, possibly ad hoc policy, might it be possible to create
> "conflicting subjects" that are not permitted to run together.  Thus, the
> current SELinux policy would remain largely unchanged, but the security
> guarantees that this policy implements can be understood and verified
> against the SELinux policy.

I have been thinking of such things for usability issues.  EG Sendmail and
Postfix policies conflicting.

> Then, the policy that the TCB depends on might include only a high-level
> Biba lattice, some verified exceptions, and some conflicting subjects.
> This would be much smaller than the entire SELinux policy (and Multics),
> but you would still have the fine-grained control that you really need to
> ensure the higher level requirements.
>
> Does this seem like a reasonable direction?  Does this interact with the
> other work on policy management for SELinux?

That sounds promising to me, but I'm not nearly as qualified as Steve et al
to
comment on this...

Also in regard to Steve's comment on the Multics paper, I didn't interpret
it
as needlessly criticising SE Linux and other similar projects.  There are
some valid criticisms of the approach we are taking.  Designing a new OS
from
scratch will give better security.  Also I can understand that if someone
writes an OS based on their ideas of the best way of doing things then
naturally they will use it as an example of the way things should be done.

However I think that the mention of SE Linux did not contain enough detail
for
a fair comparison.  I think that given the nature of the paper it would
make
more sense to just discuss the concept of adding security to an existing
Unix
OS (which applies equally to Trusted Solaris, Trusted BSD, etc).  A good
supporting point for this is that Sun is apparently going to make Trusted
Solaris the only Solaris (I am surprised that this was not mentioned in the
paper).  This could have been done without judging the implementation of
Trusted Solaris, but just on the basis that the senior management of Sun
have
become convinced of some of the views expressed in that paper and backed
their opinion with some significant investments in technology.


Russell Coker




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
