Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5AI0VQB019117
	for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2008 14:00:31 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5AI0SF6015250
	for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2008 18:00:29 GMT
Received: by py-out-1112.google.com with SMTP id a78so1029024pyh.32
        for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2008 11:00:28 -0700 (PDT)
Message-ID: <7e0fb38c0806101100x452eae80he5192415b9e02868@mail.gmail.com>
Date: Tue, 10 Jun 2008 14:00:24 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: tracking down execstack & execmem violations
Cc: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>,
        selinux@tycho.nsa.gov, "Daniel J Walsh" <dwalsh@redhat.com>,
        "James Morris" <jmorris@namei.org>
In-Reply-To: <1213120159.30576.158.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <0794F277152EF94AA637E3AECF5CB70FB9EAC8@blums0042.bluelnk.net>
	 <1213118122.30576.147.camel@moss-spartans.epoch.ncsc.mil>
	 <0794F277152EF94AA637E3AECF5CB70FB9EACE@blums0042.bluelnk.net>
	 <1213120159.30576.158.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 10, 2008 at 1:49 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Java is known to require execmem for runtime code generation.  There is
> a java_t domain that you can look at as an example.  I think they allow
> it execstack too, although I'm not as clear as to why that is necessary,
> possibly for the thread stack allocation.
>
> Thread stacks may be allocated with PROT_EXEC if the executable is
> marked as requiring an executable stack or if it lacks the marking;
> execstack should tell you the story there.
>
> If we can't give execmem w/o giving execstack too, then execstack isn't
> useful as a separate permission.

As I recall, which is always a dangerous thing for me todo, execstack
needs execmem for multithreaded processes because the 'stack' of the
second thread is just 'memory' from the point of view of the
permission checks.

execmem does not need execstack.....

java probably actually uses an executable stack which is why it needs both.....

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
