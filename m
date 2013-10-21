Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9LEMTSM008194
	for <selinux@tycho.nsa.gov>; Mon, 21 Oct 2013 10:22:32 -0400
References: <52617C02.4060500@tycho.nsa.gov> <1382199839.82880.YahooMailNeo@web87903.mail.ir2.yahoo.com> <52652DE1.4020504@tresys.com>
Message-ID: <1382365347.75138.YahooMailNeo@web87902.mail.ir2.yahoo.com>
Date: Mon, 21 Oct 2013 15:22:27 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Update to CIL
To: Steve Lawrence <slawrence@tresys.com>
Cc: James Carter <jwcart2@tycho.nsa.gov>,
        Dominick Grift <dominick.grift@gmail.com>,
        SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <52652DE1.4020504@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



>>  4) Not sure if this is a bug or 'as designed', I tried using 
> "in" in a
>>      booleanif statement but failed. The "in-boolean.cil" module 
> demos
>>      this error.
>> 
> 
> This should not be allowed. The only thing that should be allowed in a 
> booleanif statement are typetransitions, typerules, and avrules.
> 
> 
Regarding the allowed items - the 'call' statement is also allowed as I'm using it
already on both versions of the compiler so it seemed strange to exclude the 'in'
statement.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
