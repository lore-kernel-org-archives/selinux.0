MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PATCH: fix uninitialized use of handle in struct policy_file
Date: Tue, 4 Mar 2008 13:35:32 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880195CF7D@exchange.columbia.tresys.com>
In-Reply-To: <1204655672.18928.19.camel@moss-spartans.epoch.ncsc.mil>
References: <200803041436.m24EaVpO007913@cadmus.columbia.tresys.com> <1204642335.23738.96.camel@moss-spartans.epoch.ncsc.mil> <1204652295.18928.0.camel@moss-spartans.epoch.ncsc.mil> <1204655672.18928.19.camel@moss-spartans.epoch.ncsc.mil>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Joshua Brindle" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2008-03-04 at 12:38 -0500, Stephen Smalley wrote:
>> On Tue, 2008-03-04 at 09:52 -0500, Stephen Smalley wrote:
>>> On Tue, 2008-03-04 at 09:36 -0500, Todd C. Miller wrote:
>>>> Joshua Brindle wrote:
>>>>> I prefer it to memset or set the values to null explicitly, the
>>>>> caller can then set the members it wants to.
>>>> 
>>>> How about this then?
>>>> 
>>>> Signed-off-by: Todd C. Miller <tmiller@tresys.com>
>>> 
>>> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
>>> 
>>> Merge at will.
>> 
>> Likely should be applied on stable too.
> 
> I went ahead and merged it there w/ no problems.

Thanks, you beat me to it ;-)

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
