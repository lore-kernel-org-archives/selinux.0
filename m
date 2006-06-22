From: David Howells <dhowells@redhat.com>
In-Reply-To: <1150924813.3432.14.camel@moss-tarheels.epoch.ncsc.mil> 
References: <1150924813.3432.14.camel@moss-tarheels.epoch.ncsc.mil> 
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: sds@tycho.nsa.gov, James Morris <jmorris@namei.org>, eparis@parisplace.org,
        David Howells <dhowells@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: inherit /proc/self/attr/keycreate across fork 
Date: Thu, 22 Jun 2006 16:12:43 +0100
Message-ID: <13784.1150989163@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:

> From: Michael LeMay <mdlemay@epoch.ncsc.mil>
> 
> This patch updates SELinux to cause the keycreate process attribute held in
> /proc/self/attr/keycreate to be inherited across a fork and reset upon execve.
> This is consistent with the handling of the other process attributes provided
> by SELinux and also makes it simpler to adapt logon programs to properly
> handle the keycreate attribute.
> 
> Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>

Signed-Off-By: David Howells <dhowells@redhat.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
