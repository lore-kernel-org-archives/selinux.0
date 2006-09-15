Mime-Version: 1.0
Message-Id: <p06002038c130a6f940c3@[192.168.50.32]>
In-Reply-To: <1158342058.18951.85.camel@moss-spartans.epoch.ncsc.mil>
References: <p06002037c130476cd8d9@[192.168.50.32]>
 <1158342058.18951.85.camel@moss-spartans.epoch.ncsc.mil>
Date: Fri, 15 Sep 2006 15:23:40 -0400
To: Stephen Smalley <sds@tycho.nsa.gov>
From: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>
Subject: Re: Question on type_member rule
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks very much for the explanation of how the context of instance 
directories is computed.  Once I added the proper type_member rule, 
it was working as you described.  (When I first tried this, I had 
assumed that the context of the instance directory would be that of 
the process and did not understand the point of the type_member rule.)

>On Fri, 2006-09-15 at 08:51 -0400, Rosalie Hiebel wrote:
>>  I'm trying to understand precisely how a type_member rule specifies
>>  the context to place on an instance of a polyinstantiated directory
>  > when it's done by context.
>
...snip...
>Let's distinguish between what security_compute_member() computes, and
>how pam_namespace calls and uses it.
>
>Further, before we delve too deep here, I have to ask:  Does your
>application truly require polyinstantiated directories?

I want an application which runs at various MLS levels to see only 
the instance  whose MLS level matches the process's MLS level; I 
thought polyinstantiation by context would easily provide this.   We 
also would occasionally like certain processes to be able to see all 
instances of it at or below the MLS level of the process.  Is this 
possible with polyinstantiation?  (Would the user being in the list 
of excluded uids be required?)

>  From what
>you've described thus far, it sounds as though the application is
>already security-aware and multi-level, so what does it gain from
>polyinstantiation vs. explicit directory/file management?
>Polyinstantiation is more oriented toward providing compatibility for
>security-unaware applications when accessing a shared resource like /tmp
>that must be partitioned in a multi-level environment without having to
>modify those applications to know about per-level instances.  But if the
>application already knows that it is operating in a multi-level
>environment and even knows what level it needs to operate in, why does
>it need polyinstantiation vs. just accessing the right subdir directly?
>(I'd also be interested in exploring the architecture of your
>application and whether it can be decomposed to minimize trust, but that
>is another topic.)
>
>Going back now to your questions, security_compute_member() is a
>function to compute a member/instance context for a given
>polyinstantiated object based on three inputs:
>1) a source context, typically the context of the process that will be
>accessing the instance,
>2) a target context, typically the context of the polyinstantiated
>object, and
>3) the class of the object, so that we can distinguish different kinds
>of polyinstantiated objects that might ultimately exist beyond just
>directories.

...snip...

>The use of the exec context is because we want to instantiate based on
>the context of the process that will be accessing the member, which is
>typically _not_ the current process.  Instead, it is typically a user
>shell or other program executed by the current process (or a child) that
>will run in the exec context rather than the current one.  This is the
>case for e.g. login and newrole.  If your application doesn't follow
>such a model, we need to talk about your application's architecture.
>
>Examples of type_member rules from the refpolicy:
>	type_member user_t tmp_t:dir user_tmp_t;
>	type_member staff_t tmp_t:dir staff_tmp_t;
>
>Then, if pam_namespace is configured to polyinstantiate /tmp by context
>and the user is not in the list of excluded uids, it would call
>security_compute_member with the exec context (set by the caller of
>pam_namespace, e.g. sds:staff_r:staff_t:s3) and the context of the /tmp
>directory (e.g. system_u:object_r:tmp_t:s0).  security_compute_member()
>would find the matching type_member rule for (staff_t, tmp_t) and should
>return the context system_u:object_r:staff_tmp_t:s3 as the
>member/instance context.
>
>--
>Stephen Smalley
>National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
