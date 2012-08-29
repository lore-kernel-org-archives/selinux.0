Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7TF0VaK010225
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2012 11:00:31 -0400
Message-ID: <503E2E8D.2020606@tresys.com>
Date: Wed, 29 Aug 2012 11:00:29 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH/RFC] setools: update swig interfaces for swig-2.0.7 (and
 higher?)
References: <201208211615.q7LGFg3M000832@vivaldi49.register.it> <CAPzO=Nyqc0=cyeOh6Aj3A-bSbtpbnjSfsXc_Lf-kO3ceeK3w2A@mail.gmail.com> <CACLa4puinrGaotQ5f5rqvYusA7mV-0qTaBUaF+teYfRezZE6Rw@mail.gmail.com> <CAPzO=NwR-7KruhfYYRO+SFGD2=cmuG+w5dNPaqbz=UhiJ4=Ziw@mail.gmail.com>
In-Reply-To: <CAPzO=NwR-7KruhfYYRO+SFGD2=cmuG+w5dNPaqbz=UhiJ4=Ziw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/25/12 12:47, Sven Vermeulen wrote:
> On Fri, Aug 24, 2012 at 7:17 PM, Eric Paris <eparis@parisplace.org> wrote:
>> With your patch does it still build with the old swig version?  I know
>> we put a nasty hack in Fedora which made it build with new swig, but
>> wouldn't build with old swig.
> 
> It builds fine with swig-2.* (tested with 2.0.3, 2.0.4, 2.0.7 and now 2.0.8).
> 
> swig-1.3.40 doesn't, but without my patch it fails with 1.3.40 as well.

As an upstream matter, I'm not sure that we care if it fails with the old swig.  2.* has been out for a few years, right?

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
