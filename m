Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n33ID2Bu021263
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 14:13:02 -0400
Received: from manicmethod.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n33ID1fC003518
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 18:13:02 GMT
Message-ID: <49D651A7.1000703@manicmethod.com>
Date: Fri, 03 Apr 2009 14:12:55 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>, refpolicy@oss.tresys.com,
        selinux@tycho.nsa.gov
Subject: Re: [refpolicy] [RFC] Security policy reworks for SE-PostgreSQL
References: <49D1DA85.1030902@ak.jp.nec.com>	 <49D4743C.2010000@ak.jp.nec.com>  <49D4CB6E.1090900@manicmethod.com> <1238684951.32379.311.camel@gorn.columbia.tresys.com> <49D563A9.1000607@ak.jp.nec.com>
In-Reply-To: <49D563A9.1000607@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> Christopher J. PeBenito wrote:
>> On Thu, 2009-04-02 at 10:27 -0400, Joshua Brindle wrote:
>>> KaiGai Kohei wrote:
>>>> Chris,
>>>>
>>>> What is your opinion about this reworks?
>>>> If its scale is too large to commit at once, I can separate it
>>>> into several pieces.
>>>>
>>> I don't think it is a good idea to merge the object class changes at this point.
>>> The object classes and permissions are likely to change with sepostgresql going
>>> forward, as that community determines what they like and don't like
>>> access-control wise.
>>>
>>> Additionally there is another object manager (RUBIX) that is now going to be
>>> reliant on these object classes so it would be nice for them to work out some of
>>> their implementation just to be sure these are sufficient and finally merging
>>> these object class changes is going to break the sepostgres that is in fedora
>>> right now.
>> Agreed.  I don't want to merge any object class changes until they have
>> settled down.  I'd prefer that the patches to the object manager be on a
>> path for upstream acceptance in both databases, if not already committed
>> to their trees, before moving forward on the object class changes in the
>> policy.
> 
> As I noted in the previous message, it give me a deadlock. :(
> 
> I don't think it is a realistic assumption that pgsql-hackers are
> well motivated to modify or replace the default security policy to
> review and test the proposed features. I guess it gives us negative
> effect to upstream the SE-PostgreSQL feature in the v8.5 release.
> 

They will have to do some policy updates to test the functionality no matter
what. I don't think it is *that* unreasonable for them to update the base policy
(from their perspective it shouldn't be any different anyway)

> At least, these new object classes don't have any strange behavior.
> The vanilla PostgreSQL also has similar permissions, so it convinces
> me they can accept these permissions, more than nothing for them.
> 

Except you were removing permissions in the patch, which would break the
sepostgres that is in the Fedora tree.

> Again, I would like to get the reworks merged in this timing.
> (In addition, it also makes RUBIX happy on Fedora 11 or later.)
> 

Fedora 11 is already frozen, new object classes shouldn't be working their way
in to that, so we have a release cycle to adjust the permissions to match the
implementation, both on the upstream sepostgres side and the RUBIX side before
pushing those in to refpolicy.

Once some implementation starts and the security model settles it may be a
different story, I just don't think it is appropriate to merge them at this
point. (In particular I want to see if the new proposed object classes and perms
will really work for RUBIX, and I want to see how much of the patch the upstream
postgres project will take for the next release).

As it stands we are going to have 3 selinux aware databases floating around
using slightly different object classes and permissions, which is not ideal.
Having all those in upstream refpolicy means it is harder to change them and the
unused permissions are going to sit there causing confusion (even worse, they'll
be unused by 2 of the 3 systems but still in use by the previous version of
sepostgres).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
