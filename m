Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q26GI5GN029804
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2012 11:18:05 -0500
Received: by yhjj72 with SMTP id j72so2437470yhj.12
        for <selinux@tycho.nsa.gov>; Tue, 06 Mar 2012 08:18:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAD8iFzzymdbEM=6mZc2GNSawRFji-+FuPQAuMe61ju-UOw6YpA@mail.gmail.com>
References: <CAD8iFzx70mZyFbqTju=oVm1uLRx=Nic6Y8drsbiM-Vxqw3F8cw@mail.gmail.com>
	<1330702776.2616.43.camel@moss-pluto>
	<CAD8iFzycUJLiZynmHGiUR6s2OJVKRvoQda7n-ktUBxTf-RiFwA@mail.gmail.com>
	<CA+XzHeMaetu1zmC9KNo1VVnPan20neiXiSVYWwyC9ZmS_rx4=w@mail.gmail.com>
	<1330719989.2616.100.camel@moss-pluto>
	<CA+XzHePXLxhGxpXrtZ6AzmgZNPoZhRN9p7Em+oOStnJXnhaYiw@mail.gmail.com>
	<CAD8iFzzymdbEM=6mZc2GNSawRFji-+FuPQAuMe61ju-UOw6YpA@mail.gmail.com>
Date: Tue, 6 Mar 2012 10:18:04 -0600
Message-ID: <CA+XzHePjHOg=nFs3FTeC4iSHvbODsz3M4QKzm35zqByTJPWVMA@mail.gmail.com>
Subject: Re: SE Android on Galaxy Nexus
From: Bryan Hinton <bryan@bryanhinton.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yes, you are correct.  That mount point needs a label and the security
context should be set.

Bryan Hinton


On Mon, Mar 5, 2012 at 8:42 PM, Subramani Venkatesh
<selinuxv31@gmail.com> wrote:
> Hi Bryan,
> Thanks for the patch you posted earlier, I tried adding your changes,
> some changes works, some did not take effect for example
> "+/factory/nv_data.bin.*           u:object_r:radio_data_file:s0", I
> am seeing /factory directory as unlabeled, not sure what I am missing,
> do we need to do any change to init.rc file?
>
> Regards,
> Subbu
>
>
>
>
>
> On Fri, Mar 2, 2012 at 5:16 PM, Bryan Hinton <bryan@bryanhinton.com> wrote:
>> I agree. A per-device file_contexts file makes sense given the
>> variation in radio types between ICS based devices.
>>
>> On Fri, Mar 2, 2012 at 2:26 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On Fri, 2012-03-02 at 11:51 -0600, Bryan Hinton wrote:
>>>> Here is the latest policy that I am using.
>>>
>>> BTW, I think we will ultimately need some per-device policy files that
>>> get merged into the policy, much as there are per-device
>>> ueventd.<board>.rc and init.<board>.rc files.  At least for
>>> file_contexts, and possibly for policy rules as well.
>>>
>>> --
>>> Stephen Smalley
>>> National Security Agency
>>>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
