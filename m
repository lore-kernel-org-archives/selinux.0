Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i09E9SRb029742
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 09:09:28 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i09E9RiV000753
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 14:09:27 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i09E9Q06000749 for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 14:09:26 GMT
Subject: Re: aliases
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200401092218.47912.russell@coker.com.au>
References: <200401092218.47912.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1073657357.29816.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 09 Jan 2004 09:09:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-01-09 at 06:18, Russell Coker wrote:
> I believe that we need a minor change in the policy language to deal with 
> aliases.
> 
> The current setup requires that all aliases be specified on the type 
> declaration line.  One significant problem with this is that if a type is 
> declared by a macro there is no way to add aliases to it.  Because of this we 
> have at various times had aliases specified in macros when they weren't 
> needed for 95% of the cases.
> 
> I believe that a declaration of the form is necessary:
> typealias foo_t aliases { bar_t baz_t };
> 
> That would mean that I could do:
> 
> var_run_domain(foo)
> typealias foo_var_run_t alias var_run_foo_t;
> 
> Instead of having the current alias in the var_run_domain() macro.  Of course 
> it's no big deal for the var_run_domain() macro (and I'll remove the alias 
> from my tree because it's been there too long anyway).  But there are other 
> situations which are more difficult to manage (such as renaming netscape to 
> mozilla).

Aside from preserving old type names for compatibility, type aliases
seem to have little use, and significant potential for confusion.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
