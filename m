Subject: Re: user_trans/user_trans_boolean macro
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <1110820795.21378.141.camel@moss-spartans.epoch.ncsc.mil>
References: <1110692016.29852.77.camel@cobra.ivg2.net>
	 <1110804353.21378.8.camel@moss-spartans.epoch.ncsc.mil>
	 <1110820329.16850.8.camel@cobra.ivg2.net>
	 <1110820795.21378.141.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 13:13:39 -0500
Message-Id: <1110824019.16850.19.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok, how about this instead - seems more useful

1) Renamed: user_trans -> allow_trans
2) Added role as a separate argument for flexibility
3) Remove boolean macro - declare boolean in the app .te file

#####################################################
#
# allow_trans(prefix, role_prefix, app_prefix)
#
# Transition user:$2_r:$1_t to user:$2_r:$1_$3_t
#
define(`allow_trans', `
role $2_r types $1_$3_t;
if (! disable_$1_$3_transition) {
domain_auto_trans($1_t, $3_exec_t, $1_$3_t)
}
')

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
