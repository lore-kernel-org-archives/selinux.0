Subject: Re: /dev/pts/x use denials
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1112627593.7629.89.camel@moss-spartans.epoch.ncsc.mil>
References: <1112569241.21383.37.camel@cobra.ivg2.net>
	 <1112627593.7629.89.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 11:43:00 -0400
Message-Id: <1112629380.29574.6.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I don't see sysadm_tmp_t anywhere above. 

Right, that was a typo.. I'm sure I meant sysadm_devpts_t 
(or at least I hope I did - sysadm_tmp_t doesn't make sense)

> I do see staff_t fd's, but that
> just shows that the descriptor was opened by a staff_t process and then
> inherited across the su, nothing surprising there.  Earlier versions of
> pam_selinux did try closing and re-opening descriptors 0-2 as newrole
> does, but that proved problematic.  su likely just needs to be directly
> patched rather than using pam_selinux.

What was the problem?
I remember another message about this, but I didn't understand it then -
I see what you mean now.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
