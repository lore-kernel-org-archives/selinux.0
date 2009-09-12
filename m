Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8CEwRIS018146
	for <selinux@tycho.nsa.gov>; Sat, 12 Sep 2009 10:58:27 -0400
Received: from mail.seekline.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8CEvjYV029181
	for <selinux@tycho.nsa.gov>; Sat, 12 Sep 2009 14:57:46 GMT
Subject: Re: [refpolicy] new policy for dkim-filter
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: Paul Howarth <paul@city-fan.org>
Cc: Chris PeBenito <pebenito@gentoo.org>, selinux@tycho.nsa.gov
In-Reply-To: <1252759779.2491.13.camel@vogon.seekline.net>
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
	 <1252759779.2491.13.camel@vogon.seekline.net>
Content-Type: multipart/mixed; boundary="=-GKFSZCBrZQF7tmvBvjlh"
Date: Sat, 12 Sep 2009 16:58:12 +0200
Message-Id: <1252767492.2491.15.camel@vogon.seekline.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-GKFSZCBrZQF7tmvBvjlh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2009-09-12 at 14:49 +0200, Stefan Schulze Frielinghaus wrote:
> On Fri, 2009-09-11 at 16:18 +0100, Paul Howarth wrote:
> > On 11/09/09 15:22, Stefan Schulze Frielinghaus wrote:
> > > On Fri, 2009-09-11 at 08:30 -0400, Chris PeBenito wrote:
> > >> On Fri, 2009-09-11 at 10:20 +0200, Stefan Schulze Frielinghaus wrote:
> > >>>>>>>> On Thu, 10 Sep 2009 21:40:56 +0200
> > >>>>>>>> Stefan Schulze Frielinghaus<stefan@seekline.net>  wrote:
> > >>>>>>>>
> > >>>>>>>>> Attached is a new policy for the dkim-filter application.
> > >>>>>>>>>
> > >>>>>>>>> Chris, is the policy OK/ready for merge?
> > >>
> > >>> Tested attached policy again on CentOS 5.3 with strict policy.
> > >>
> > >> It looks ok.  However I'm starting to get concerned about the milter
> > >> module getting big.  If you want, say the spamassassin milter, you add
> > >> the milter module... but then you get rules for a several other milters
> > >> too.
> > 
> > True, but how much of a problem is that, given that any milter user is 
> > at least going to have also the sendmail/postfix policy and the mta 
> > policy too?
> 
> It's not a huge problem but I prefer only to install policy modules I
> really need. Everything else is disabled. Also this approach is more
> compliant with the minimal policy:
> http://danwalsh.livejournal.com/26759.html
> 
> > 
> > > Attached is a milter version which behaves like the apache_template(). I
> > > only took care of the dkim-milter but in general this would only mean
> > > some reorganization of all modules ... nothing more. Any cons about
> > > that?
> > 
> > Splitting each milter out into its own module is certainly do-able; 
> > doesn't that add overhead (from having more modules) as well though?
> 
> Hmm I don't think this will be a problem. I believe it is even easier to
> manage. If they are separated in several files it's easier to handle
> them (if there exist really dozens of them).
> 
> > 
> > > If this would be the right way then we could also talk about the
> > > milter_template() naming convention:
> > >
> > > type $1_milter_t
> > >
> > > The apache_template generates slightly different type names:
> > >
> > > type httpd_$1_script_t
> > >
> > > What about changing $1_milter_t to milter_$1_t?
> > 
> > That would make sense given that most types in refpolicy are prefixed 
> > with the module name. There would need to be typealiases added though 
> > for the old names for the benefit of existing users, wouldn't there?
> 
> Good point. I created a couple of aliases.
> 
> Attached is the milter policy with all four modules. What do you think
> about this approach, Paul, Chris?
> 
> Tested again on CentOS 5.3 with strict policy.

Argl, never say never ... I've installed the latest dkim-milter package
from EPEL and some file locations changed. Attached policy for
milter_dkim fixes this ;-)

Tested again on CentOS 5.3 with strict policy.

--=-GKFSZCBrZQF7tmvBvjlh
Content-Disposition: attachment; filename="milter_dkim.fc"
Content-Type: text/plain; name="milter_dkim.fc"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

/etc/mail/dkim-milter/keys(/.*)		gen_context(system_u:object_r:milter_dkim_private_key_t,s0)

/usr/sbin/dkim-filter		--	gen_context(system_u:object_r:milter_dkim_exec_t,s0)

/var/db/dkim(/.*)?			gen_context(system_u:object_r:milter_dkim_private_key_t,s0)

/var/run/dkim-filter(/.*)?		gen_context(system_u:object_r:milter_dkim_data_t,s0)
/var/run/dkim-milter(/.*)?		gen_context(system_u:object_r:milter_dkim_data_t,s0)
/var/run/dkim-milter\.pid	--	gen_context(system_u:object_r:milter_dkim_data_t,s0)

--=-GKFSZCBrZQF7tmvBvjlh
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

mta_read_config(milter_dkim_t)

--=-GKFSZCBrZQF7tmvBvjlh--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
