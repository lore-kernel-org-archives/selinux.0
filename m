Subject: Re: Port of audit2allow to python
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <437A0930.80906@redhat.com>
References: <437A0930.80906@redhat.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 13:46:45 -0500
Message-Id: <1132080405.28124.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-15 at 11:13 -0500, Daniel J Walsh wrote:
> Next step add reference policy generation.

Doesn't yield the same output as the old perl script, even after sorting
both outputs to avoid ordering issues.

Looks like the new script is incorrectly adding allow rules for:
- security_compute_sid errors, and
- avc:  granted messages

But the new script appears to be more consistent about using curly
brackets for multiple permissions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
