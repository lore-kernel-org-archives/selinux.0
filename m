Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA15072
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 08:58:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA05513
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 13:57:23 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA05509
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 13:57:23 GMT
Date: Mon, 25 Mar 2002 08:57:44 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: strange failure
In-Reply-To: <20020322212840.CF3FE108F@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203250852400.1015-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 22 Mar 2002, Russell Coker wrote:

> I have the following in my policy:
> allow devfsd_t domain:dir_file_class_set getattr;
>
> But I get the following logged:
> Mar 22 22:26:22 test kernel: avc:  denied  { getattr } for  pid=394
> exe=/sbin/devfsd path=/vc/2 dev=00:07 ino=20
> scontext=system_u:system_r:devfsd_t
> tcontext=root:object_r:sysadm_tty_device_t tclass=chr_file
>
> What am I missing?
>
> I've tried this many times, read the macro expansion, reloaded the config and
> restarted the daemon etc.  I'm pretty sure that I haven't made the obvious
> mistakes of not saving the file or not loading the policy etc.

'domain' is a type attribute that is associated with every type that is
used to label a process (and would consequently be termed a "domain" in a
traditional TE model).  Hence, 'domain' includes sysadm_t but not
sysadm_tty_device_t.  Your allow rule permits devfsd to stat files labeled
with domains, which would only be /proc/PID entries.  If you want to grant
access to all terminal device types, use the 'ttyfile' and/or 'ptyfile'
type attributes with the chr_file class.  If you want to grant access to
all file types, then use the 'file_type' attribute.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
