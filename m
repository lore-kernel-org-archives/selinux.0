Message-ID: <cadfc0e40901050906q6c04406fga1d490d72646e41c@mail.gmail.com>
Date: Mon, 5 Jan 2009 11:06:31 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: limitations of CONTEXT__CONTAINS interface
Cc: "Eamon Walsh" <ewalsh@tycho.nsa.gov>,
        "SELinux List" <selinux@tycho.nsa.gov>
In-Reply-To: <1231161507.3102.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4939CB81.1030707@tycho.nsa.gov>
	 <1228746149.18446.2.camel@localhost.localdomain>
	 <cadfc0e40812191327i4ff72368yda3de3396d46524@mail.gmail.com>
	 <1231161507.3102.6.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jan 5, 2009 at 7:18 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2008-12-19 at 15:27 -0600, Xavier Toth wrote:
>> On Mon, Dec 8, 2008 at 8:22 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> > On Fri, 2008-12-05 at 19:46 -0500, Eamon Walsh wrote:
>> >> The attached C code uses the CONTEXT__CONTAINS permission check to check
>> >> dominance, and produces the following output on my mls box:
>> >>
>> >> staff_u:staff_r:staff_t:s15:c0.c255 dominates staff_u:staff_r:staff_t:s0
>> >>
>> >> system_u:object_r:etc_t:s15:c0.c255 does not dominate system_u:object_r:etc_t:s0
>> >>
>> >>
>> >> Why doesn't this check work in the second case?
>> >
>> > Likely due to a TE denial.  The existing policy likely only has:
>> > allow domain self:context contains;
>> > as the original use case for this check was to apply a check between two
>> > subject contexts.
>> >
>> > If you want to use it for object contexts, you'll have to allow it for
>> > those types as well.
>> >
>> >> My color translation code has a config file that may contain lines such
>> >> as (paraphrasing):
>> >> range s0 = green
>> >> range s1 = yellow
>> >> range s1:c1 = blue
>> >> range s15:c0.c255 = red
>> >>
>> >> and so forth, which are matched with incoming contexts using a dominance
>> >> check.  The observed behavior above is causing this not to work.
>> >
>> > --
>> > Stephen Smalley
>> > National Security Agency
>> >
>> >
>> > --
>> > This message was distributed to subscribers of the selinux mailing list.
>> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> > the words "unsubscribe selinux" without quotes as the message.
>> >
>>
>> Can anyone help me understand the results I'm getting here? I wrote
>> this python script (compute_av.py) to test the dominance check:
>>
>> import selinux
>> SECCLASS_CONTEXT = selinux.string_to_security_class("context")
>> CONTEXT__CONTAINS = 2
>>
>> rc, con = selinux.getcon()
>> con_array = con.split(":")
>>
>> avd = selinux.av_decision()
>> con_array[3] = "s0:c0.c255"
>> ctx = ':'.join(con_array)
>> con_array[3] = "s0"
>> raw = ':'.join(con_array)
>> rc = selinux.security_compute_av_raw(ctx, raw, SECCLASS_CONTEXT,
>> CONTEXT__CONTAINS, avd)
>> print ctx, raw, avd.allowed
>>
>>
>> [tedx@comms ~]$ runcon system_u:system_r:initrc_t:s0-s15:c0.c1023
>> python compute_av.py
>> system_u:system_r:initrc_t:s0:c0.c255 system_u:system_r:initrc_t:s0 0
>> [tedx@comms ~]$ python compute_av.py
>> user_u:user_r:user_t:s0:c0.c255 user_u:user_r:user_t:s0 2
>>
>>
>> I ran these test in permissive mode. Why doesn't
>> system_u:system_r:initrc_t:s0:c0.c255 dominate
>> system_u:system_r:initrc_t:s0?
>
> Existing policy likely only allows context contains permission for the
> user domains, as that was the only original use case for it (for
> checking whether a specified user context is contained by another).
>
> --
> Stephen Smalley
> National Security Agency
>
>

I posted a refpolicy patch to allow setrans_t this premission because
the mcstrans color patch requires it.

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
