Subject: Re: [RFC][PATCH] extending the libsepol API
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Kevin Carr <kcarr@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
        Selinux-Dev <selinux-dev@tresys.com>
In-Reply-To: <200603212246.k2LMkRNq028071@gotham.columbia.tresys.com>
References: <200603212246.k2LMkRNq028071@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 07:51:06 -0500
Message-Id: <1143031866.28120.140.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-03-21 at 17:46 -0500, Kevin Carr wrote:
> Hello All,
> 
> Some of us at Tresys have been working on changing setools to use libsepol
> as our underlying policy representation.  Our basic goals are the following:
> 
> 1. Provide setools (and other analysis tools) with some of the added
> features of libsepol such as modular policy, the new language features, etc 
> 2. Reduce the redundancy and maintenance required to maintain our own policy
> representation 
> 
> To make our changes we have been working on some API additions for libsepol.
> The attached diff adds some header files that represent how we plan to
> export a new shared API for accessing types/attribs.  The patch is the first
> of many aimed at fleshing out the shared API.  The diff contains just the
> headers as we would like to get some feedback from the community at this
> point.
> 
> The patch adds two files: "include/iterator.h" and "include/type_query.h".  
> 
> We are concerned about consistency in the API and so we intend that the
> remaining component accessors will look very similar to the types API.
> Ultimately we will need to add access to all other components in the policy
> as well as rules and interfaces.  We feel that the iterator concept will
> scale well to those functions.
> 
> As for the limited number of accessor functions that currently exist,
> (users, booleans, etc.) we feel that the current design metaphors don't fit
> well with our requirements and we are not sure what to do about them long
> term as we are presenting something very different, and as I said we are
> concerned about consistency.  There are several long-term options: 1.
> Deprecate them in source and keep them for ABI stability, 2. Don't do number
> 1 ;)

Can you clarify why you feel that the current APIs don't meet your
requirements?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
