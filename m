Subject: Re: [SEMANAGE][SEPOL] Minor cleanups
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43E9AAC1.804@cornell.edu>
References: <43E9AAC1.804@cornell.edu>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 14:02:40 -0500
Message-Id: <1139943760.14253.285.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-02-08 at 03:24 -0500, Ivan Gyurdiev wrote:
> This is left over after my other patches are applied...
> - port and interface list traversals are confusing because of unneded 
> variable
> - increase verbosity in some error messages
> - semanage: don't shadow type_str the function to keep gcc happy

Merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
