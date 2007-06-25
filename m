Subject: Re: Question on security_load_policy
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Nagendra Tomar <tomer_iisc@yahoo.com>
Cc: SELinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <994059.5156.qm@web53704.mail.re2.yahoo.com>
References: <994059.5156.qm@web53704.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 09:00:21 -0400
Message-Id: <1182776421.24604.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-06-24 at 17:11 -0700, Nagendra Tomar wrote:
> In the security_load_policy() function, for the not-first-time policy
> load case (ss_initialized is true) what is the significance of cloning
> the existing sidtab and then updating the contexts of all the sidtab
> entries (sidtab_map_remove_on_error) ?
>           
>  Why can't we just drop the table and then let the new table be
> populated dynamically as and when new contexts are looked up. As this
> is how the original sidtab was populated in the first place.
> 

Many in-kernel data structures store only a sid (e.g., processes) - so
if you dropped all of the sids there would be no way to recover the
context of those objects.

The first policy load is expected to be early in the boot process, so it
is reasonable to just create sids as objects are created (and objects
created before policy load are handled by the initial sids).

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
