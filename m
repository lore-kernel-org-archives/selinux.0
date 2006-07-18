Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6IHDh3e015740
	for <selinux@tycho.nsa.gov>; Tue, 18 Jul 2006 13:13:43 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k6IHDg1F011692
	for <selinux@tycho.nsa.gov>; Tue, 18 Jul 2006 17:13:42 GMT
Message-ID: <44BD16C1.1080802@tresys.com>
Date: Tue, 18 Jul 2006 13:13:37 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 4/6] netfilter integration: add netfilter contexts	sorting
References: <1153168355.10090.49.camel@sgc> <1153235498.10744.26.camel@localhost.localdomain>
In-Reply-To: <1153235498.10744.26.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Mon, 2006-07-17 at 16:32 -0400, Christopher J. PeBenito wrote:
>> Add sorting function for netfilter contexts.
>>
>>  libsemanage/src/direct_api.c     |    9 +
>>  libsemanage/src/semanage_store.c |  189 +++++++++++++++++++++++++++++++++++++--
>>  libsemanage/src/semanage_store.h |    6 +
>>  3 files changed, 198 insertions(+), 6 deletions(-)
>>
> 
> Is this correct location for the netfilter sorting (file and library)?
> The file context sorting is a mess now and, again, just continuing that
> seems like a bad idea.
> 

libsemanage owns and manages these files, it is indeed the correct place 
to do sorting.

> Again, netfilter contexts seems like an ambiguous name. Secmark rules
> seems more accurate to me.
> 

you can put any netfilter rule in, if in the future there is something 
other than secmark that affects selinux those rules can also go into 
this section.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
