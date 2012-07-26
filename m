MIME-Version: 1.0
In-Reply-To: <1343333073.5186.25.camel@moss-pluto.epoch.ncsc.mil>
References: <1343330131-11754-1-git-send-email-w.roberts@sta.samsung.com>
	<1343330962.5186.21.camel@moss-pluto.epoch.ncsc.mil>
	<E24EB765E1998A40A0C06DE52672C4820176F6C8A5F5@staex7mb1.telecom.sna.samsung.com>
	<1343333073.5186.25.camel@moss-pluto.epoch.ncsc.mil>
Date: Thu, 26 Jul 2012 13:30:24 -0700
Message-ID: <CAFftDdrJNDh=kNdHFiJ1xRDRed-JujhQfbhWusJC_RpmHR6j0A@mail.gmail.com>
Subject: Re: [PATCH] Support for sebool in seapp_contexts
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <w.roberts@sta.samsung.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In general I would like to add this feature. I think it is much more
palatable checking for denials and errors with the device "working",
rather then having it freak out at the splash screen. For instance,
suppose the launcher isn't in the right domain, you fix that, just to
find out some other app luanched off the launcher would fail too. If
you could just audit, you could review the denials and then make your
policy change in one movement.

Just doing it for sebool doesn't make sense to me, as adding the
boolean rule is no different than seinfo or other rules. Either it
matches or not.



On Thu, Jul 26, 2012 at 1:04 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2012-07-26 at 14:58 -0500, William Roberts wrote:
>> I've been thinking of checking the enforcing level. If it is enforcing then it should error, if it is permissive then it should warn and let the app start in the wrong context.
>>
>> When brining the system up on new platforms this is often a problem. I will make this change and resubmit.
>
> Do you mean in general (i.e. changing the err block to check
> security_getenforce), or just for the case where a boolean isn't
> defined?
>
> I have mixed feelings about checking and using security_getenforce() for
> anything other than permission denials, as it can hide problems during
> testing.  Also, in Android, it is a bit harder to switch the system back
> to permissive mode than on a conventional Linux system.
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
