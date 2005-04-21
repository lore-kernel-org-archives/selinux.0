Subject: Re: [Fwd: Re: Experiences with selinux enabled targetted on Fedora
	Core 3]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Richard Hally <rhally@mindspring.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <42677591.8020703@mindspring.com>
References: <42677591.8020703@mindspring.com>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 08:29:38 -0400
Message-Id: <1114086578.4054.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-04-21 at 05:42 -0400, Richard Hally wrote:
> Because you(and other people) have not made an attempt to have the 
> software changed to perform correctly!

In many cases, I think that they have (i.e. filed bugzilla reports,
introduced patches into the Fedora packages to avoid e.g. leaked file
descriptors, etc).

> Apparently, there are many cases where notification has not taken place 
> at all. The last I looked there were over 4100  dontaudit rules(in the 
> strict policy) and that number is not decreasing.

Notification doesn't mean that it will be immediately fixed upstream,
eh?  Or ever fixed until SELinux is more pervasive and until strict
policy is more pervasive.  If it only shows up with SELinux, and it only
shows up with strict policy, then most upstream package maintainers
aren't going to have a lot of motivation to change it right now.

> In those cases(not necessarily this one) where it is no "big deal" then 
> why  not "allow" rather than "dontaudit". In those cases where there 
> isn't a good reason for not allowing something it should be allowed. If 
> there is a good reason for not allowing something then there need to be 
> changes made to the software.

Principle of least privilege; if the program doesn't have a legitimate
need for the access, it should be denied.  Allowing "trivial" accesses
that aren't truly needed has an unfortunate way of allowing escalation
of access far beyond what you might expect from the individual "trivial"
accesses as independent units.  And yes, changing the software is
desirable, but we aren't in a position to dictate such changes; we can
only ask.  In the meantime, we _can_ deny the access until such a time
as the software is changed.

> Perhaps you should change all the "dontaudit" rules to "allow" and see 
> what happens.

Well, for one thing, a lot more programs would be able to directly
read /etc/shadow rather than having to use the chkpwd helper.

> The use of "dontaudit" implies that software is doing something that is 
> should not be doing. In prohibiting the software from doing whatever 
> that is _without attempting_ to have it corrected is where I find the 
> current approach lacking.

dontaudit implies that software is doing something in violation of
policy.  But policy is dependent on your particular security
requirements, and it is fairly safe to say that not all applications are
going to be written with your particular security requirements in mind.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
