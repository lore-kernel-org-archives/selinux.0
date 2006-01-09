Subject: Re: [SEPOL] Const in APIs (2)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43BE8C6C.7080803@cornell.edu>
References: <43BE8C6C.7080803@cornell.edu>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 09:11:39 -0500
Message-Id: <1136815899.19934.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-06 at 10:27 -0500, Ivan Gyurdiev wrote:
> Remove malloc nonsense due to non-const hashtab keys.
> 
> Note: I don't understand how symtab_init can get away with initializing 
> a comparator/hasher with non-const keys. I specifically marked those 
> const in hashtab_init, but that doesn't seem to cause any warnings.

Merged as of libsepol 1.11.8.

"Strong typing is for weak minds"

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
