Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4KGqAuv016264
 for <selinux@tycho.nsa.gov>; Tue, 20 May 2014 12:52:10 -0400
References: <1400242442.444.9.camel@x220.localdomain>
 <53761EB7.5060906@tycho.nsa.gov> <1400252744.444.12.camel@x220.localdomain>
Message-ID: <1400602950.86381.YahooMailNeo@web87901.mail.ir2.yahoo.com>
Date: Tue, 20 May 2014 17:22:30 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: secilc: classmappings do not work
To: Dominick Grift <dominick.grift@gmail.com>, selinux <selinux@tycho.nsa.gov>,
 James Carter <jwcart2@tycho.nsa.gov>
In-Reply-To: <1400252744.444.12.camel@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



>> 
>>  Would this new syntax make more sense to you?
> 
> Yes i suppose it would as i actually wanted to try that (eventually i
> did not bother to try it though since i just trusted the cil reference
> guide which made no mention of it.

Please be aware that the CIL Reference Guide is first draft and there
are some errors in it. These are the known ones:
1) The 2nd defaultuser title should be 'defaulttype'.
2) Optionals do support the filename typetransition statement.
3) Need to rewrite the classmap/classmapping sections and state format
    will be changing.
4) Anonymous classpermissionsets now allow expressions.
5) classmap can now be used in defaultuser etc. statements as
   mentioned in previous email (although just reported a small problem).

If anyone finds errors or the examples need expanding then please let me
know as I plan to keep it updated as the compiler progresses

Richard
