Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i29E56Rb012404
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 09:05:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i29E3P6Q027201
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 14:03:25 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i29E3O5t027198
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 14:03:24 GMT
Subject: Re: can_ypbind()
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200403092346.29875.russell@coker.com.au>
References: <200403092346.29875.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1078841101.4022.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 09 Mar 2004 09:05:02 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-03-09 at 07:46, Russell Coker wrote:
> Also it seems that anything which needs NIS access will also need NSCD or LDAP 
> access depending on the configuration of the system.  So maybe instead of 
> can_ypbind() we should have can_account_lookup() (or some better name) which 
> will then permit NIS, NIS+, LDAP, NSCD, or whatever else is necessary to do 
> the job.

Possibly can_nameservice or can_nsswitch, and cover the possibilities
present in /etc/nsswitch.conf, e.g. NIS+, NIS, DNS, local /etc file
reading, hesiod, etc.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
