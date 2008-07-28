Message-ID: <488E22B2.4060805@windriver.com>
Date: Mon, 28 Jul 2008 15:49:06 -0400
From: Vikram Ambrose <Vikram.Ambrose@windriver.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Stephen Smalley <stephen.smalley@gmail.com>,
        Chris PeBenito <pebenito@gentoo.org>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: libsepol.context_from_record: MLS is disabled, but	MLS	context"s0"
 found
References: <4888E754.9030504@windriver.com>	 <1216944435.4931.20.camel@defiant.pebenito.net>	 <6FE441CD9F0C0C479F2D88F959B015880246B40D@exchange.columbia.tresys.com>	 <1216997739.5392.14.camel@defiant.pebenito.net>	 <1216998548.4906.2.camel@defiant.pebenito.net>	 <1217032502.14295.1.camel@sulphur>  <488DECEB.1090607@windriver.com> <1217263797.20373.22.camel@moss-spartans.epoch.ncsc.mil> <488E06ED.8080003@windriver.com> <06A6610D4F464D4EBEAFBF2C5F86911E7FA2@exchange2.columbia.tresys.com>
In-Reply-To: <06A6610D4F464D4EBEAFBF2C5F86911E7FA2@exchange2.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[snip]
Karl MacMillan wrote:
>
> Here's a patch - I'd appreciate testing on a non-MLS system as I don't
> have one handy right now.
>
> Karl
>
> ----
> Karl MacMillan
> Tresys Technology
> (410) 290-1411 ext. 173
> kmacmillan@tresys.com
>
>   
Patch works. Applied and tested with selinux-svn2928. Thank you Karl.

Vikram

-- 
Vikram Ambrose | Linux Products Division | WindRiver Corporation


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
