Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5JFDaKI013343
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 11:13:37 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5JFDaif021535
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 15:13:36 GMT
Message-ID: <4677F29A.7080604@manicmethod.com>
Date: Tue, 19 Jun 2007 11:13:30 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>, slide@tresys.com
Subject: Re: Per Domain Permissive Mode
References: <4677EE5B.9030405@redhat.com>
In-Reply-To: <4677EE5B.9030405@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Steven mentioned in another conversion the idea of a Per Domain 
> Permissive Mode.  This is something our customers are looking for.
> A few customers want to write policy to confine an application but 
> they are afraid of releasing it in enforcingmode to hundreds/thousands 
> of machines, and then finding out they missed a crucial code path.  
> The would like to be able to write the policy distribute it and gather 
> AVC messages in for a couple of months, until they fail confident that 
> the policy will work.  Currently they would have to turn all the 
> machines to permissive mode or take there chances. 
> Having a simple domain that would run in permissive mode while the 
> rest of the machine ran enforcing would satisfy this need.
>
> Thoughts...

I don't think this should be done at the mechanism level. One can create 
a policy that allows everything and also audits it, and turns that into 
policy. This sounds like something SLIDE would be pretty good at (it 
already has a remote agent that monitors logs and pushes policy to 
remote machines).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
