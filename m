Subject: RE: [PATCH] libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jonathan Kim <jkim@TrustedCS.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov,
   Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <36282A1733C57546BE392885C0618592D97706@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592D97706@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 12:15:20 -0500
Message-Id: <1131124520.23420.308.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-04 at 11:40 -0500, Jonathan Kim wrote:
> Taking your guidance into consideration and examining the big picture of the
> architecture, we will take back the proposed patch and will be sending out a
> new MLS policy patch.
> Thanks for the responses!

Hmm...well, I did merge the patch, as we should do something other than
just propagating an empty level string back to the caller, and then Ivan
followed up with a patch that effectively reverts your change but allows
the entire :level suffix to be omitted regardless of whether MLS is
enabled or disabled.  So at this point, you can omit the :level suffix
entirely from a given user entry (in which case it will propagate a NULL
level and thus fall back to policy users default level), but a :<empty>
sequence is still going to yield problems.  We should likely handle it
as an error case immediately.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
