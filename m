Subject: Re: [ SEPOL/SEMANAGE ] Interface record
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <432DA3D5.3000304@cornell.edu>
References: <432DA3D5.3000304@cornell.edu>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 15:52:11 -0400
Message-Id: <1127159531.29404.159.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-09-18 at 13:28 -0400, Ivan Gyurdiev wrote:
> The attached patches add the interface record to libsepol and libsemanage,
> which replaces the current sepol_iface_t structure. They also fix a minor
> namespace issue, and add include guards to sepol/interfaces.h.

Thanks, merged (with the corrected patch).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
