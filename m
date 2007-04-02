Subject: Re: [Fwd: restorecon single fs patch]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <46115278.4020401@redhat.com>
References: <46115278.4020401@redhat.com>
Content-Type: text/plain
Date: Mon, 02 Apr 2007 15:15:24 -0400
Message-Id: <1175541324.5889.84.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-02 at 14:59 -0400, Daniel J Walsh wrote:
> Patch to tell restorecon to only do one file system.

Observations:
- This is yet another reason to coalesce setfiles and restorecon, as
setfiles already stops on filesystem boundaries.
- Here you introduce -l as meaning "limit to one filesystem" for
restorecon, but -l means log to setfiles and to the fixfiles script
front-end.  Seems prone to user confusion/conflict (think of what
happens if I want to pass this option through fixfiles to restorecon)
and it will get worse when/if we merge setfiles and restorecon together
if we don't fix it now.

How hard would it be to just fold restorecon and setfiles into a single
binary, and have them only differ in the default interfaces and
behaviors they provide (based on their argv[0] value), and try to use a
single standard set of options to the degree we can without breaking
widely used ones?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
