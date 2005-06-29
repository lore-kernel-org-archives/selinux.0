Subject: Re: Execmem boolean
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: ivg2@cornell.edu, selinux@tycho.nsa.gov
In-Reply-To: <42C2DB70.2070204@redhat.com>
References: <1119822163.4357.9.camel@localhost.localdomain>
	 <1119883756.32316.74.camel@moss-spartans.epoch.ncsc.mil>
	 <42C2DB70.2070204@redhat.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 14:49:57 -0400
Message-Id: <1120070997.3553.172.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-06-29 at 13:33 -0400, Daniel J Walsh wrote:
> Problem is with third party apps,  They don't get labeled texrel_shlib_t 
> and therefore do not work.
> 
> allow execmod allows them to work with the shlib_t label.  We can change 
> this to a targeted vs strict.

IMHO, we can allow execmod to texrel_shlib_t without requiring a boolean
around it at all.  Only case where I would care to shut off execmod is
for anything not explicitly labeled texrel_shlib_t, as that label
already indicates an explicit decision to allow text relocation on that
file.  Hence, we can keep wider execmod access (e.g. to shlib_t,
home_type, file_type, whatever) restricted via allow_execmod, and just
always include execmod to texrel_shlib_t.  Strict policy likely
shouldn't allow execmod to anything but texrel_shlib_t, and can thus
omit the boolean altogether.

> Did these get added as default allow?  If policy is 19 or less?  Deny if 
> policy > 19?
> 
> I don't think we should add any more access checks without bumping the 
> policy version and putting
> that logic in.

Well, they are already in 2.6.13-rc1, and no, they are not tied to a
particular policy version.  I think FC4 targeted policy already allows
them for unconfined domains.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
