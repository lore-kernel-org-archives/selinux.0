To: Bill Laut <wlsel@verizon.net>
Cc: russell@coker.com.au, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: X-Windows and Client-side Buffer Overruns
References: <1057952464.5561.322.camel@moss-sooners.epoch.ncsc.mil>
	<200307311226.14299.wlsel@verizon.net>
	<200308010941.55431.russell@coker.com.au>
	<200308011320.55409.wlsel@verizon.net>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Fri, 08 Aug 2003 22:12:41 +0200
In-Reply-To: <200308011320.55409.wlsel@verizon.net> (Bill Laut's message of
 "Fri, 1 Aug 2003 13:20:55 -0400")
Message-ID: <8765l73o3q.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Bill Laut <wlsel@verizon.net> writes:

>> Also something similar needs to be done for GPG.  Currently
>> MUA's get the POP/IMAP passwords and the GPG pass-phrase in normal
>> operation...
>>
>
> That wouldn't be too hard to do.  In fact, it's something I've been toying 
> with since late 2001.  I suggest the idea of using an SELinux-powered PDA for 
> that purpose (such as a Sharp Zarus) in which the keyrings and all-important 
> asymmetric crypto functions are off-loaded from the PC and moved to the PDA, 
> and which the PC and PDA then communicate using an encrypted path through its 
> Hotsync cradle.

PDAs as heavy-weight smartcards?  Why not.

Smartcard support for GnuPG will arrive eventually, and all critical
passphrase/crypto stuff will be moved to gpg-agent, a separate
process.  (Most of this work is already done for GnuPG/X.509, I
suppose.)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
