Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FKoCL9011263
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 15:50:12 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1FKkjw0021108
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 20:46:45 GMT
Date: Tue, 15 Feb 2005 20:57:28 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: sshd transition points
Message-ID: <20050215205728.GC26294@lkcl.net>
References: <20050215155323.GC23765@lkcl.net> <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil> <20050215191640.GA26294@lkcl.net> <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil> <20050215200355.GB26294@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050215200355.GB26294@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Feb 15, 2005 at 08:03:55PM +0000, Luke Kenneth Casson Leighton wrote:

>  leaving the restructuring issue aside for one moment, in order to
>  minimise the amount of work involved, would it be reasonable to
>  track the privilege-separated sshd (which is supposed to run in
>  an unused user account) with an intermediate security context, using
>  a dynamic context transition, if necessary, to get to it?
 
 and, sorry for asking a second question in this fashion, but
 if so, how would i derive the context which to dynamically
 transition to?

 i couldn't use get_default_context() ... or could i?

 it'd involve calling the new lovely setcon(), i know that.

 i assume it's possible to "catch" that and trigger something
 similar to domain_auto_trans()?

 i notice from the 2.6.10 patches that there's something called
 "dyntransition" now - and also "setcurrent".

 okay.... so... what's the format... what would dynamic_auto_trans()
 look like?

 this?

	 #################################
	 #
	 # dynamic_auto_trans(parent_domain, program_type, child_domain)
	 #
	 # Define a default domain transition and allow it.
	 #
	 define(`dynamic_auto_trans',`
	 dynamic_trans($1,$2,$3)
	 type_transition $1 $2:process $3;
	 ')

 and then, dynamic_trans() :

	...
	allow $1 $3:process dyntransition
	...

 ... and identical stuff other than that to domain_trans()?


 
 p.s. i've found the point in the openssh code at which the privilege
 separation occurs - the function is helpfully called
 privsep_preauth_child().


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
