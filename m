Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA7JhRrt015600
 for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2014 14:43:27 -0500
Received: by mail-qg0-f54.google.com with SMTP id q108so2846015qgd.41
 for <selinux@tycho.nsa.gov>; Fri, 07 Nov 2014 11:43:25 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH] selinux: Support SCTP protocol
Date: Fri, 07 Nov 2014 14:43:22 -0500
Message-ID: <18388343.NRnGYCgyij@sifl>
In-Reply-To: <1415379731.36132.YahooMailNeo@web87902.mail.ir2.yahoo.com>
References: <1415368329-2670-1-git-send-email-richard_c_haines@btinternet.com>
 <2529618.NmhAYzQ15g@sifl>
 <1415379731.36132.YahooMailNeo@web87902.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "vyasevic@redhat.com" <vyasevic@redhat.com>,
 "dborkman@redhat.com" <dborkman@redhat.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, November 07, 2014 05:02:11 PM Richard Haines wrote:
> Yes I thought there might be more to this as the orginal to-do list referred
> to a bug report that pointed to the possible updates required. I then saw
> the new list that said "Proper support for SCTP". I was not sure what it
> meant until now.

I wish I could provide you a full list of what would need to be done, but 
unfortunately I don't have enough knowledge of SCTP to be able to tell you 
more than I already have.  I expect that in the end you'll be able to educate 
us all (at least the SELinux folks) a little on SCTP.

> Anyway I may carry on and see how far I get.

Please do, your help would be greatly appreciated.  I'm more than happy to 
provide whatever help I can and I suspect dborkman would say the same.

> However what about the "Improve support for the different network address
> families with more socket classes" that is on the list. Would the type of
> patch I submitted be suitable for that type of basic support for say
> Bluetooth or are you really looking for the detailed support as in SCTP.

Like most things, the answer is: "it depends".

If the protocol is fairly simplistic, e.g. UDP, then a patch like what you 
provided is likely sufficient.  However, if it is more complicated, e.g. TCP, 
then we need to be a bit more careful to make sure we are handling things 
correctly.  While I only know enough about SCTP to be dangerous, SCTP does 
appear to fall under the complex/TCP category.

I don't know enough about Bluetooth to make a judgment either way, but I'm 
always willing to accept patches if you provide a good explanation.

-- 
paul moore
www.paul-moore.com
