Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA05855
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 20:55:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA23587
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 00:53:48 GMT
Received: from edmond.crypt.gen.nz (203-79-74-240.adsl.paradise.net.nz [203.79.74.240])
	by jazzswing.ncsc.mil  with ESMTP id AAA23583
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 00:53:46 GMT
Received: from crypt.gen.nz (localhost.localdomain [127.0.0.1])
	by edmond.crypt.gen.nz (Postfix) with SMTP id 750C513924
	for <selinux@tycho.nsa.gov>; Wed,  9 Oct 2002 13:55:20 +1300 (NZDT)
Message-ID: <23483.202.6.84.11.1034124921.squirrel@www.crypt.gen.nz>
Date: Wed, 9 Oct 2002 13:55:21 +1300 (NZDT)
Subject: Re: What to do next?
From: "Kerry Thompson" <kerry@crypt.gen.nz>
To: <selinux@tycho.nsa.gov>
In-Reply-To: <H3OGTT$0A7DBB13E9FF323A8AA0A7184811E6BA@terra.com.br>
References: <H3OGTT$0A7DBB13E9FF323A8AA0A7184811E6BA@terra.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I suggest getting Russell's latest policy files from
http://www.coker.com.au/selinux/policy.tgz and installing them.

Also, read the last page or so of the README file, there's some handy tips
there on things that you can do.

Then, start using your system in the way that you want to : as a web
server, dns server, Email server, or maybe just as a workstation. While
doing this, monitor the "avc" messages that will be appearing in
/var/log/messages and try to understand what is causing them based on the
policy configuration, the tagging of files, etc.

The aim is to get your system running properly in *enforcing mode*. By
default after installation your system will only be logging operations
which aren't allowed, and allowing them to go ahead anyway. By running the
avc_toggle utility you can switch your system into enforcing mode which
will actually do the job of disallowing these operations.

If you find problems testing the policies then try to figure out what is
causing them and post some patches back here.

Try configuring new policies for programs which don't already have a
policy - then post your new policies to this list for the rest of us to
look at and use.

Kerry

luiztizei said:
>   I have succefully installed selinux kernel lsm-2.4 to my RH7.3
> distro. I want to continue to explore this system. What should I do
> next? Get the patches you are releasing and try them?
>   I am simply a newbie to the subject, but with time I might help :)
> Thanks,
>
>          Luiz Tizei

-- 
Kerry Thompson, CCNA CISSP
Information Systems Security Consultant
http://www.crypt.gen.nz  kerry@crypt.gen.nz




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
