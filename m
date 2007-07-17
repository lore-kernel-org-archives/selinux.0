Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HCE2PM012928
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 08:14:02 -0400
Received: from smtp-mclean.mitre.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HCE1QA022850
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 12:14:01 GMT
Received: from smtp-mclean.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-mclean.mitre.org (8.12.11.20060308/8.12.11) with SMTP id l6HCE1am003956
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 08:14:01 -0400
Received: from smtp-mclean.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-mclean.mitre.org (Postfix) with ESMTP id 783334F8DA
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 08:14:01 -0400 (EDT)
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Cannot run ldconfig in a home directory
References: <ogtzm1vntsd.fsf@oolong.mitre.org>
	<6bffcb0e0707170503lf20df59p7afdd676656f7234@mail.gmail.com>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 17 Jul 2007 08:14:00 -0400
In-Reply-To: <6bffcb0e0707170503lf20df59p7afdd676656f7234@mail.gmail.com>
Message-ID: <ogt4pk3b52v.fsf@oolong.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> writes:

> On 17 Jul 2007 07:39:30 -0400, John D. Ramsdell <ramsdell@mitre.org> wrote:

> > Obviously, it is easy enough for me to disable SELinux while
> > playing with the audit sources, but it seems to that with this

This should have said, "but it seems to me that with this"...

> > policy, if I were working on a machine I did not control, I
> > wouldn't be able properly test an installation.
> 
> man audit2allow ;)

By "not control", I meant not having root privileges.

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
