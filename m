MIME-Version: 1.0
In-Reply-To: <1316790421.10259.70.camel@moss-pluto>
References: <4E7B9233.6080609@redhat.com>
	<1316723465.2354.6.camel@moss-pluto>
	<4E7B9B43.9000400@redhat.com>
	<1316723821.2354.9.camel@moss-pluto>
	<1316724121.2354.12.camel@moss-pluto>
	<4E7C9F3D.9030704@redhat.com>
	<1316790421.10259.70.camel@moss-pluto>
Date: Sat, 24 Sep 2011 18:05:20 -0400
Message-ID: <CAEXv5_hX_dG8+YeJPOdxZafxV2Nf2dM=CKpstUf+vzdYaw2TLw@mail.gmail.com>
Subject: Re: I would like to change the behavior of MCS label creations in directory.
From: David Windsor <dwindsor@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 23, 2011 at 11:07 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

<snip>

>>
>>       level_default file fromsource; == MLS;
>>       level_default file fromtarget; == MCS;
>>
>> Anyone want to step forward and implement?  :^)
>
> Need to distinguish low vs high.  In MLS, you want to inherit the low
> level of the source/subject/process.
>
> Also, do you want the MCS behavior for all types or selectively?  For
> example, if a svirt_t:s0:c256,c387 process creates a file in a :s0
> directory (is that even possible?), do you really want that file to
> be :s0?
>

Couldn't you use a range_transition in this case to specify an
exception to the default behavior for category inheritance?

AFAICS, using rules such as (user|role|type|level|range)_default,
we're only specifying default labeling behaviors for the different
fields of a context.  More specific *_transition rules can exist in
policy that should override any defaults defined elsewhere.

Thanks,
David

> --
> Stephen Smalley
> National Security Agency
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>



-- 
PGP: 6141 5FFD 11AE 9844 153E  F268 7C98 7268 6B19 6CC9


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
