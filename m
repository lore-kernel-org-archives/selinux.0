Subject: Re: [ SEPOL ] Check if policy file is MLS enabled
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <438B7549.6000600@cornell.edu>
References: <438452BD.30101@cornell.edu> <43846B71.6000806@tresys.com>
	 <4384732F.90808@cornell.edu>
	 <1133206135.348.222.camel@moss-spartans.epoch.ncsc.mil>
	 <438B7549.6000600@cornell.edu>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 08:34:03 -0500
Message-Id: <1133271243.26593.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-28 at 16:23 -0500, Ivan Gyurdiev wrote:
> We could put the fields that get_package_info returns into a structure, 
> and add the mls status to those?

I'd just add it as an extra argument to sepol_module_package_info, or
add a separate interface for it.  Structure doesn't really buy you
anything.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
