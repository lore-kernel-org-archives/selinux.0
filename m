Subject: Re: /dev/pts/x use denials
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1112629380.29574.6.camel@cobra.ivg2.net>
References: <1112569241.21383.37.camel@cobra.ivg2.net>
	 <1112627593.7629.89.camel@moss-spartans.epoch.ncsc.mil>
	 <1112629380.29574.6.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 11:39:26 -0400
Message-Id: <1112629166.7629.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-04-04 at 11:43 -0400, Ivan Gyurdiev wrote:
> > I do see staff_t fd's, but that
> > just shows that the descriptor was opened by a staff_t process and then
> > inherited across the su, nothing surprising there.  Earlier versions of
> > pam_selinux did try closing and re-opening descriptors 0-2 as newrole
> > does, but that proved problematic.  su likely just needs to be directly
> > patched rather than using pam_selinux.
> 
> What was the problem?
> I remember another message about this, but I didn't understand it then -
> I see what you mean now.

IIRC, it had to do with su's manipulation of fsuid/fsguid prior to
calling pam_open_session; this ultimately prevented pam_selinux from
being able to re-open the tty due to DAC restrictions.  There were
several bugzillas related to su and sudo and the issues of tty
relabeling, descriptor inheritance, etc during earlier Fedora
integration (likely filed against rawhide).  As a separate but related
issue, having a proxy pty for su/sudo similar to what is now being done
for run_init would be helpful in providing stronger isolation.  That
came up too during earlier bugzillas I think.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
