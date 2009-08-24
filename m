Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7OKJYTD022992
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 16:19:34 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n7OKJ0kS010181
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 20:19:00 GMT
Date: Mon, 24 Aug 2009 16:19:33 -0400
Subject: Re: This is a patch to both libsemanage and policycoreutils to change
 the behaviour of --upgrade
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C6B86E15.AA01D%csellers@tresys.com>
In-Reply-To: <4A92B016.1080804@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8/24/09 11:21 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> Currently -u will fail if a package does not exists,  This patch will install
> if a module does not exist
> 
> semodule -u ABC.pp XYZ.pp
> 
> Currently fails if ABC.pp exists and XYZ.pp does not
> 
> After this patch. it will succeed, if the version of ABC.pp is newer the
> XYZ.pp
> 
> Copying the behaviour of rpm.
> 
> Do you want these as two separate patches (libsemanage and policycoreutils) or
> just as the git diff?

Just the git diff is perfect.

Thanks,
Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
