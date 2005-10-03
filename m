Subject: Re: [PATCH] mls in modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux-dev@tresys.com, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <434165E3.5050804@tresys.com>
References: <1128112952.22583.25.camel@twoface.columbia.tresys.com>
	 <1128353485.26285.119.camel@moss-spartans.epoch.ncsc.mil>
	 <434165E3.5050804@tresys.com>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 15:32:21 -0400
Message-Id: <1128367941.26285.237.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-03 at 13:09 -0400, Joshua Brindle wrote:
> This is on the list to do but is currently low priority. There are no 
> plans to add this for FC5. As long as all users are added through the 
> user files (system.user and local.user), it should not be necessary to 
> add users in modules. Note, users with levels can be in the base module 
> so the failsafe users will still be in the policy. If you disagree with 
> the need for this please let us know.

This seems workable, but important to know for the corresponding
libsemanage functionality for manipulating users.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
