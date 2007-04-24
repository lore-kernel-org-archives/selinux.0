Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OJmtx2007528
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 15:48:55 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3OJmtJc020792
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 19:48:55 GMT
Message-ID: <462E5F26.3060201@tresys.com>
Date: Tue, 24 Apr 2007 15:48:54 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 00/33] libsemanage/libsepol object serialization and ps-api
References: <20070423213455.741326000@tresys.com>
In-Reply-To: <20070423213455.741326000@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

jbrindle@tresys.com wrote:
> This is the majority of the patches from the policy server release a few months ago. This implements object serialization to send objects (eg., booleans, file contexts, etc) across the line to the policy server. It also implements the line protocol to connect to the policy server and the backend for libsemanage so that semodule, semanage, etc will talk to a policy server instead of doing local operations.
>
> The object serialization will also be necessary for the policy representation branch as we will use this infrastructure to serialize the policy tree for module reading and writing.
>
> The only part left for the policy server is the hooks that were implemented in the expander. As the policy representation work is going on and should remove the expander entirely these patches will have to wait until we have enough of the new representation work to implement them there.
>
> This is obviously meant only for trunk and the policyrep branch.
>   
I accidently sent this with a timestamp of 5:35 yesterday (vm loses 
time, oops). So if it fell off the bottom of your mail list and you are 
interested in the patches please check them out :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
