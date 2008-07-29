Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6TDbiwj024437
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 09:37:44 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6TDbhLa024782
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 13:37:43 GMT
Message-ID: <488F1D1C.4080709@redhat.com>
Date: Tue, 29 Jul 2008 09:37:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Stephen Smalley <stephen.smalley@gmail.com>,
        Hasan Rezaul-CHR010 <CHR010@motorola.com>, selinux@tycho.nsa.gov
Subject: Re: Mapping Linux GROUP to an SELinux user ?...
References: <48881546.6070903@ak.jp.nec.com> <1216898673.3881.4.camel@sulphur>	 <D06FE0A2807BC145B0D38744789D4F5D04BF337D@de01exm68.ds.mot.com>	 <1216947967.5185.3.camel@sulphur> <10143820807281641j32da0c88v971ce52897de52e6@mail.gmail.com>
In-Reply-To: <10143820807281641j32da0c88v971ce52897de52e6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Thu, Jul 24, 2008 at 9:05 PM, Stephen Smalley
> <stephen.smalley@gmail.com> wrote:
>> On Thu, 2008-07-24 at 14:22 -0400, Hasan Rezaul-CHR010 wrote:
>>> Hi All,
>>>
>>> Is there any way at all to map an entire Linux GROUP to an SELinux_user
>>> ??
>>>
>>> For example if Linux User accounts (Admin1, Admin2, and Admin3), all
>>> belong to the Linux group  "wadm".
>>>
>>> Is there a simple or tricky way to map the entire Linux group    wadm ->
>>> to staff_u ?
>>>
>>> This way, any Linux user account that happens to be part of the "wadm"
>>> group would automatically be mapped to staff_u  ? This way we don't have
>>> to execute several semanage commands to create all those individual
>>> mappings ?
>> Not presently, but one could certainly implement such support in the
>> userland (pam_selinux + libselinux getseuserbyname).
>>
> 
> I know that we and others have done this in the past, though our
> implementation at least is not really a general solution but something
> specific for one situation.
> 
> A general solution would need to resolve what the semantics of the
> mapping would be including what to do when multiple groups match. Not
> really a problem, just requires some thought.
> 
> Karl
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
First get seusers out of libsemanage.

libsemanage can be used to verify the selinux user exists and the level.
 Then use the same syntax as sudo, I believe group name is preceded by
an @ sign.

@engineering


I will code up a patch for libselinux, but we need work to allow
semanage to add this syntax.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
