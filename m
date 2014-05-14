Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4ELRJq8010478
 for <selinux@tycho.nsa.gov>; Wed, 14 May 2014 17:27:19 -0400
Received: by mail-ve0-f182.google.com with SMTP id sa20so212534veb.13
 for <selinux@tycho.nsa.gov>; Wed, 14 May 2014 14:27:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1904410.NyD4ciNI6n@sifl>
References: <20140514155807.32072.32113.stgit@localhost>
 <537399A8.2000405@tycho.nsa.gov> <1904410.NyD4ciNI6n@sifl>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 14 May 2014 14:26:59 -0700
Message-ID: <CALCETrW9WNVQoRFxy+T5Gs9Ct+1L-_bycTukWQdEgDgkZQKh1g@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: prevent setting a security label on
 MNT_NOSUID applications
To: Paul Moore <pmoore@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 14, 2014 at 2:00 PM, Paul Moore <pmoore@redhat.com> wrote:
> On Wednesday, May 14, 2014 09:18:35 AM Andy Lutomirski wrote:
>> > On Wed, May 14, 2014 at 8:58 AM, Paul Moore <pmoore@redhat.com> wrote:
>> >> We presently prevent processes from explicitly setting an arbitrary
>> >> security label on new processes when NO_NEW_PRIVS is enabled; in an
>> >> attempt for more consistency, this patch extends this to prevent
>> >> setting an arbitrary label when the new application lives on a
>> >> filesystem mounted with MNT_NOSUID.
>> >>
>> >> Signed-off-by: Paul Moore <pmoore@redhat.com>
>> >> CC: Andy Lutomirski <luto@amacapital.net>
>> >> CC: Stephen Smalley <sds@tycho.nsa.gov>
>> >> ---
>> >
>> Acked-by: Andy Lutomirski <luto@amacapital.net>
>>
>> I'm also unconvinced by the subject line -- would "selinux: return an
>> error when rejecting settexeccon on MNT_NOSUID applications" be
>> better?
>
> ...
>
> On Wednesday, May 14, 2014 12:28:24 PM Stephen Smalley wrote:
>> On 05/14/2014 11:58 AM, Paul Moore wrote:
>> > We presently prevent processes from explicitly setting an arbitrary
>> > security label on new processes when NO_NEW_PRIVS is enabled; in an
>> > attempt for more consistency, this patch extends this to prevent
>> > setting an arbitrary label when the new application lives on a
>> > filesystem mounted with MNT_NOSUID.
>>
>> It is never arbitrary (the new value is always controlled by policy),
>> and it isn't set on "new processes" per se but rather transitioned to
>> upon an exec.  Anyway, the point of the change is to return an error
>> rather than silently ignore any /proc/self/attr/exec value when
>> executing from a nosuid mount.
>>
>> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
>
> I had a feeling while writing the patch description yesterday that someone was
> not going to be happy with the text ... does the subject/description below
> sound better to you guys?
>
> ***
> selinux: reject setexeccon() on MNT_NOSUID applications with -EACCES
>
> We presently prevent processes from using setexecon() to set the security
> label of exec()'d processes when NO_NEW_PRIVS is enabled by returning an
> error; however, we silently ignore setexeccon() when exec()'ing from a nosuid
> mounted filesystem.  This patch makes things a bit more consistent by
> returning an error in the setexeccon()/nosuid case.
> ***

Looks good to me.

--Andy
