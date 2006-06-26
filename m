From: David Howells <dhowells@redhat.com>
In-Reply-To: <1150924813.3432.14.camel@moss-tarheels.epoch.ncsc.mil> 
References: <1150924813.3432.14.camel@moss-tarheels.epoch.ncsc.mil> 
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: sds@tycho.nsa.gov, James Morris <jmorris@namei.org>, eparis@parisplace.org,
        David Howells <dhowells@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: inherit /proc/self/attr/keycreate across fork 
Date: Mon, 26 Jun 2006 11:03:46 +0100
Message-ID: <14355.1151316226@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:

> This patch updates SELinux to cause the keycreate process attribute held in
> /proc/self/attr/keycreate to be inherited across a fork and reset upon execve.
> This is consistent with the handling of the other process attributes provided
> by SELinux and also makes it simpler to adapt logon programs to properly
> handle the keycreate attribute.

Please post it to Andrew Morton directly as soon as possible.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
