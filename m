Subject: Re: user_trans/user_trans_boolean macro
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1110829277.21378.219.camel@moss-spartans.epoch.ncsc.mil>
References: <1110692016.29852.77.camel@cobra.ivg2.net>
	 <1110804353.21378.8.camel@moss-spartans.epoch.ncsc.mil>
	 <1110820329.16850.8.camel@cobra.ivg2.net>
	 <1110820795.21378.141.camel@moss-spartans.epoch.ncsc.mil>
	 <1110824399.16850.21.camel@cobra.ivg2.net>
	 <1110825077.21378.199.camel@moss-spartans.epoch.ncsc.mil>
	 <1110826572.16850.33.camel@cobra.ivg2.net>
	 <1110829424.16850.39.camel@cobra.ivg2.net>
	 <1110829277.21378.219.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 15:18:20 -0500
Message-Id: <1110831501.16850.47.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I guess what I'm trying to figure out is why 
domain_auto_trans doesn't add the role access rule
by default. Isn't this always necessary if you want
a transition to occur?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
