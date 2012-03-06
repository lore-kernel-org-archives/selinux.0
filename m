MIME-Version: 1.0
In-Reply-To: <CA+XzHePXLxhGxpXrtZ6AzmgZNPoZhRN9p7Em+oOStnJXnhaYiw@mail.gmail.com>
References: <CAD8iFzx70mZyFbqTju=oVm1uLRx=Nic6Y8drsbiM-Vxqw3F8cw@mail.gmail.com>
	<1330702776.2616.43.camel@moss-pluto>
	<CAD8iFzycUJLiZynmHGiUR6s2OJVKRvoQda7n-ktUBxTf-RiFwA@mail.gmail.com>
	<CA+XzHeMaetu1zmC9KNo1VVnPan20neiXiSVYWwyC9ZmS_rx4=w@mail.gmail.com>
	<1330719989.2616.100.camel@moss-pluto>
	<CA+XzHePXLxhGxpXrtZ6AzmgZNPoZhRN9p7Em+oOStnJXnhaYiw@mail.gmail.com>
Date: Mon, 5 Mar 2012 21:42:45 -0500
Message-ID: <CAD8iFzzymdbEM=6mZc2GNSawRFji-+FuPQAuMe61ju-UOw6YpA@mail.gmail.com>
Subject: Re: SE Android on Galaxy Nexus
From: Subramani Venkatesh <selinuxv31@gmail.com>
To: Bryan Hinton <bryan@bryanhinton.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Bryan,
Thanks for the patch you posted earlier, I tried adding your changes,
some changes works, some did not take effect for example
"+/factory/nv_data.bin.*           u:object_r:radio_data_file:s0", I
am seeing /factory directory as unlabeled, not sure what I am missing,
do we need to do any change to init.rc file?

Regards,
Subbu





On Fri, Mar 2, 2012 at 5:16 PM, Bryan Hinton <bryan@bryanhinton.com> wrote:
> I agree. A per-device file_contexts file makes sense given the
> variation in radio types between ICS based devices.
>
> On Fri, Mar 2, 2012 at 2:26 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On Fri, 2012-03-02 at 11:51 -0600, Bryan Hinton wrote:
>>> Here is the latest policy that I am using.
>>
>> BTW, I think we will ultimately need some per-device policy files that
>> get merged into the policy, much as there are per-device
>> ueventd.<board>.rc and init.<board>.rc files.  At least for
>> file_contexts, and possibly for policy rules as well.
>>
>> --
>> Stephen Smalley
>> National Security Agency
>>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
