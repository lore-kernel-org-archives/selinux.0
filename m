Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA08489
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 08:54:50 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA03531
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 12:52:55 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA03523 for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 12:52:54 GMT
Date: Wed, 9 Oct 2002 08:54:32 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: luiztizei <luiztizei@terra.com.br>
cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: What to do next?
In-Reply-To: <H3OGTT$0A7DBB13E9FF323A8AA0A7184811E6BA@terra.com.br>
Message-ID: <Pine.GSO.4.33.0210090851480.3804-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 8 Oct 2002, luiztizei wrote:

>   I have succefully installed selinux kernel lsm-2.4 to my RH7.3
> distro. I want to continue to explore this system. What should I do
> next? Get the patches you are releasing and try them?
>   I am simply a newbie to the subject, but with time I might help :)

Did you perform a full install of SELinux, as per the selinux/README
instructions?  You need more than just a patched kernel.  You may want to
checkout a copy of the sourceforge selinux CVS tree and install from it to
pick up patches that have been posted since the last public release.  You
can access the sourceforge selinux CVS tree via:

cvs -d:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux \
-z3 co nsa

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
