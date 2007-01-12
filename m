Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <james.antill@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Jim Meyering <meyering@redhat.com>
In-Reply-To: <1168633494.7993.546.camel@moss-spartans.epoch.ncsc.mil>
References: <45A7D773.8040800@redhat.com>
	 <1168628100.7993.525.camel@moss-spartans.epoch.ncsc.mil>
	 <1168632626.13080.212.camel@code.and.org>
	 <1168633494.7993.546.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 15:29:47 -0500
Message-Id: <1168633787.7993.549.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-12 at 15:24 -0500, Stephen Smalley wrote:
> If the user/caller specifies to cp that it wants the security context
> preserved, then any failure there should be fatal to the copy.  But if
> the user/caller just specified -p or -a, which used to not include
> security contexts, then it seems that an inability to preserve the
> context shouldn't be fatal to the copy.

An example from the MLS/LSPP world:  a Secret process can read an
Unclassified document and copy it to a Secret document, but it cannot
copy it to an Unclassified document (no write down).  But it may very
well wish to preserve DAC information on the copy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
