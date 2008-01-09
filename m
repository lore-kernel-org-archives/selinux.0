MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Re: [patch 7/7] Use -Werror
Date: Wed, 9 Jan 2008 09:19:23 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880153F432@exchange.columbia.tresys.com>
In-Reply-To: <1199884164.9393.210.camel@moss-spartans.epoch.ncsc.mil>
References: <200801072047.m07KlXAs026116@cadmus.columbia.tresys.com> <1199884164.9393.210.camel@moss-spartans.epoch.ncsc.mil>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, <method@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2008-01-07 at 15:47 -0500, Todd C. Miller wrote:
>> Stephen Smalley wrote:
>> 
>>> A bit overzealous though - some of them already had -Werror in
>>> CFLAGS. Also need to make sure that -Werror gets included by make
>>> DEBUG=1. 
>> 
>> Updated patch without the duplicated -Werror and adds it for
>> the DEBUG=1 cases.
> 
> This breaks make pywrap in libselinux, or install-pywrap from top.

I always forget that pywrap is not built by the default target.
I'll commit a fix to filter out -Werror for pywrap.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
