Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GI1vL9018422
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 13:01:58 -0500 (EST)
Subject: Re: sshd transition points
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050216152644.GU31121@lkcl.net>
References: <20050215155323.GC23765@lkcl.net>
	 <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215191640.GA26294@lkcl.net>
	 <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215200355.GB26294@lkcl.net> <20050215225329.GH26294@lkcl.net>
	 <20050215231707.GC29523@lkcl.net> <20050216000437.GD30341@lkcl.net>
	 <1108559425.19756.54.camel@moss-spartans.epoch.ncsc.mil>
	 <20050216134457.GL31121@lkcl.net>  <20050216152644.GU31121@lkcl.net>
Content-Type: text/plain
Message-Id: <1108576417.20162.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 16 Feb 2005 12:53:38 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-16 at 10:26, Luke Kenneth Casson Leighton wrote:
> i aim to add a setcon() into sshd's "input_userauth_request()"
> function just after the point where the username is obtained,
> such that any unauthorised IP addresses for that username will
> immediately stop any further TCP traffic.

And this occurs in the unprivileged child process, not the monitor?  So
the unprivileged child will timeout waiting for further input, die, and
the monitor will cleanup?

> i will add a type_transition to the policy
> 
> 	 type_transition sshd_priv_t user_t:process sshd_priv_user_t;
> 
> i will temporarily use get_default_context() - if it works - to
> obtain the user_t context, as the 2nd argument to
> security_compute_create().
> 
> i will use security_compute_create() to look up the actual context
> in my type_transition policy rule (sshd_priv_user_t).

And where does sshd_priv_t come from?  Unless you make some other
change, you are still running in sshd_t at this point, right?

> i will use setcon() to actually set the required context
> (sshd_priv_user_t).
> 
> i will restrict sshd_priv_user_t to only be allowed TCP send and
> receive from a specific IP address.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
