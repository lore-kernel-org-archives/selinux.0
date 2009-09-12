Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8CCo0KK005935
	for <selinux@tycho.nsa.gov>; Sat, 12 Sep 2009 08:50:00 -0400
Received: from mail.seekline.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8CCpLes007969
	for <selinux@tycho.nsa.gov>; Sat, 12 Sep 2009 12:51:22 GMT
Subject: Re: [refpolicy] new policy for dkim-filter
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: Paul Howarth <paul@city-fan.org>
Cc: Chris PeBenito <pebenito@gentoo.org>, selinux@tycho.nsa.gov
In-Reply-To: <4AAA6A3A.9080202@city-fan.org>
References: <1252611656.2486.44.camel@vogon.seekline.net>
	 <20090910210421.150ff80f@metropolis.intra.city-fan.org>
	 <1252615167.22997.1.camel@vogon.seekline.net>
	 <1252619448.22997.12.camel@vogon.seekline.net>
	 <20090910232714.2ae22bf2@metropolis.intra.city-fan.org>
	 <1252655581.2491.12.camel@vogon.seekline.net>
	 <1252657231.2491.18.camel@vogon.seekline.net>
	 <1252672214.2937.8.camel@defiant.pebenito.net>
	 <1252678921.2491.51.camel@vogon.seekline.net>
	 <4AAA6A3A.9080202@city-fan.org>
Content-Type: multipart/mixed; boundary="=-4nM1TMIKau9nJWrqr28v"
Date: Sat, 12 Sep 2009 14:49:38 +0200
Message-Id: <1252759779.2491.13.camel@vogon.seekline.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-4nM1TMIKau9nJWrqr28v
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2009-09-11 at 16:18 +0100, Paul Howarth wrote:
> On 11/09/09 15:22, Stefan Schulze Frielinghaus wrote:
> > On Fri, 2009-09-11 at 08:30 -0400, Chris PeBenito wrote:
> >> On Fri, 2009-09-11 at 10:20 +0200, Stefan Schulze Frielinghaus wrote:
> >>>>>>>> On Thu, 10 Sep 2009 21:40:56 +0200
> >>>>>>>> Stefan Schulze Frielinghaus<stefan@seekline.net>  wrote:
> >>>>>>>>
> >>>>>>>>> Attached is a new policy for the dkim-filter application.
> >>>>>>>>>
> >>>>>>>>> Chris, is the policy OK/ready for merge?
> >>
> >>> Tested attached policy again on CentOS 5.3 with strict policy.
> >>
> >> It looks ok.  However I'm starting to get concerned about the milter
> >> module getting big.  If you want, say the spamassassin milter, you add
> >> the milter module... but then you get rules for a several other milters
> >> too.
> 
> True, but how much of a problem is that, given that any milter user is 
> at least going to have also the sendmail/postfix policy and the mta 
> policy too?

It's not a huge problem but I prefer only to install policy modules I
really need. Everything else is disabled. Also this approach is more
compliant with the minimal policy:
http://danwalsh.livejournal.com/26759.html

> 
> > Attached is a milter version which behaves like the apache_template(). I
> > only took care of the dkim-milter but in general this would only mean
> > some reorganization of all modules ... nothing more. Any cons about
> > that?
> 
> Splitting each milter out into its own module is certainly do-able; 
> doesn't that add overhead (from having more modules) as well though?

Hmm I don't think this will be a problem. I believe it is even easier to
manage. If they are separated in several files it's easier to handle
them (if there exist really dozens of them).

> 
> > If this would be the right way then we could also talk about the
> > milter_template() naming convention:
> >
> > type $1_milter_t
> >
> > The apache_template generates slightly different type names:
> >
> > type httpd_$1_script_t
> >
> > What about changing $1_milter_t to milter_$1_t?
> 
> That would make sense given that most types in refpolicy are prefixed 
> with the module name. There would need to be typealiases added though 
> for the old names for the benefit of existing users, wouldn't there?

Good point. I created a couple of aliases.

Attached is the milter policy with all four modules. What do you think
about this approach, Paul, Chris?

Tested again on CentOS 5.3 with strict policy.

--=-4nM1TMIKau9nJWrqr28v
Content-Disposition: attachment; filename="milter.if"
Content-Type: text/plain; name="milter.if"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

## <summary>Milter mail filters</summary>

