Subject: Re: Should this be a dontaudit or an allow in targeted.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Chad Hanson <chanson@TrustedCS.com>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43663282.8030707@redhat.com>
References: <43663282.8030707@redhat.com>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 11:02:12 -0500
Message-Id: <1130774532.22731.118.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-31 at 10:04 -0500, Daniel J Walsh wrote:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=172040
> 
> Basically if a normal uses does a ps -ef on a system, his process will attempt to read the context of udev and friends that are running at a higher sensitivity level.  So apps like login, udev and others will generate 
> AVC messages with MCS policy.

We already have dontaudit rules for similar kinds of denials under
strict policy when a user process does a ps -el.  Hence, dontaudit seems
appropriate here.  The only case where an unconfined_t process would
encounter such a denial would be due to MCS.

On a related note, it has been suggested (on lspp) that we might need
dontaudit/auditallow rules based on MLS level.  Is that true, or can we
just leverage the existing TE-based rules to control such auditing based
on type (which typically gives us finer granularity anyway)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
