Subject: Multiple contexts
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: SELinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
Content-Type: text/plain
Date: Mon, 10 Jan 2005 13:50:49 -0700
Message-Id: <1105390249.8093.21.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why doesn't SElinux support multiple contexts per file?
It seems to me that this feature would be very useful. 
Is this technically not feasible?

I've been trying to get the following setup working on FC3 (rawhide):

/var/www/html.userX  - 
	virtual server for userX.mydomain labeled httpd_sys_content_t
/home/userX - 
	home folder for userX, exported via Samba (not yet, but
	it will be, once dwalsh puts in booleans for samba reading home)

/home/userX/webserver - symlink to /var/www/html.userX 

Now, /var/www/html.userX needs to be accessed both by smbd and httpd.
I need to label it with both samba_share_t and httpd_sys_content_t.

I have to edit the cryptic m4 policy file to add a type that's
accessible by both. Why is this necessary? Why can't selinux
either
	(1) Label the file with both contexts, and permit
	the operation if any context permits it

	or
		
	(2) Create a type with the properties of both
	with less user interaction (without needing to 
	modify the policy manually)

Since I'm unfamiliar with how SElinux works internally,
this might be a stupid question, but it seems to me that 
the user should not be required to understand how a policy
file works to label a file for use by two restricted programs.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
