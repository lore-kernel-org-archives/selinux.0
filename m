Subject: Re: default user roles
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1203704148.3669.953.camel@bluejay.goodinassociates.com>
References: <1203704148.3669.953.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Fri, 22 Feb 2008 13:55:58 -0500
Message-Id: <1203706558.2804.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-02-22 at 12:15 -0600, Jeremiah Jahn wrote:
> I can't seem to get the login to set the proper initial role for a user.
> Every time I login, I end up as auditadm, and not secstaff.

kernel policy just defines what is allowed, not what is the default, for
user contexts.

The defaults are determined by
examining /etc/selinux/$SELINUXTYPE/contexts/default_contexts
and /etc/selinux/$SELINUXTYPE/contexts/users/<seuser> (optional).

User context computation has been a source of subtle issues in the past;
I'd like to revisit the approach but we haven't gotten around to it.

> I have the following in my policy:
> 
> userdom_unpriv_user_template(secstaff)
> userdom_role_change_template(secstaff, secadm)
> userdom_role_change_template(secstaff, auditadm)
> allow secstaff_t devlog_t:sock_file write;
> allow secstaff_t newrole_t:process { siginh noatsecure rlimitinh };
> allow secstaff_t syslogd_t:unix_dgram_socket sendto;
> allow secstaff_t unconfined_tmp_t:dir { write search rmdir remove_name create getattr add_name };
> allow secstaff_t user_home_dir_t:dir { read getattr search };
> userdom_manage_generic_user_home_content_files(secstaff_t)
> userdom_read_generic_user_home_content_files(secstaff_t)
> 
> ############################################################
> # Set default role for sec staff <-- not quite :)
> #
> role secstaff_r types secstaff_t;
> 
> ############################################################
> # define roles the secstaff can transition to
> #
> user secstaff_u roles { secstaff_r secadm_r auditadm_r } level s0 range s0 - s0;
> 	
> 
> 
> 
> 
> In the olden days in England, you could be hung for stealing a sheep or
> a loaf of bread. However, if a sheep stole a loaf of bread and gave it
> to you, you would only be tried for receiving, a crime punishable by
> forty lashes with the cat or the dog, whichever was handy. If you stole
> a dog and were caught, you were punished with twelve rabbit punches,
> although it was hard to find rabbits big enough or strong enough to
> punch you. -- Mike Harding, "The Armchair Anarchist's Almanac"
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
