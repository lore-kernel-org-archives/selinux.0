Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7LIkQFL015321
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 14:46:26 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7LIkPtV022461
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 18:46:26 GMT
Subject: Re: [refpolicy] selinuxutils (semodule)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <477DC293-F96F-4AFB-AD19-E66C80CC3AB4@sf-net.com>
References: <477DC293-F96F-4AFB-AD19-E66C80CC3AB4@sf-net.com>
Content-Type: text/plain
Date: Tue, 21 Aug 2007 18:45:31 +0000
Message-Id: <1187721931.13874.37.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-15 at 11:30 -0400, Stefan Schulze Frielinghaus wrote:
> semodule needs to read semanage.py which is located under debian: /
> var/lib/python-support/python2.4/semanage.py
> 
> Second semodule tries to getattr the filesystem

This is more than likely part of the libselinux constructor function, so
we want to allow it.

> Attached is a patch which solves this. I added the allow rules 
> without a debian distribution check. Maybe we should allow it only to 
> debian?

Yes, it should be in a distro_debian, since this is definitely a
debian-specific access, since the .py is in a different location.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
