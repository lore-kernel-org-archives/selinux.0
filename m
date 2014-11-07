Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA7H527B005113
 for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2014 12:05:03 -0500
References: <1415368329-2670-1-git-send-email-richard_c_haines@btinternet.com>
 <2529618.NmhAYzQ15g@sifl>
Message-ID: <1415379731.36132.YahooMailNeo@web87902.mail.ir2.yahoo.com>
Date: Fri, 7 Nov 2014 17:02:11 +0000
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH] selinux: Support SCTP protocol
To: Paul Moore <paul@paul-moore.com>
In-Reply-To: <2529618.NmhAYzQ15g@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: "vyasevic@redhat.com" <vyasevic@redhat.com>,
 "dborkman@redhat.com" <dborkman@redhat.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Yes I thought there might be more to this as the orginal to-do list referred to a
bug report that pointed to the possible updates required. I then saw the new list
that said "Proper support for SCTP". I was not sure what it meant until now.

Anyway I may carry on and see how far I get. However what about the 
"Improve support for the different network address families with 
more socket classes" that is on the list. Would the type of patch I submitted
be suitable for that type of basic support for say Bluetooth or are you really looking
for the detailed support as in SCTP.

Richard


----- Original Message -----

> From: Paul Moore <paul@paul-moore.com>
> To: Richard Haines <richard_c_haines@btinternet.com>
> Cc: selinux@tycho.nsa.gov; vyasevic@redhat.com; dborkman@redhat.com
> Sent: Friday, 7 November 2014, 16:35
> Subject: Re: [PATCH] selinux: Support SCTP protocol
> 
> On Friday, November 07, 2014 01:52:09 PM Richard Haines wrote:
>>  This is an RFC patch.
> 
> Thanks for your patch, I appreciate the time and effort that went into 
> developing it.
> 
> Unfortunately, I think this patch may be a bit too simplistic.  I haven't 
> looked too closely at the SCTP code in recent times, but from my earlier look, 
> SCTP associations stuck out as something that will need special handling and I 
> don't see that in this initial patch.  From what I could see, SCTP 
> associations seem close-ish to TCP connections and we may be able to handle 
> them in a similar manner, but I can't say for certain.  Someone would need 
> to 
> investigate this further.
> 
> There is also an issue of multi-homing which might, or might not, present an 
> issue for peer labeling, but once again I can't say for certain.
> 
> I'm also not entirely sure if we need any special handling for the SCTP 
> handshake (see TCP's connection request sockets).  Hopefully not, but 
> something to be aware of if you keep working on this.
> 
> I *really* don't want to scare you off of working on SCTP support, I just 
> want 
> to caution you that it likely isn't as easy as adding basic support for a 
> new 
> object class.
> 
> -- 
> paul moore
> www.paul-moore.com
> 
