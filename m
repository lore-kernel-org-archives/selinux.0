Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8IEhCxk001810
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 10:43:12 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l8IEhAgF012233
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 14:43:10 GMT
Message-ID: <46EFE08F.7040803@manicmethod.com>
Date: Tue, 18 Sep 2007 10:28:31 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Mark Goldman <mgoldman@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [POLICYREP] [Patch 0/5] remove modular policy support for policy
 rep branch
References: <20070816155325.881136010@tresys.com>>
In-Reply-To: <20070816155325.881136010@tresys.com>>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mark Goldman wrote:
> This patchset removes module support from libsepol.  This
> patchset is in support of the policyrep work.
>
> Patches one and two removes the files that are solely for 
> supporting modular policies. 
>
> Patch three and four eliminates the various structures that 
> supported modular policies. All functional changes occur in 
> this patch.
>
> Patch five puts dispol in libsepol's utils directory.
> Dispol was not modified in this move.
>
> This e-mail splits the original patches up so that they will go
> through the list-serv without being bounced.
>
> -mdg
>
> Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
>   

Merged into the policyrep branch with changes necessary due to the 
alignment patch that was applied to trunk.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
