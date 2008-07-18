Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6ICxAT4011277
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 08:59:10 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m6ICx9Go001547
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 12:59:09 GMT
Subject: Re: [refpolicy] Milter Mail Filters
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Howarth <paul@city-fan.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <484D4B53.5020006@city-fan.org>
References: <484D4B53.5020006@city-fan.org>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 08:58:42 -0400
Message-Id: <1216385922.21191.125.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-06-09 at 16:25 +0100, Paul Howarth wrote:
> Hi,
> 
> attached is a patch based on local policy I'm using on Fedora 9 to 
> support two "milter" mail filter daemons in conjunction with
> sendmail, 
> namely spamass-milter and milter-regex (I maintain the packages for
> both 
> of these in Fedora).
> 
> I've taken the view that most milter applications will have similar 
> requirements and so I've created a milter_template interface that 
> contains most of what's needed, and then added the specifics that are 
> needed on top of the generic stuff for each application.
> 
> However, as I'm by no means an selinux expert, there are a number of 
> things I'm unsure about:
> 
> 1. In a situation where sendmail is the running MTA on a system, what
> is 
> the difference between sendmail_t and system_mail_t?
> 
> 2. MTAs other than sendmail (postfix comes to mind) can also use 
> milters, but as I don't have any boxes running postfix, I don't know 
> what I'd need to add to postfix policy to support milters.
> 
> 3. Fedora 9 has an interface spamassassin_domtrans_spamc that I used
> in 
> my local policy. It doesn't appear to be present in refpolicy; what 
> would be the right thing to use for a daemon calling spamc?
> 
> 4. I cribbed the milter_port_t stuff from the only example I could
> find, 
> and it's probably wrong. What would be the correct way of defining
> this?
> 
> 5. Does the use of a template for these applications a sane way to do
> it?
> 
> Paul.
> 
> 
> 
> 
> 
> 
> 
> plain text
> document
> attachment
> (milters.patch)
> 
> Index: policy/modules/services/milters.te
> ===================================================================
> --- policy/modules/services/milters.te  (revision 0)
> +++ policy/modules/services/milters.te  (revision 0)
> @@ -0,0 +1,44 @@
> +policy_module(milters,0.0.7)
> +
> +require {
> +       attribute port_type;
> +}
> +
> +type milter_port_t, port_type;

This declaration would move to corenetwork

> +#============= milter-regex policy ==============
> +milter_template(regex)

As I mentioned before, it doesn't look like a template is needed, unless
you think there will be many more milter domains.  Then put all the
declarations in a section.

> +# Config is in /etc/mail/milter-regex.conf
> +mta_read_config(milter_regex_t)
> +
> +# The milter creates a socket in /var/spool/milter-regex/
> +# for communication with sendmail
> +files_search_spool(milter_regex_t)
> +manage_sock_files_pattern(milter_regex_t,milter_regex_spool_t,milter_regex_spool_t)

If the /var/sool/milter-regex directory can be created by the milter,
then there should be a files_spool_filetrans().  If you think templates
are warranted, then it would seem that this should go into the template

> +
> +# It removes any existing socket (not owned by root) whilst running
> as root
> +# and then calls setgid() and setuid() to drop privileges
> +allow milter_regex_t self:capability { setuid setgid dac_override };
> +
> +
> +#============= spamass-milter policy ==============
> +milter_template(spamass)
> +
> +# The milter creates a socket in /var/run/spamass-milter/
> +# for communication with sendmail
> +manage_files_pattern(milter_spamass_t,milter_spamass_var_run_t,milter_spamass_var_run_t)
> +manage_sock_files_pattern(milter_spamass_t,milter_spamass_var_run_t,milter_spamass_var_run_t)
> +
> +# The main job of the milter is to pipe spam through spamc and act on
> the result
> +#
> +# The spamassassin_domtrans_spamc interface in Fedora 9 ???
> +#spamassassin_domtrans_spamc(milter_spamass_t)
> +
> +# When used with -b or -B options, the milter invokes sendmail to
> send mail
> +# to a spamtrap address, using popen()
> +corecmd_exec_shell(milter_spamass_t)
> +corecmd_read_bin_symlinks(milter_spamass_t)
> +corecmd_search_bin(milter_spamass_t)
> +kernel_read_system_state(milter_spamass_t)
> +mta_send_mail(milter_spamass_t)

Similar comments as the previous domain.

> --- policy/modules/services/sendmail.te (revision 2710)
> +++ policy/modules/services/sendmail.te (working copy)
> @@ -112,6 +112,14 @@
>  ')
>  
>  optional_policy(`
> +       milter_regex_stream_connect(sendmail_t)
> +')
> +
> +optional_policy(`
> +       milter_spamass_stream_connect(sendmail_t)
> +')

Perhaps this should be a single milter_stream_connect_all(), since it
seems like sendmail would want to connect to all milters.


> --- policy/modules/services/milters.fc  (revision 0)
> +++ policy/modules/services/milters.fc  (revision 0)
> @@ -0,0 +1,14 @@
> +#================= contexts for milter-regex =================
> +
> +/usr/sbin/milter-regex         --      gen_context(system_u:object_r:milter_regex_exec_t,s0)
> +
> +/var/spool/milter-regex(/.*)?          gen_context(system_u:object_r:milter_regex_spool_t,s0)
> +
> +#================= contexts for spamass-milter =================
> +
> +/usr/sbin/spamass-milter       --      gen_context(system_u:object_r:milter_spamass_exec_t,s0)
> +
> +/var/run/spamass-milter
> \.pid   --      gen_context(system_u:object_r:milter_spamass_var_run_t,s0)
> +/var/run/spamass-milter(/.*)?          gen_context(system_u:object_r:milter_spamass_var_run_t,s0)

The comments don't really add anything here IMO.


> +template(`milter_template',`
[...]
> +       # This type is for pidfiles etc.
> +       type milter_$1_var_run_t;
> +       files_type(milter_$1_var_run_t);
> +
> +       # This type is for spool/cache data etc.
> +       type milter_$1_cache_t;
> +       files_type(milter_$1_cache_t);
> +
> +       # This type is for spool/cache data etc.
> +       type milter_$1_spool_t;
> +       files_type(milter_$1_spool_t);
> +
> +       # This type is for state data etc.
> +       type milter_$1_var_lib_t;
> +       files_type(milter_$1_var_lib_t);

Most of these types aren't used, so they should be dropped.

> +interface(`milter_spamass_stream_connect',`
> +       gen_require(`
> +               type milter_spamass_var_run_t, milter_spamass_t;
> +       ')
> +       stream_connect_pattern($1,milter_spamass_var_run_t,milter_spamass_var_run_t,milter_spamass_t)
> +')
> +

Missing a files_search_spool().  Interface name needs to be fixed [1].

> +interface(`milter_spamass_rw_stream_sockets',`
> +        gen_require(`
> +                type milter_spamass_t;
> +        ')
> +
> +       allow $1 milter_spamass_t:unix_stream_socket { read write };
> +')

Interface naming fix.


> +interface(`milter_regex_stream_connect',`
> +       gen_require(`
> +               type milter_regex_spool_t, milter_regex_t;
> +       ')
> +       stream_connect_pattern($1,milter_regex_spool_t,milter_regex_spool_t,milter_regex_t)
> +')

Also missing a files_search_spool() and interface naming fix.


[1] http://oss.tresys.com/projects/refpolicy/wiki/InterfaceNaming

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
