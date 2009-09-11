Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8BCUGUm005024
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 08:30:16 -0400
Received: from QMTA09.westchester.pa.mail.comcast.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8BCTZ4H023918
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 12:29:36 GMT
Subject: Re: [refpolicy] new policy for dkim-filter
From: Chris PeBenito <pebenito@gentoo.org>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: Paul Howarth <paul@city-fan.org>, selinux@tycho.nsa.gov
In-Reply-To: <1252657231.2491.18.camel@vogon.seekline.net>
References: <1252611656.2486.44.camel@vogon.seekline.net>
	 <20090910210421.150ff80f@metropolis.intra.city-fan.org>
	 <1252615167.22997.1.camel@vogon.seekline.net>
	 <1252619448.22997.12.camel@vogon.seekline.net>
	 <20090910232714.2ae22bf2@metropolis.intra.city-fan.org>
	 <1252655581.2491.12.camel@vogon.seekline.net>
	 <1252657231.2491.18.camel@vogon.seekline.net>
Content-Type: text/plain
Date: Fri, 11 Sep 2009 08:30:14 -0400
Message-Id: <1252672214.2937.8.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-09-11 at 10:20 +0200, Stefan Schulze Frielinghaus wrote:
> > > > > > On Thu, 10 Sep 2009 21:40:56 +0200
> > > > > > Stefan Schulze Frielinghaus <stefan@seekline.net> wrote:
> > > > > > 
> > > > > > > Attached is a new policy for the dkim-filter application.
> > > > > > > 
> > > > > > > Chris, is the policy OK/ready for merge?

> Tested attached policy again on CentOS 5.3 with strict policy.

It looks ok.  However I'm starting to get concerned about the milter
module getting big.  If you want, say the spamassassin milter, you add
the milter module... but then you get rules for a several other milters
too.

> diff --git a/policy/modules/services/milter.fc
> b/policy/modules/services/milter.fc
> index 55a3e2f..d4494bc 100644
> --- a/policy/modules/services/milter.fc
> +++ b/policy/modules/services/milter.fc
> @@ -1,10 +1,14 @@
> +/usr/sbin/dkim-filter          --      gen_context(system_u:object_r:dkim_milter_exec_t,s0)
>  /usr/sbin/milter-greylist      --      gen_context(system_u:object_r:greylist_milter_exec_t,s0)
> -/usr/sbin/milter-regex                         --      gen_context(system_u:object_r:regex_milter_exec_t,s0)
> +/usr/sbin/milter-regex         --      gen_context(system_u:object_r:regex_milter_exec_t,s0)
>  /usr/sbin/spamass-milter       --      gen_context(system_u:object_r:spamass_milter_exec_t,s0)
>  
> +/var/db/dkim(/.*)?                     gen_context(system_u:object_r:dkim_milter_private_key_t,s0)
> +
>  /var/lib/milter-greylist(/.*)?         gen_context(system_u:object_r:greylist_milter_data_t,s0)
>  /var/lib/spamass-milter(/.*)?          gen_context(system_u:object_r:spamass_milter_state_t,s0)
>  
> +/var/run/dkim-filter(/.*)?             gen_context(system_u:object_r:dkim_milter_data_t,s0)
>  /var/run/milter-greylist(/.*)?         gen_context(system_u:object_r:greylist_milter_data_t,s0)
>  /var/run/milter-greylist
> \.pid  --      gen_context(system_u:object_r:greylist_milter_data_t,s0)
>  /var/run/spamass-milter(/.*)?          gen_context(system_u:object_r:spamass_milter_data_t,s0)
> diff --git a/policy/modules/services/milter.te
> b/policy/modules/services/milter.te
> index ff7cebc..88be485 100644
> --- a/policy/modules/services/milter.te
> +++ b/policy/modules/services/milter.te
> @@ -1,5 +1,5 @@
>  
> -policy_module(milter, 1.1.0)
> +policy_module(milter, 1.2.0)
>  
>  ########################################
>  #
> @@ -10,11 +10,16 @@ policy_module(milter, 1.1.0)
>  attribute milter_domains;
>  attribute milter_data_type;
>  
> -# currently-supported milters are milter-greylist, milter-regex and
> spamass-milter
> +# currently-supported milters are dkim-filter, milter-greylist,
> milter-regex and spamass-milter
> +milter_template(dkim)
>  milter_template(greylist)
>  milter_template(regex)
>  milter_template(spamass)
>  
> +# Type for the private key of dkim-filter
> +type dkim_milter_private_key_t;
> +files_type(dkim_milter_private_key_t)
> +
>  # Type for the spamass-milter home directory, under which
> spamassassin will
>  # store system-wide preferences, bayes databases etc. if not
> configured to
>  # use per-user configuration
> @@ -23,6 +28,25 @@ files_type(spamass_milter_state_t)
>  
>  ########################################
>  #
> +# dkim local policy
> +#   DomainKeys Identified Mail sender authentication
> +#   http://sourceforge.net/projects/dkim-milter/
> +#
> +
> +allow dkim_milter_t self:capability { setgid setuid };
> +
> +read_files_pattern(dkim_milter_t, dkim_milter_private_key_t,
> dkim_milter_private_key_t)
> +
> +files_read_etc_files(dkim_milter_t)
> +
> +kernel_read_kernel_sysctls(dkim_milter_t)
> +
> +sysnet_dns_name_resolve(dkim_milter_t)
> +
> +dev_read_urand(dkim_milter_t)
> +
> +########################################
> +#
>  # milter-greylist local policy
>  #   ensure smtp clients retry mail like real MTAs and not spamware
>  #   http://hcpnet.free.fr/milter-greylist/
> 

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
