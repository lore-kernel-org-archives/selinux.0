Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA22400
	for <selinux@tycho.nsa.gov>; Tue, 26 Mar 2002 13:11:02 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA10026
	for <selinux@tycho.nsa.gov>; Tue, 26 Mar 2002 18:09:56 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA10022 for <selinux@tycho.nsa.gov>; Tue, 26 Mar 2002 18:09:55 GMT
Date: Tue, 26 Mar 2002 13:10:02 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: /dev/null and /dev/zero
In-Reply-To: <20020324200146.B0AB4F749@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203261306230.28659-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 24 Mar 2002, Russell Coker wrote:

> In what situations would you want to deny access to /dev/null and /dev/zero?
>
> It would make more sense to me to grant global access to these devices via:
> allow domain { zero_device_t null_device_t }:chr_file rw_file_perms;

I'm inclined to avoid 'allow domain' rules entirely now that we've
replaced every.te with macros that can be selectively applied to
individual domains.  There are already rules related to /dev/null and
/dev/zero in the general_file_read/write_access macros.  I'm not sure you
really need write permission to zero_device_t, just read access.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
