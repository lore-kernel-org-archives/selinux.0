Subject: Re: policycoreutils diff
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <4207BAB7.3060406@redhat.com>
References: <4207BAB7.3060406@redhat.com>
Content-Type: text/plain
Message-Id: <1107805397.11907.80.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 07 Feb 2005 14:43:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-02-07 at 14:00, Daniel J Walsh wrote:
> sestatus was going into infinite loops with booleans > 30 chars.

Thanks, merged as of policycoreutils 1.21.13.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
