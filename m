Subject: Re: user_trans/user_trans_boolean macro
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <1110826572.16850.33.camel@cobra.ivg2.net>
References: <1110692016.29852.77.camel@cobra.ivg2.net>
	 <1110804353.21378.8.camel@moss-spartans.epoch.ncsc.mil>
	 <1110820329.16850.8.camel@cobra.ivg2.net>
	 <1110820795.21378.141.camel@moss-spartans.epoch.ncsc.mil>
	 <1110824399.16850.21.camel@cobra.ivg2.net>
	 <1110825077.21378.199.camel@moss-spartans.epoch.ncsc.mil>
	 <1110826572.16850.33.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 14:43:44 -0500
Message-Id: <1110829424.16850.39.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm improving this macro with the purpose of using it in a lot of
places (couples role/trans role, provides controlling boolean - seems
beneficial)

I have a question, however - why is it that role declarations do not
tolerate duplicates. I've noticed allow/dontaudit rules are tolerant
to duplicates. 

New version: 

#####################################################
#
# allow_trans(prefix, role_prefix, app_prefix, exec_types)
#
# Transition user:$2_r:$1_t to user:$2_r:$1_$3_t on exec_types
#
define(`allow_trans', `
role $2_r types $1_$3_t;
if (! disable_$1_$3_trans) {
ifelse($4, `', `
domain_auto_trans($1_t, $3_exec_t, $1_$3_t)
',
domain_auto_trans($1_t, $4, $1_$3_t)
')
}
')



-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
