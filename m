Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8L1cmcj002830
	for <selinux@tycho.nsa.gov>; Sun, 20 Sep 2009 21:38:48 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8L1c4mO020255
	for <selinux@tycho.nsa.gov>; Mon, 21 Sep 2009 01:38:04 GMT
Subject: Re: [PATCH] SELinux: audit_access perm used only to dontaudit
 denials in that access syscall
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gob, jmorris@namei.org
In-Reply-To: <20090921013707.2912.67094.stgit@paris.rdu.redhat.com>
References: <20090921013707.2912.67094.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 20 Sep 2009 21:38:41 -0400
Message-Id: <1253497121.4023.1.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2009-09-20 at 21:37 -0400, Eric Paris wrote:
> This patch allows policy to specify a new type of donaudit rule.  It does not
> follow the normal semantics of a kernel permission.  allow and auditallow
> rules with this permission are completely meaningless.  The kernel will accept
> a policy with such rules, but they do absolutely nothing.  What actually
> happens is that if a process calls access() (or faccessat()) and SELinux
> denies their request we will check for a dontaudit rule on the "audit_access"
> permission.  If there is a dontaudit rule on "audit_access" we will not print
> an AVC.  If there is no dontaudit rule we will print the AVC for the
> permissions requested.  Namely read, write, or exec.  There will NEVER be a
> denial message with the "audit_access" permission.  Such a message would be
> meaningless as this permission does not in ANY WAY control security decisions.

This patch depends on:
http://marc.info/?l=linux-fsdevel&m=125349667323054&w=2

Which i forgot to cc selinux-list and friends on.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
