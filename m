Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA25827
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 10:36:51 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA03338
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 15:35:53 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA03334 for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 15:35:52 GMT
Date: Thu, 21 Feb 2002 10:36:04 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: SELinux
In-Reply-To: <3C748541.6050708@pcez.com>
Message-ID: <Pine.GSO.4.33.0202211033090.819-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 20 Feb 2002, Shaun Savage wrote:

> The linux/security/selinux/include/flask/*.h
> av_permissions.h gives the bit pattern of all the permissions
> av_perm_to_string.h & common_perm_to_string.h is some of the string
>     permissions
> class_to_string.h is most of the objects
> flask.h gives the object classes

The definitions in these files are automatically generated from
configuration files.  A policy developer shouldn't need to look directly
at these header files - you can simply look at the security_classes and
access_vectors configuration files.  They are located in the flask
subdirectory of the SELinux module (lsm*/security/selinux/flask) and are
installed into /usr/local/selinux/flask for use in compiling the policy
configuration.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
