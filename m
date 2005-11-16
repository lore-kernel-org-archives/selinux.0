Subject: Re: rawhide targeted vs. refpolicy rpm
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   SELinux-dev@tresys.com, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <437A36EB.4000206@tresys.com>
References: <BF9A263D.7FFA%csellers@tresys.com>
	 <4374BDEC.4050600@redhat.com> <200511111717.16542.csellers@tresys.com>
	 <200511141041.49643.csellers@tresys.com>
	 <1131983537.5415.137.camel@moss-spartans.epoch.ncsc.mil>
	 <4378B88B.6040003@redhat.com> <4378C285.3080005@tresys.com>
	 <4378D6F9.5070301@redhat.com>
	 <1131997064.5415.241.camel@moss-spartans.epoch.ncsc.mil>
	 <1132053434.5415.269.camel@moss-spartans.epoch.ncsc.mil>
	 <1132062002.5415.350.camel@moss-spartans.epoch.ncsc.mil>
	 <4379F431.1070908@redhat.com>
	 <1132066658.5415.379.camel@moss-spartans.epoch.ncsc.mil>
	 <1132067431.5415.383.camel@moss-spartans.epoch.ncsc.mil>
	 <1132067881.5415.391.camel@moss-spartans.epoch.ncsc.mil>
	 <1132081420.28124.80.camel@moss-spartans.epoch.ncsc.mil>
	 <437A36EB.4000206@tresys.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 08:12:12 -0500
Message-Id: <1132146732.12540.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-15 at 14:28 -0500, Joshua Brindle wrote:
> I agree, default role was always a loose concept. One question is how 
> the defaults are filled in, is this adding a new file to targeted/strict 
> that have default home directory prefixes?

Yes, I think so.

> This could just be implemented as another database type keyed on the 
> user, so that the sepol user records don't have to be modified.

Yes, good point.  So we just drop defrole out of semanage and sepol user
interfaces altogether.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
