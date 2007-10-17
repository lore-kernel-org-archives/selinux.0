MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Recurring SELinux events for similar violations...
Date: Wed, 17 Oct 2007 18:22:33 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D040E251B@de01exm68.ds.mot.com>
In-Reply-To: <7e0fb38c0710171518r645c1ce1l3e0653109f2d27b2@mail.gmail.com>
References: <C3357D99.2F091%csellers@tresys.com> <1192356878.3376.3.camel@vogon> <47135FCE.5000403@redhat.com> <1192467177.28762.7.camel@blentz> <1192467538.29203.52.camel@moss-spartans.epoch.ncsc.mil> <4713B257.9020409@redhat.com> <1192473631.29203.56.camel@moss-spartans.epoch.ncsc.mil> <1192475354.2910.14.camel@localhost.localdomain> <1192650454.20908.30.camel@moss-spartans.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D040E2506@de01exm68.ds.mot.com> <7e0fb38c0710171518r645c1ce1l3e0653109f2d27b2@mail.gmail.com>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Eric Paris" <eparis@parisplace.org>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yes, I am running in "Permissive" mode right now, just for testing
purposes.

If this is by design, is there any way I can force SELinux to log every
denial even in Permissive mode ?

Thanks,

- Rezaul.
  

-----Original Message-----
From: Eric Paris [mailto:eparis@parisplace.org] 
Sent: Wednesday, October 17, 2007 5:19 PM
To: Hasan Rezaul-CHR010
Cc: Stephen Smalley; Daniel J Walsh; selinux@tycho.nsa.gov
Subject: Re: Recurring SELinux events for similar violations...

Are you running without enforcing just for testing?  When you turn off
enforcing it only logs once (by design) but I think it should log the
denial every single time in enforcing mode.

-Eric

On 10/17/07, Hasan Rezaul-CHR010 <CHR010@motorola.com> wrote:
> Hi All,
>
> I am using a Fedora 6 STRICT policy as my base, and have written some
> additional custom policies on top.
>
> For example, I have allowed certain domains (e.g. staff_t) to modify
> file types of  etc_t
> And I have disallowed other domains (e.g. user_t) to modify file types
> of etc_t.
>
> When user_t makes the first attempt to modify an etc_t file, I do get
> DENY events  :-)
>
> But subsequent attempts by user_t to modify etc_t files  *DO NOT*
> generate any more events ?!?
>
> - Is this by design ???
>
> - Is there something I can do such that  EVERY time user_t  attempts
to
> modify a file type etc_t , I will get a corresponding DENY ?
>
> - In other words, I would like every violation attempt to be reported
in
> the audit.log file, even if the same violation occurs multiple times
in
> the same session.
>
> Thanks in advance,
>
> - Rezaul.
>
>
> --
> This message was distributed to subscribers of the selinux mailing
list.
> If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
