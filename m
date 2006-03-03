Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k23GoCHn010486
	for <selinux@tycho.nsa.gov>; Fri, 3 Mar 2006 11:50:12 -0500
Received: from xproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k23Gmc8d025418
	for <selinux@tycho.nsa.gov>; Fri, 3 Mar 2006 16:48:41 GMT
Received: by xproxy.gmail.com with SMTP id t14so473786wxc
        for <selinux@tycho.nsa.gov>; Fri, 03 Mar 2006 08:50:08 -0800 (PST)
Message-ID: <4ef5fec60603030850o39104631n4eaf8c5b31dca2c1@mail.gmail.com>
Date: Fri, 3 Mar 2006 08:50:08 -0800
From: coderman <coderman@gmail.com>
To: "Erich Schubert" <erich@debian.org>
Subject: Re: FYI SELinux/AppArmor press
Cc: "Joshua Brindle" <jbrindle@tresys.com>, "SE Linux" <selinux@tycho.nsa.gov>,
        selinux-dev@tresys.com
In-Reply-To: <1141392100.18820.30.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <43FF7418.90205@redhat.com>
	 <1141138934.29803.2.camel@wintermute.xmldesign.de>
	 <1141183226.8475.22.camel@localhost.localdomain>
	 <1141222338.2834.33.camel@wintermute.xmldesign.de>
	 <d82d6db50603011259s3fe0e80duca501a9c7925c661@mail.gmail.com>
	 <1141250441.2834.62.camel@wintermute.xmldesign.de>
	 <44065CB2.5080500@tresys.com>
	 <1141296207.17082.12.camel@wintermute.xmldesign.de>
	 <440799A1.2090401@tresys.com>
	 <1141392100.18820.30.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 3/3/06, Erich Schubert <erich@debian.org> wrote:
> ...
> I agree that this is a good approach. However, this can still be solved
> by inheritance. For example, you could grant webalizer access to
> apache_logfiles, which is actually an "abstract" type, realized by two
> other types "apache_access_logs" and "apache_error_logs".

inheritance and least privilege is difficult; this might be something
to discuss in more detail with a constraint model applied to ensure
that an inheritance hierarchy does not leak excessive and unnecessary
privileges.  has this been discussed before on the devel list?

"Integrated constraints and inheritance in DTAC"
http://portal.acm.org/citation.cfm?id=344307

"The Role-Based Access Control System of a European Bank: A Case Study
and Discussion"
http://www-users.cs.york.ac.uk/~jeremy/papers/SACMAT2001.pdf


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
