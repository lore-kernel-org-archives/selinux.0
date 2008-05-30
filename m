Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4UF5UCV013347
	for <selinux@tycho.nsa.gov>; Fri, 30 May 2008 11:05:32 -0400
Received: from fk-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4UF5TU1009109
	for <selinux@tycho.nsa.gov>; Fri, 30 May 2008 15:05:29 GMT
Received: by fk-out-0910.google.com with SMTP id 18so236481fks.2
        for <selinux@tycho.nsa.gov>; Fri, 30 May 2008 08:05:28 -0700 (PDT)
Message-ID: <ddbc00640805300805i3bfe2da5gaef495698e43e64@mail.gmail.com>
Date: Fri, 30 May 2008 10:05:28 -0500
From: "Joe Nall" <joe@nall.com>
To: "Xavier Toth" <txtoth@gmail.com>
Subject: Re: rbacsep: collapsing xserver
Cc: "Eamon Walsh" <ewalsh@tycho.nsa.gov>, "Daniel J Walsh" <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "SELinux Mail List" <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40805300758m1fb4c920mb84e49e38a28493a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1211985533.5008.116.camel@gorn.columbia.tresys.com>
	 <ddbc00640805280816i24c06b68u65a7e4d7b68bf213@mail.gmail.com>
	 <1211990530.5008.127.camel@gorn.columbia.tresys.com>
	 <ddbc00640805280942n4ca2619h6185e89dc7d3c108@mail.gmail.com>
	 <1211998598.5008.138.camel@gorn.columbia.tresys.com>
	 <483DAB87.7090401@tycho.nsa.gov>
	 <cadfc0e40805290918v55be6a5cn5b6da493185c7ca3@mail.gmail.com>
	 <483F090F.2070109@redhat.com> <483F528B.9090802@tycho.nsa.gov>
	 <cadfc0e40805300758m1fb4c920mb84e49e38a28493a@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, May 30, 2008 at 9:58 AM, Xavier Toth <txtoth@gmail.com> wrote:

> Yes, I think Brian mentioned that the server is not actually restarted
> but rather does a setuid/setgid because of the need to be root during
> some portion of the X sever initialization. Hopefully it won't be too
> much trouble to add a setcon too. One question about this is what will
> happen with audit once the X server transition user and context?

The goal being to start out in xdm_xserver_t during login and
transition to ROLE_xserver_t, correct?

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
