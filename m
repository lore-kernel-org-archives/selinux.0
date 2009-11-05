Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nA59dKuL009462
	for <selinux@tycho.nsa.gov>; Thu, 5 Nov 2009 04:39:20 -0500
Received: from ey-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nA59cK40003552
	for <selinux@tycho.nsa.gov>; Thu, 5 Nov 2009 09:38:21 GMT
Received: by ey-out-1920.google.com with SMTP id 3so1686723eyh.32
        for <selinux@tycho.nsa.gov>; Thu, 05 Nov 2009 01:39:17 -0800 (PST)
Subject: Re: "security_compute_sid: invalid context" error when
 starting/stopping mysqld daemon
From: Dominick Grift <domg472@gmail.com>
To: Larry Ross <selinux.larry@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <81092d890911041557u78860e4ar65d2a1eb6964656e@mail.gmail.com>
References: <81092d890911041557u78860e4ar65d2a1eb6964656e@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Nov 2009 10:39:14 +0100
Message-Id: <1257413954.3483.4.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-11-04 at 15:57 -0800, Larry Ross wrote:
> I have two selinux users that need to be able to stop and start the
> mysql daemon, which is started by the initialization scripts.  When
> the daemon is stopped and started by the secadm_u user, it ends up in
> the context secadm_u:secadm_r:mysqld_t.  When it is stopped and
> started by the dbadm_u user, it ends up in the
> dbadm_u:dbadm_r:mysqld_t context.  When it is started by the init
> scripts it ends up in the system_u:system_r:mysqld_t domain.
>  
> I would like it to alway end up in the system_r:mysqld_t domain, but
> can't seem to find any documentation that describes how to get that to
> work.
>  
> If I add a role_transition rule to transition the role to system_r
> when the executable is run:
> role_transition sysadm_r mysqld_safe_exec_t system_r;
> role_transition dbadm_r  mysqld_safe_exec_t system_r;
> 
> I end up getting these errors:
>  
> Nov  4 15:41:36 localhost kernel: type=1401 audit(1257378096.775:46):
> security_compute_sid:  invalid context
> dbadm_u:system_r:mysqld_safe_t:s0 for
> scontext=dbadm_u:dbadm_r:initrc_t:s0
> tcontext=system_u:object_r:mysqld_safe_exec_t:s0 tclass=process
> 
>  
> I believe I have the rules that should allow this, but obviously I am
> missing something.
> role dbadm_r types mysqld_safe_t;
> role sysadm_r types mysqld_safe_t;
> role system_r types mysqld_safe_t;
> 
> and this:
> allow initrc_t mysqld_safe_t : process transition ;
> which is what the "security_compute_sid" message looks like it is
> missing.
>  
> Does anyone know where I can find a good description of how to get a
> service to transistion back into system_r when started by a user or
> have any idea what I am missing?

I am not sure but i believe that this piece of policy takes care of the
init scipt stuff for restricted administators (example from apache).

	init_labeled_script_domtrans($1, httpd_initrc_exec_t)
	domain_system_change_exemption($1)
	role_transition $2 httpd_initrc_exec_t system_r;
	allow $2 system_r;

You could basically replace the httpd specifics, and the $1 (domain),
and $2 (role).

Also make sure that you map the system_r role to your seuser.

hth, 
>   Thank you,
>   Larry
>  



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
