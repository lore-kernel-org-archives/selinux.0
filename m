Subject: Re: user_trans/user_trans_boolean macro
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <1110824399.16850.21.camel@cobra.ivg2.net>
References: <1110692016.29852.77.camel@cobra.ivg2.net>
	 <1110804353.21378.8.camel@moss-spartans.epoch.ncsc.mil>
	 <1110820329.16850.8.camel@cobra.ivg2.net>
	 <1110820795.21378.141.camel@moss-spartans.epoch.ncsc.mil>
	 <1110824399.16850.21.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 13:31:23 -0500
Message-Id: <1110825083.16850.25.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-14 at 13:19 -0500, Ivan Gyurdiev wrote:
> 3) Remove boolean macro - declare boolean in the app .te file
> 
> Well, declaring the boolean in the .te file doesn't work because of duplicates..
> So, I'll make a macro called user_boolean that just declares that boolean
> conditional on the if statement.
> 
> Anyway, what is the purpose of those booleans? Why do we not want to transition
> to the target domain?

... and doesn't this work?

if (! disable_user_app_transition) {
bool disable_user_app_transition false;
}

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
