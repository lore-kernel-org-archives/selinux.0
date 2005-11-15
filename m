Subject: Re: rawhide targeted vs. refpolicy rpm
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1132067431.5415.383.camel@moss-spartans.epoch.ncsc.mil>
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
Content-Type: text/plain
Date: Tue, 15 Nov 2005 10:18:01 -0500
Message-Id: <1132067881.5415.391.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-15 at 10:10 -0500, Stephen Smalley wrote:
> Hmmm...except that such an approach falls into the same problem as we
> have now, i.e. default_contexts in targeted policy says
> system_r:unconfined_t:s0 <MLS component is irrelevant there due to the
> way in which MLS works these days>.  Hence, semanage would still end up
> returning system_r in the targeted policy case.  The approach would work
> in the strict policy case, as we have real user roles listed in its
> default_contexts file, so it would just be a matter of finding the first
> one that is authorized for the user in that case.

Ok, so perhaps what we need is a new semanage policy component that
provides libsemanage with:
a) default role (or use default_contexts to determine), and
b) home directory type prefix for that role, which can be different from
the role prefix itself.

And then have libsemanage export an interface to genhomedircon to obtain
the home directory type prefix for use in generating the file contexts
rather than using the role prefix itself.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
