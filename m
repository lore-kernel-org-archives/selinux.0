Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0ANwjIi003551
	for <selinux@tycho.nsa.gov>; Mon, 10 Jan 2005 18:58:45 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0ANwhe6020793
	for <selinux@tycho.nsa.gov>; Mon, 10 Jan 2005 23:58:48 GMT
Date: Mon, 10 Jan 2005 23:23:12 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Multiple contexts
Message-ID: <20050110232312.GI6967@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1105390249.8093.21.camel@cobra.ivg2.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jan 10, 2005 at 01:50:49PM -0700, Ivan Gyurdiev wrote:
> Why doesn't SElinux support multiple contexts per file?
> It seems to me that this feature would be very useful. 
> Is this technically not feasible?
> 
> I've been trying to get the following setup working on FC3 (rawhide):
> 
> /var/www/html.userX  - 
> 	virtual server for userX.mydomain labeled httpd_sys_content_t
> /home/userX - 
> 	home folder for userX, exported via Samba (not yet, but
> 	it will be, once dwalsh puts in booleans for samba reading home)
> 
> /home/userX/webserver - symlink to /var/www/html.userX 
> 
> Now, /var/www/html.userX needs to be accessed both by smbd and httpd.
> I need to label it with both samba_share_t and httpd_sys_content_t.
 
 i understand the mindset of selinux enough now to be able to say that
 the recommended approach would be for you to create a file type
 samba_share_httpd_sys_content_t and then for you to modify the
 selinux policy to grant the programs requiring access to those
 filetypes in the samba.te and the apache.te policy files.

> I have to edit the cryptic m4 policy file to add a type that's
> accessible by both. Why is this necessary? Why can't selinux
> either

> 	(1) Label the file with both contexts, and permit
> 	the operation if any context permits it
> 
> 	or
> 		
> 	(2) Create a type with the properties of both
> 	with less user interaction (without needing to 
> 	modify the policy manually)
> 
> Since I'm unfamiliar with how SElinux works internally,
> this might be a stupid question, but it seems to me that 
> the user should not be required to understand how a policy
> file works to label a file for use by two restricted programs.

 yes, it does seem a little curious: taking NT security descriptors
 (actually VMS SDs) as an example, and ignoring the fact that NT/VMS
 SDs contain DAC (discretionary) ACLs - each ACL is just that - an
 access control LIST.

 whereas in NT, the SD contains ACLs and the ACLs can be extended,
 modified and edited (and are better understood!), SElinux turns things
 roundabout somewhat: providing a reference (handle) into a binary
 policy.

 what i _am_ aware of is that by having the policies in a structured
 language, formal analysis tools can be applied to make certain
 guarantees and proofs.

 in paranoid security environments, it's far more important
 to be able to prove that someone _could_ break in than to
 not _know_ if they could break in (!)

 i can only hazard a hazardous guess therefore that the more
 "normal" ACL system [that we are used to seeing] was rejected
 because it makes the formal proof methodology more difficult.

 *shrug*.  *clueless*.  anyone know?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
