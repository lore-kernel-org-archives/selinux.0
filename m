Subject: Re: [SEMANAGE] Fix parse_optional_ch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43ED0824.4020104@cornell.edu>
References: <43ED0824.4020104@cornell.edu>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 10:33:27 -0500
Message-Id: <1139844807.14253.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-02-10 at 16:39 -0500, Ivan Gyurdiev wrote:
> Joshua please try to reproduce with the following patch applied.
> Changelog:
> - handle NULL as no match in parse_optional_ch
> - do not advance a NULL pointer in parse_optional_ch - that breaks NULL 
> check later
> - remove NULL check in parse_optional_str - doesn't seem necessary.

Merged as of libsemanage 1.5.22.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
