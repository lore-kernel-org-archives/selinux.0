Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA26077
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 14:05:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA21276
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 18:04:24 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA21272 for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 18:04:23 GMT
Date: Tue, 16 Apr 2002 14:04:57 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: idea for run_init
In-Reply-To: <20020416104338.E156A2413@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204161349020.5820-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 16 Apr 2002, Russell Coker wrote:

> Currently I have a need for run_init type functionality with three different
> SIDs for apt-get, dselect, and dpkg for Debian packaging.
>
> I currently have my own program in my "selinux" Debian packages to change SID
> in addition to the regular run_init program.
>
> My program expects it's argv[0] to be "se_%s" where the %s is the name of the
> program to run, then after authentication it will run the program %s with the
> SID expressed in /etc/security/%s_context.
>
> So for example "se_apt-get install dpkg" will get the same result as
> "apt-get install dpkg" would on a non-SE system, and it will be run under the
> SID specified in /etc/security/apt-get_context, which is
> system_u:system_r:apt_t.
>
> What do you think of this so far?
>
> I could merge the functionality of my program into run_init, is this a good
> idea?

Perhaps the program could automatically derive the new context without
needing a per-application configuration file (or even a per-application
entry in a single configuration file).  This would require some knowledge
of the context internals.  The only difference among these applications is
the domain, which could be obtained from the security server via
security_transition_sid -> sid_to_context -> context_new ->
context_type_get.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
