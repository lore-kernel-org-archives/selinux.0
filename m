Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA20440
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 07:34:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA09218
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 11:32:37 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA09214 for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 11:32:36 GMT
Date: Thu, 26 Sep 2002 07:34:10 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <pasi.kivikangas@nokia.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: SELinux on UML
In-Reply-To: <98C7D2E5BCD2374C9AAE0BCD2E9C1DD9BE8429@esebe013.ntc.nokia.com>
Message-ID: <Pine.GSO.4.33.0209260727510.12826-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 25 Sep 2002 pasi.kivikangas@nokia.com wrote:

> I wanted to try out SELinux on UML (User Mode Linux). What I did was, I
> patched Linux kernel 2.4.19 with LSM- then with SELinux- and finally
> with UML-patches. Everything went quite well and I didn't have to do too
> much manual work.
>
> Anyhow, UML kernel compilation didn't succeed because SELinux seems to
> rely on some ptrace stuff (I'm not quite familiar with that) and UML
> doesn't seem to provide that.

Could you provide the actual output from the failed kernel compilation?
I'd like to see the specific error.  Is the real issue the new SELinux
system calls?

As a side note, one SELinux user has privately reported that in order to
port SELinux to the arm architecture, he restructured the SELinux code to
ease porting to other architectures, which might also help with UML.  I'm
still waiting for him to actually submit patches with his changes.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
