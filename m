Subject: RE: Alternative user management approach
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <1119640914.31852.87.camel@celtics.boston.redhat.com>
References: <200506241836.j5OIaJqc018526@gotham.columbia.tresys.com>
	 <1119639668.12865.141.camel@moss-spartans.epoch.ncsc.mil>
	 <1119640914.31852.87.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 15:40:11 -0400
Message-Id: <1119642011.12865.168.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 15:21 -0400, Ivan Gyurdiev wrote:
> So... would this be accomplished by changing security_compute_user
> to map between DAC uid and selinux uid before writing
> to /selinux/user ?
> 
> Where would the remap occur...

In get_ordered_context_list, prior to calling security_compute_user.
get_ordered_context_list would look up the username (or some combination
of the username and its associated group set) in the new config file to
find the SELinux username aka role class, and then call
security_compute_user with that role class.  You'd then drop the
hardcoded fallback to SELINUX_DEFAULTUSER aka user_u, as that could be
specified in the config file instead.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