########################################
## <summary>
##	Create a set of derived types for various
##	mail filter applications using the milter interface.
## </summary>
## <param name="milter_name">
##	<summary>
##	The name to be used for deriving type names.
##	</summary>
## </param>
#
template(`milter_template',`
	# attributes common to all milters
	gen_require(`
		attribute milter_data_type, milter_domains;
	')

	type milter_$1_t alias $1_milter_t, milter_domains;
	type milter_$1_exec_t alias $1_milter_exec_t;
	init_daemon_domain(milter_$1_t, milter_$1_exec_t)

	# Type for the milter data (e.g. the socket used to communicate with the MTA)
	type milter_$1_data_t alias $1_milter_data_t, milter_data_type;
	files_type(milter_$1_data_t)

	allow milter_$1_t self:fifo_file rw_fifo_file_perms;

	# Allow communication with MTA over a unix-domain socket
	# Note: usage with TCP sockets requires additional policy
	manage_sock_files_pattern(milter_$1_t, milter_$1_data_t, milter_$1_data_t)

	# Create other data files and directories in the data directory
	manage_files_pattern(milter_$1_t, milter_$1_data_t, milter_$1_data_t)

	miscfiles_read_localization(milter_$1_t)

	logging_send_syslog_msg(milter_$1_t)
')

########################################
## <summary>
##	MTA communication with milter sockets
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`milter_stream_connect_all',`
	gen_require(`
		attribute milter_data_type, milter_domains;
	')

	getattr_dirs_pattern($1, milter_data_type, milter_data_type)
	stream_connect_pattern($1, milter_data_type, milter_data_type, milter_domains)
')

########################################
## <summary>
##	Allow getattr of milter sockets
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`milter_getattr_all_sockets',`
	gen_require(`
		attribute milter_data_type;
	')

	getattr_dirs_pattern($1, milter_data_type, milter_data_type)
	getattr_sock_files_pattern($1, milter_data_type, milter_data_type)
')

--=-4nM1TMIKau9nJWrqr28v
Content-Disposition: attachment; filename="milter.te"
Content-Type: text/plain; name="milter.te"; charset="UTF-8"
Content-Transfer-Encoding: 7bit


policy_module(milter, 1.2.0)

########################################
#
# Declarations
#

# attributes common to all milters
attribute milter_domains;
attribute milter_data_type;

--=-4nM1TMIKau9nJWrqr28v
Content-Disposition: attachment; filename="milter_dkim.fc"
Content-Type: text/plain; name="milter_dkim.fc"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

/usr/sbin/dkim-filter		--	gen_context(system_u:object_r:milter_dkim_exec_t,s0)

/var/db/dkim(/.*)?			gen_context(system_u:object_r:milter_dkim_private_key_t,s0)

/var/run/dkim-filter(/.*)?		gen_context(system_u:object_r:milter_dkim_data_t,s0)

--=-4nM1TMIKau9nJWrqr28v
Content-Disposition: attachment; filename="milter_dkim.te"
Content-Type: text/plain; name="milter_dkim.te"; charset="UTF-8"
Content-Transfer-Encoding: 7bit


policy_module(milter_dkim, 1.0.0)

########################################
#
# Declarations
#

milter_template(dkim)

# Type for the private key of dkim-filter
type milter_dkim_private_key_t;
files_type(milter_dkim_private_key_t)

########################################
#
# Local policy
#

allow milter_dkim_t self:capability { setgid setuid };

read_files_pattern(milter_dkim_t, milter_dkim_private_key_t, milter_dkim_private_key_t)

files_read_etc_files(milter_dkim_t)

kernel_read_kernel_sysctls(milter_dkim_t)

sysnet_dns_name_resolve(milter_dkim_t)

dev_read_urand(milter_dkim_t)

--=-4nM1TMIKau9nJWrqr28v
Content-Disposition: attachment; filename="milter_greylist.fc"
Content-Type: text/plain; name="milter_greylist.fc"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

/usr/sbin/milter-greylist	--	gen_context(system_u:object_r:milter_greylist_exec_t,s0)

/var/lib/milter-greylist(/.*)?		gen_context(system_u:object_r:milter_greylist_data_t,s0)

/var/run/milter-greylist(/.*)?		gen_context(system_u:object_r:milter_greylist_data_t,s0)
/var/run/milter-greylist\.pid	--	gen_context(system_u:object_r:milter_greylist_data_t,s0)

--=-4nM1TMIKau9nJWrqr28v
Content-Disposition: attachment; filename="milter_greylist.te"
Content-Type: text/plain; name="milter_greylist.te"; charset="UTF-8"
Content-Transfer-Encoding: 7bit


policy_module(milter_greylist, 1.0.0)

########################################
#
# Declarations
#

milter_template(greylist)

########################################
#
# Local policy
#

# It removes any existing socket (not owned by root) whilst running as root,
# fixes permissions, renices itself and then calls setgid() and setuid() to
# drop privileges
allow milter_greylist_t self:capability { chown dac_override setgid setuid sys_nice };
allow milter_greylist_t self:process { setsched getsched };

# It creates a pid file /var/run/milter-greylist.pid
files_pid_filetrans(milter_greylist_t, milter_greylist_data_t, file)

kernel_read_kernel_sysctls(milter_greylist_t)

# Allow the milter to read a GeoIP database in /usr/share
files_read_usr_files(milter_greylist_t)
# The milter runs from /var/lib/milter-greylist and maintains files there
files_search_var_lib(milter_greylist_t)

# Look up username for dropping privs
auth_use_nsswitch(milter_greylist_t)

# Config is in /etc/mail/greylist.conf
mta_read_config(milter_greylist_t)

--=-4nM1TMIKau9nJWrqr28v
Content-Disposition: attachment; filename="milter_regex.fc"
Content-Type: text/plain; name="milter_regex.fc"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

/usr/sbin/milter-regex		--	gen_context(system_u:object_r:milter_regex_exec_t,s0)

/var/spool/milter-regex(/.*)?		gen_context(system_u:object_r:milter_regex_data_t,s0)

--=-4nM1TMIKau9nJWrqr28v
Content-Disposition: attachment; filename="milter_regex.te"
Content-Type: text/plain; name="milter_regex.te"; charset="UTF-8"
Content-Transfer-Encoding: 7bit


policy_module(milter_regex, 1.0.0)

########################################
#
# Declarations
#

milter_template(regex)

########################################
#
# Local policy
#

# It removes any existing socket (not owned by root) whilst running as root
# and then calls setgid() and setuid() to drop privileges
allow milter_regex_t self:capability { setuid setgid dac_override };

# The milter's socket directory lives under /var/spool
files_search_spool(milter_regex_t)

# Look up username for dropping privs
auth_use_nsswitch(milter_regex_t)

# Config is in /etc/mail/milter-regex.conf
mta_read_config(milter_regex_t)

--=-4nM1TMIKau9nJWrqr28v
Content-Disposition: attachment; filename="milter_spamass.fc"
Content-Type: text/plain; name="milter_spamass.fc"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

/usr/sbin/spamass-milter	--	gen_context(system_u:object_r:milter_spamass_exec_t,s0)

/var/lib/spamass-milter(/.*)?		gen_context(system_u:object_r:milter_spamass_state_t,s0)

/var/run/spamass-milter(/.*)?		gen_context(system_u:object_r:milter_spamass_data_t,s0)

--=-4nM1TMIKau9nJWrqr28v
Content-Disposition: attachment; filename="milter_spamass.if"
Content-Type: text/plain; name="milter_spamass.if"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

## <summary>spamassassin milter</summary>

########################################
## <summary>
##	Manage spamassassin milter state
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`milter_manage_spamass_state',`
	gen_require(`
		type milter_spamass_state_t;
	')

	files_search_var_lib($1)
	manage_files_pattern($1, milter_spamass_state_t, milter_spamass_state_t)
	manage_dirs_pattern($1, milter_spamass_state_t, milter_spamass_state_t)
	manage_lnk_files_pattern($1, milter_spamass_state_t, milter_spamass_state_t)
')

--=-4nM1TMIKau9nJWrqr28v
Content-Disposition: attachment; filename="milter_spamass.te"
Content-Type: text/plain; name="milter_spamass.te"; charset="UTF-8"
Content-Transfer-Encoding: 7bit


policy_module(milter_spamass, 1.0.0)

########################################
#
# Declarations
#
milter_template(spamass)

# Type for the spamass-milter home directory, under which spamassassin will
# store system-wide preferences, bayes databases etc. if not configured to
# use per-user configuration
type milter_spamass_state_t;
files_type(milter_spamass_state_t)

########################################
#
# Local policy
#

# The milter runs from /var/lib/spamass-milter
allow milter_spamass_t milter_spamass_state_t:dir search_dir_perms;
files_search_var_lib(milter_spamass_t)

kernel_read_system_state(milter_spamass_t)

# When used with -b or -B options, the milter invokes sendmail to send mail
# to a spamtrap address, using popen()
corecmd_exec_shell(milter_spamass_t)
corecmd_read_bin_symlinks(milter_spamass_t)
corecmd_search_bin(milter_spamass_t)

mta_send_mail(milter_spamass_t)

# The main job of the milter is to pipe spam through spamc and act on the result
spamassassin_domtrans_client(milter_spamass_t)

--=-4nM1TMIKau9nJWrqr28v--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
