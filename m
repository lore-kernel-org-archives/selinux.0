Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kADK3MCb028622
	for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2006 15:03:22 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id kADK2cOD027249
	for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2006 20:02:39 GMT
Message-ID: <4558CF92.4050703@tresys.com>
Date: Mon, 13 Nov 2006 15:03:30 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Specify default type for a role
References: <4558A648.2070509@us.ibm.com>
In-Reply-To: <4558A648.2070509@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael C Thompson wrote:
> Hey all,
>
> So I did some looking and asking around, and I was informed that there 
> is no way to specify the default type for a role in the policy (so 
> that you don't have to manually change the default_type file).
>
> If this is indeed the case, this seems like a prime area for SELinux 
> policy tool enhancement (and probably the policy language itself needs 
> an update?).
>
> What do people think of this idea, to specify the default type 
> associated with a role via the policy?
One could add this functionality to libsemanage if desired to make it 
manageable via semanage or any other clients in the works. If you do 
beware of snakes in the code though...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
