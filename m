Subject: Re: get_default_context_with_level seems to be broken in
	libselinux.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45D084AF.8020405@redhat.com>
References: <45D084AF.8020405@redhat.com>
Content-Type: text/plain
Date: Mon, 12 Feb 2007 11:16:09 -0500
Message-Id: <1171296969.5265.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-12 at 10:15 -0500, Daniel J Walsh wrote:
> Bugzilla's 211827 224637 
> <https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=224637>
> 
> Show that the values after the comma are being dropped.
> 
> Adding the attached patch fixes the problem.
> 
> But I am not sure of the intended use of this code.  The current code 
> does not work and looks like it never worked.  Was there an intention 
> that this would work differently?

If there is a bug, it needs to be fixed within
get_ordered_context_list_with_level, not here.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
