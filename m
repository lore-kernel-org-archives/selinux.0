Subject: Re: user_trans/user_trans_boolean macro
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <1110824399.16850.21.camel@cobra.ivg2.net>
References: <1110692016.29852.77.camel@cobra.ivg2.net>
	 <1110804353.21378.8.camel@moss-spartans.epoch.ncsc.mil>
	 <1110820329.16850.8.camel@cobra.ivg2.net>
	 <1110820795.21378.141.camel@moss-spartans.epoch.ncsc.mil>
	 <1110824399.16850.21.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 13:31:17 -0500
Message-Id: <1110825077.21378.199.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-14 at 13:19 -0500, Ivan Gyurdiev wrote:
> 3) Remove boolean macro - declare boolean in the app .te file
> 
> Well, declaring the boolean in the .te file doesn't work because of duplicates..
> So, I'll make a macro called user_boolean that just declares that boolean
> conditional on the if statement.

Sorry, why can't you declare the boolean in the allow_trans macro?  And
what do you mean declares it conditional?

> Anyway, what is the purpose of those booleans? Why do we not want to transition
> to the target domain?

I think that Dan set them up to allow the option of running programs
directly in the user's domain, similar to how daemon transitions can be
disabled to leave them unconfined in the targeted policy.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
