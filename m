Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA24126
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 09:53:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA16233
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 14:53:02 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id OAA16229
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 14:53:01 GMT
Date: Mon, 3 Dec 2001 09:52:33 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: policy additions needed to make my system run in secure mode
In-Reply-To: <1007220086.2747.0.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0112030933570.4293-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Thanks for providing your additions.  The example policy is merely an
example to demonstrate the system and to help people get started, so we
certainly expect that people will need to customize it.  Specific comments
below.

On 1 Dec 2001, Justin Smith wrote:

> # ipchains
> allow initrc_t initrc_t:rawip_socket { create setopt };

It would be preferable to move ipchains and related programs into their
own domain with these permissions rather than granting them directly
to initrc_t in order to provide least privilege.  But of course, that's
up to you.

> # usb
>
> allow initrc_t unlabeled_t:dir { search };
> allow initrc_t unlabeled_t:file { read getattr };

To truly provide secure access to usbdevfs, we need to define a labeling
behavior for usbdevfs.  I'm not currently using usbdevfs, so I need more
information about how it is intended to work in order to set up a labeling
behavior.  Perhaps you could provide some insight.

> allow mount_t usr_t:dir { mounton };
> allow mount_t usr_t:file { append setattr };
> allow mount_t proc_t:dir { mounton };

The mounton permissions look fine, but I don't know why you need to add
access to a usr_t file.  What does the log message show as the actual
pathname of the file that is being modified in /usr?

> # postgres
>
> allow initrc_t user_home_t:dir { append };
> allow initrc_t user_home_t:file { append };
> allow initrc_t var_lib_t:dir { write add_name create };
> allow initrc_t var_lib_t:file { create };
> allow initrc_t tmpfs_t:file { read write };

You don't want any system processes left in initrc_t.  They all need to be
moved into their own domain.  So you should really define a domain (and
related types) for postgres.

> --------------------------------------------------------------------------
> apache.te:
>
> # General (allow server-side includes)
>
> allow httpd_t httpd_user_script_rw_t:file { getattr read };

I can add this to the example policy - not sure why it wasn't there
originally.

> #
> # Servlets
> # (I modified file types to make all my web pages t
> #  httpd_user_script_rw_t
> # and the Tomcat servlet directory to httpd_user_script)
> #

Hmmm...do you really want all of your web pages to be readable
and writeable by user CGI scripts?

> allow httpd_t httpd_user_script_t:file { append };
> allow initrc_t httpd_user_script_rw_t:dir
>        { getattr search };
>
> allow httpd_t httpd_user_script_rw_t:dir
>        { search getattr };
> allow initrc_t httpd_user_script_rw_t:file
>        { read getattr append write };
>
> allow initrc_t httpd_user_script_t:dir { read write };
> allow initrc_t httpd_user_script_t:file
>        { read write execute execute_no_trans setattr append };
> allow initrc_t file_t:lnk_file { read };
> allow initrc_t file_t:file { execute execute_no_trans };
> allow initrc_t usr_t:file { execute execute_no_trans };
> allow initrc_t http_port_t:tcp_socket { name_bind };

Several of these rules look wrong to me, and potentially dangerous.
You might want to carefully consider them.

> # Postgres
>
> allow user_t usr_t:file { execute execute_no_trans };
> allow user_t initrc_tmp_t:sock_file { write };
> allow user_t initrc_t:unix_stream_socket { connect };

If you move postgres into its own domain, it should also have its
own type for sock_file and unix_stream_socket.  The usr_t rule
suggests that you need to adjust your file_contexts file to apply
a proper program type (e.g. bin_t) to the postgres binaries.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
