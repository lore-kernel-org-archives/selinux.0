Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA15964
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 13:06:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA19428
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 17:05:19 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA19424 for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 17:05:19 GMT
Date: Wed, 1 May 2002 13:06:01 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: cant login after running avc_toggle
In-Reply-To: <20020430140249.60D71812E4@coffeesaur2.evoserve.com>
Message-ID: <Pine.GSO.4.33.0205011304100.1601-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 30 Apr 2002, Debian User wrote:

> after i run avc_toggle I am logged out.
> a login prompt appears and i try to login.
> after asking for the password the login prompt appears again.
> the audit messages show that bash dont have permissions to use vc.
> How should this be fixed? im confused. /bin/bash has the type
> shell_exec_t. How do I allow bash to use vcs'? I cant see a bash domain
> anywhere.

Could you provide a copy of the actual log messages?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
