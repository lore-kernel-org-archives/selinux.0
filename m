Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0IDlNIi019658
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 08:47:23 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0IDjO9K019684
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 13:45:24 GMT
Subject: Re: Getting default context
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bartlomiej Balcerek <Bartlomiej.Balcerek@pwr.wroc.pl>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <Pine.GSO.4.44.0501170946330.16567-100000@sun1000.pwr.wroc.pl>
References: <Pine.GSO.4.44.0501170946330.16567-100000@sun1000.pwr.wroc.pl>
Content-Type: text/plain
Message-Id: <1106055679.18274.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 18 Jan 2005 08:41:19 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-17 at 04:17, Bartlomiej Balcerek wrote:
> Hello,
> 
> I try to use get_default_context() function.
> There is in my code:  get_default_context(pw_name,NULL,&scontext),
> pw_name is "bartol", and I have default context definied in
> /etc/selinux/strict/contexts/default_contexts:
> system_r:pbs_mom_t bartol_r:bartol_t
> Role bartol_r is the only role allowed to bartol.
> SELinux is in permissive mode.
> As a result get_default_context() returns error.
> 
> What have I forgotten ?

Is your program running in system_r:pbs_mom_t?  Does the policy include:
1) allow system_r bartol_r; # allow role transition
2) allow pbs_mom_t bartol_t:process transition; # allow domain transition
3) type pbs_mom_t, domain, privuser, privrole; # allow pbs_mom_t to transition to another user identity and role
4) type bartol_t, domain, userdomain; # allow bartol_t to be
transitioned into as a user domain

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
