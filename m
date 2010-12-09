Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oB9HlUfA018849
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2010 12:47:30 -0500
Received: from smtp102.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id oB9HlTWr003727
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2010 17:47:29 GMT
Message-ID: <4D01162F.5040107@schaufler-ca.com>
Date: Thu, 09 Dec 2010 09:47:27 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
CC: Joshua Brindle <method@manicmethod.com>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov
Subject: Re: Recent status of SE-PostgreSQL
References: <4CFF0564.1080107@ak.jp.nec.com> <AANLkTi=j9OCJ=0iGDEoAzwennWBJMiB=Env376+NoE0g@mail.gmail.com> <4D0017A7.7030605@ak.jp.nec.com> <4D0023C4.8010207@itechfrontiers.com> <4D0094F0.1050108@ak.jp.nec.com> <4D00CB7F.80603@itechfrontiers.com> <4D00FF6C.2070204@manicmethod.com> <4D010801.90108@itechfrontiers.com>
In-Reply-To: <4D010801.90108@itechfrontiers.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/9/2010 8:46 AM, cto@itechfrontiers.com wrote:
> Joshua,
>
> > Postgres is inherently trusted with it's own objects, the kernel cannot  mitigate that.
>
> Aha that's the point, daemons cannot be trusted, in case of DBMS it must be isolated anyway, (System Security wise)

I think that we can stop right here. Patrick, you need to go read up
on the composition of trusted systems. You also need to put a little
time into learning about their history. There were almost as many
Orange Book evaluations on multi-level secure databases as there were
on operating systems. All of the evaluated operating systems, with
the possible exception of SC/MP, made heavy use of trusted daemons.
Applications that enforce system policy are an expected and important
part of any security solution.

Patrick, the evidence is against your claims. Please have a look at
the literature and come back if you have questions.

Thank you.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
