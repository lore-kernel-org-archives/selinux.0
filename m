Subject: Re: [PATCH 0/4] features/fixes for rawhide and refpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1130173137.15661.26.camel@twoface.columbia.tresys.com>
References: <1130173137.15661.26.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 13:18:54 -0400
Message-Id: <1130174334.17609.104.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-24 at 12:58 -0400, Joshua Brindle wrote:
> NOTE: this will not read packages created with prior libsepols, you
> should clear out old modules before using this.

If anyone has any problems with dropping compatibility with the old
module package format, please speak up now.  It wouldn't be difficult to
retain compatibility support for reading the old module package format
in libsepol, but it doesn't seem justified given that module packages
haven't been deployed in any distributions yet AFAIK.  Let us know if
this matters to anyone.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
