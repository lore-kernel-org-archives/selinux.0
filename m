Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA02260
	for <selinux@tycho.nsa.gov>; Thu, 10 Jan 2002 15:03:37 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA23119
	for <selinux@tycho.nsa.gov>; Thu, 10 Jan 2002 20:02:49 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id UAA23115
	for <selinux@tycho.nsa.gov>; Thu, 10 Jan 2002 20:02:48 GMT
Date: Thu, 10 Jan 2002 15:02:43 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: audit policy tag?
In-Reply-To: <3C3DEE61.6020809@pcez.com>
Message-ID: <Pine.GSO.4.33.0201101457230.2318-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 10 Jan 2002, Shaun Savage wrote:

> Is the a policy tag that would allow a audit trail?   I see a audit on
> failure, but I would like to see audit trail on success also.  I would
> assume success audit would require a tag
> audit zot_t zot_t:file read
> when executating in zot_t domain a read of a zot_t file would write
> something to the log.

By default, everything is audited on denial and nothing is audited on
success.  However, you can configure specific cases using the 'auditdeny'
and 'auditallow' rules in the TE configuration.  Typically, when using
'auditdeny' you are reducing the set of audited permissions, which is why
those rules use '~' to obtain the complement of a set.  An example of
'auditallow' might be to audit every use of avc_toggle, which can be
achieved via:
	auditallow { initrc_t sysadm_t } kernel_t:system avc_toggle;

> Also is there a way to redirect the log to something other than syslog?

At present, SELinux simply uses the existing kernel logging facility,
since developing an auditing subsystem was outside the scope of the
project.  Of course, you can tell klogd to log kernel messages somewhere
other than syslog.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
