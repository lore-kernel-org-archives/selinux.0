Subject: Re: Multiple contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1105390249.8093.21.camel@cobra.ivg2.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 11 Jan 2005 15:08:15 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-10 at 15:50, Ivan Gyurdiev wrote:
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
> 
> I have to edit the cryptic m4 policy file to add a type that's
> accessible by both. Why is this necessary? Why can't selinux
> either
> 	(1) Label the file with both contexts, and permit
> 	the operation if any context permits it

Because then policy would be encoded in the file attributes, not in a
centralized security policy.  Hence, one would be unable to analyze
information flow in the system based solely on the policy and would have
to also analyze the complete filesystem state, and that state is much
more subject to change at runtime than the policy itself (one would
hope).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
