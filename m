MIME-Version: 1.0
In-Reply-To: <1343415341.17570.85.camel@moss-pluto.epoch.ncsc.mil>
References: <1343330131-11754-1-git-send-email-w.roberts@sta.samsung.com>
	<1343330962.5186.21.camel@moss-pluto.epoch.ncsc.mil>
	<E24EB765E1998A40A0C06DE52672C4820176F6C8A5F5@staex7mb1.telecom.sna.samsung.com>
	<1343333073.5186.25.camel@moss-pluto.epoch.ncsc.mil>
	<CAFftDdrJNDh=kNdHFiJ1xRDRed-JujhQfbhWusJC_RpmHR6j0A@mail.gmail.com>
	<1343396040.17570.9.camel@moss-pluto.epoch.ncsc.mil>
	<CAFftDdoQrHs7o5hgBQ6skFvFdPsmWAEJP8oYE7h_tqQrEg8NPQ@mail.gmail.com>
	<1343415004.17570.80.camel@moss-pluto.epoch.ncsc.mil>
	<1343415341.17570.85.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 27 Jul 2012 12:05:41 -0700
Message-ID: <CAFftDdqtrrLPB+4g9HnXybFGtDdB=t_hKD4Xftq6GT=c3NcTWg@mail.gmail.com>
Subject: Re: [PATCH] Support for sebool in seapp_contexts
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yeah IMO the SELinux Error messages in Logact are sufficient and their
is no need to make it more complex.
I wasn't sure if we wanted to follow the kernel convention.

On Fri, Jul 27, 2012 at 11:55 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2012-07-27 at 14:50 -0400, Stephen Smalley wrote:
>> On Fri, 2012-07-27 at 11:30 -0700, William Roberts wrote:
>> > Yeah but the Zygote failures will be in logcat, so if you missed them
>> > when you were testing in permissive mode, then its your problem. This
>> > is the same behavior as the rest of the system, we just need to agree
>> > upon a "avc denied" message for Zygote and teach the SEAndroidManager
>> > app to look for those too.
>> >
>> > I don't think I can advise as to the best message and was looking to
>> > you for a possible formatting for it?
>>
>> It isn't an avc denial.  I don't remember now whether we wired up the
>> callback to prefix these messages with SELinux?  If so, then that should
>> suffice as a keyword for filtering the logs.
>
> Commented out the untrusted_app line and tried running a third party
> app.  Got this message in logcat *:E:
> E/SELinux ( 1229): selinux_android_setcontext:  No match for app with
> uid 10055, seinfo default, name com.adobe.reader
>
> So you can already use SELinux as the keyword for filtering, and then
> pull out the relevant fields.  It isn't an AVC message though.
>
> --
> Stephen Smalley
> National Security Agency
>



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
