Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA25626
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 16:06:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA23208
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 21:05:18 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id VAA23204
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 21:05:18 GMT
Date: Wed, 20 Mar 2002 16:06:30 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ntp policy
In-Reply-To: <Pine.GSO.4.33.0203201553140.11981-100000@raven>
Message-ID: <Pine.GSO.4.33.0203201605460.11981-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 20 Mar 2002, Stephen Smalley wrote:

> >allow ntpd_t { var_lib_ntp_t var_log_ntp_t }:dir rw_dir_perms;
> >allow ntpd_t { var_lib_ntp_t var_log_ntp_t }:file rw_file_perms;
>
> These rules should be handled already by the file_type_auto_trans
> macros, which both set up the type transition rule and grant the
> necessary permissions to create and access files of these types.

Sorry, the above comment only applies to var_log_ntp_t, since there is no
file_type_auto_trans rule for var_lib_ntp_t.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
