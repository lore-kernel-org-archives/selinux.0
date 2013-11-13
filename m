Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rADHZIeB011676
	for <selinux@tycho.nsa.gov>; Wed, 13 Nov 2013 12:35:18 -0500
Received: by mail-ee0-f50.google.com with SMTP id b45so375360eek.9
        for <selinux@tycho.nsa.gov>; Wed, 13 Nov 2013 09:35:12 -0800 (PST)
Message-ID: <1384364110.30406.53.camel@d30>
Subject: Re: SELinux Coloring book?
From: Dominick Grift <dominick.grift@gmail.com>
To: Bruno Wolff III <bruno@wolff.to>
Cc: Tony Scully <tonyjscully@gmail.com>, Daniel J Walsh <dwalsh@redhat.com>,
        Community support for Fedora users <users@lists.fedoraproject.org>,
        Fedora
 SELinux Users <selinux@lists.fedoraproject.org>,
        SELinux
 <selinux@tycho.nsa.gov>
Date: Wed, 13 Nov 2013 18:35:10 +0100
In-Reply-To: <20131113171326.GA13491@wolff.to>
References: <52839664.1080600@redhat.com>
	 <1bddae0010527398cc85d89bb8f1aad9.squirrel@host290.hostmonster.com>
	 <CAMk6u_TUztYjqUTFCd5ukcHWOYt=cJaJv2ARvw-RafcVAAVUQw@mail.gmail.com>
	 <20131113171326.GA13491@wolff.to>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2013-11-13 at 11:13 -0600, Bruno Wolff III wrote:
> On Wed, Nov 13, 2013 at 17:10:43 +0000,
>    Tony Scully <tonyjscully@gmail.com> wrote:
> >That's excellent!
> 
> The mls case might have been overly simplified. It didn't cover writing, 
> where the dominance goes in the other direction. People might be incorrectly 
> left with the impression the top secret can do everything that secret 
> can do.
> --

I agree with you on the danger of oversimplification in generel with
regard to explaining SELinux

This is also why i find it sub-optimal to leave the two other default
security models out of the equation (RBAC/IBAC)

It is mentioned in the article that SELinux complements Linux security,
by briefly touching on IBAC one would clarify at least to some degree
how SELinux associates with Linux security

RBAC by itself is worth mentioning in my view, if only to have touched
on each security attribute in a security context tuple.

The idea of the illustrated article is nice, but the article is not
comprehensive.

Granted, there are constraints. You cannot simply publish a three page
article on a medium like this i suspect




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
