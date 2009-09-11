Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8BEMG45011129
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 10:22:16 -0400
Received: from mail.seekline.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8BENaPj016083
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 14:23:37 GMT
Subject: Re: [refpolicy] new policy for dkim-filter
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: Paul Howarth <paul@city-fan.org>, selinux@tycho.nsa.gov
In-Reply-To: <1252672214.2937.8.camel@defiant.pebenito.net>
References: <1252611656.2486.44.camel@vogon.seekline.net>
	 <20090910210421.150ff80f@metropolis.intra.city-fan.org>
	 <1252615167.22997.1.camel@vogon.seekline.net>
	 <1252619448.22997.12.camel@vogon.seekline.net>
	 <20090910232714.2ae22bf2@metropolis.intra.city-fan.org>
	 <1252655581.2491.12.camel@vogon.seekline.net>
	 <1252657231.2491.18.camel@vogon.seekline.net>
	 <1252672214.2937.8.camel@defiant.pebenito.net>
Content-Type: multipart/mixed; boundary="=-vyYN3fdWzA69XIUN3vvS"
Date: Fri, 11 Sep 2009 16:22:01 +0200
Message-Id: <1252678921.2491.51.camel@vogon.seekline.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-vyYN3fdWzA69XIUN3vvS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2009-09-11 at 08:30 -0400, Chris PeBenito wrote:
> On Fri, 2009-09-11 at 10:20 +0200, Stefan Schulze Frielinghaus wrote:
> > > > > > > On Thu, 10 Sep 2009 21:40:56 +0200
> > > > > > > Stefan Schulze Frielinghaus <stefan@seekline.net> wrote:
> > > > > > > 
> > > > > > > > Attached is a new policy for the dkim-filter application.
> > > > > > > > 
> > > > > > > > Chris, is the policy OK/ready for merge?
> 
> > Tested attached policy again on CentOS 5.3 with strict policy.
> 
> It looks ok.  However I'm starting to get concerned about the milter
> module getting big.  If you want, say the spamassassin milter, you add
> the milter module... but then you get rules for a several other milters
> too.

Attached is a milter version which behaves like the apache_template(). I
only took care of the dkim-milter but in general this would only mean
some reorganization of all modules ... nothing more. Any cons about
that?

If this would be the right way then we could also talk about the
milter_template() naming convention:

type $1_milter_t

The apache_template generates slightly different type names:

type httpd_$1_script_t

What about changing $1_milter_t to milter_$1_t?

--=-vyYN3fdWzA69XIUN3vvS
Content-Disposition: attachment; filename="dkim-milter.fc"
Content-Type: text/plain; name="dkim-milter.fc"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

/usr/sbin/dkim-filter		--	gen_context(system_u:object_r:dkim_milter_exec_t,s0)

/var/db/dkim(/.*)?			gen_context(system_u:object_r:dkim_milter_private_key_t,s0)

/var/run/dkim-filter(/.*)?		gen_context(system_u:object_r:dkim_milter_data_t,s0)

--=-vyYN3fdWzA69XIUN3vvS
Content-Disposition: attachment; filename="dkim-milter.te"
Content-Type: text/plain; name="dkim-milter.te"; charset="UTF-8"
Content-Transfer-Encoding: 7bit


policy_module(dkim-milter, 1.0.0)

########################################
#
# Declarations
#

milter_template(dkim)

# Type for the private key of dkim-filter
type dkim_milter_private_key_t;
files_type(dkim_milter_private_key_t)

########################################
#
# Local policy
#

allow dkim_milter_t self:capability { setgid setuid };

read_files_pattern(dkim_milter_t, dkim_milter_private_key_t, dkim_milter_private_key_t)

files_read_etc_files(dkim_milter_t)

kernel_read_kernel_sysctls(dkim_milter_t)

sysnet_dns_name_resolve(dkim_milter_t)

dev_read_urand(dkim_milter_t)

--=-vyYN3fdWzA69XIUN3vvS
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

	type $1_milter_t, milter_domains;
	type $1_milter_exec_t;
	init_daemon_domain($1_milter_t, $1_milter_exec_t)
	role system_r types $1_milter_t;

	# Type for the milter data (e.g. the socket used to communicate with the MTA)
	type $1_milter_data_t, milter_data_type;
	files_type($1_milter_data_t)

	allow $1_milter_t self:fifo_file rw_fifo_file_perms;

	# Allow communication with MTA over a unix-domain socket
	# Note: usage with TCP sockets requires additional policy
	manage_sock_files_pattern($1_milter_t, $1_milter_data_t, $1_milter_data_t)

	# Create other data files and directories in the data directory
	manage_files_pattern($1_milter_t, $1_milter_data_t, $1_milter_data_t)

	miscfiles_read_localization($1_milter_t)

	logging_send_syslog_msg($1_milter_t)
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

--=-vyYN3fdWzA69XIUN3vvS
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

--=-vyYN3fdWzA69XIUN3vvS--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
