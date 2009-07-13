Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6DKgmuo011235
	for <selinux@tycho.nsa.gov>; Mon, 13 Jul 2009 16:42:48 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n6DKgRDW021495
	for <selinux@tycho.nsa.gov>; Mon, 13 Jul 2009 20:42:27 GMT
Date: Mon, 13 Jul 2009 16:42:47 -0400
Subject: Re: [RFC] Install SELinux policies from rpm package header
From: Chad Sellers <csellers@tresys.com>
To: max bianco <maximilianbianco@gmail.com>, SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C6811487.A8B23%csellers@tresys.com>
In-Reply-To: <a040ffdc0907101411s479dbce2h5d41656e3b6960d4@mail.gmail.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/10/09 5:11 PM, "max bianco" <maximilianbianco@gmail.com> wrote:
>  Personally I am glad that this is in the works, I have really been
> wanting some more control over what policy is installed, really I'd
> rather not install packages without a policy. Nobody wants to leave it
> up to the user and I don't blame them but trying to do this without
> bugging the user is just begging for trouble. I could see a menu under
> Authorizations (on Fedora) like this :
> 
> SELinux Policy Management
> 
> 1. Install only signed policy (by signed I mean it was either
> developed by the maintainers of refpolicy or reviewed by someone on
> the distributions security team to ensure least privilege)
> 
> 2. Prompt user for action : install signed policy, install policy
> included with package, let me install my own policy or just run in the
> user context
> 
> 3. Let the app run unconfined or in a permissive domain - good for
> tools like kismet that are sometimes a pain the ass to use in
> conjunction with SELinux
> 
> 4. Run the app in a generic sandbox
> 
> 5. Install all policy regardless of source (discouraged)
> 
We've actually thought of some of those same features. Our goal right now is
to start by getting support for installing policy into RPM, and then move
into looking at ways to give the user more control over what policy gets
installed.

Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
