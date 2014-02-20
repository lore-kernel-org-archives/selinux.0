MIME-Version: 1.0
In-Reply-To: <20140220205709.BFC67C00005@frontend1.nyi.mail.srv.osa>
References: <20140220154726.19E25680237@frontend2.nyi.mail.srv.osa>
 <5306441F.8050207@tycho.nsa.gov>
 <20140220182215.4613AC00005@frontend1.nyi.mail.srv.osa>
 <20140220183643.GB24876@tango.0pointer.de>
 <CACLa4ps3J9i8sSqxgrn6X=X08__rv4DWUPwYpeTPC-VcYBpjAQ@mail.gmail.com>
 <20140220192644.GA28064@tango.0pointer.de>
 <CACLa4puwTAN5Qjkp1AW__v9w2vyupG-BxmtfBsZ8cyXNWD-Ppg@mail.gmail.com>
 <53065B50.1030004@redhat.com>
 <20140220205709.BFC67C00005@frontend1.nyi.mail.srv.osa>
Date: Thu, 20 Feb 2014 16:10:47 -0500
Message-ID: <CACLa4psP63Q7YYMxVA1Ei6r6AmDSrCGn+=q0-ZFrawUF2apQMA@mail.gmail.com>
Subject: Re: [systemd-devel] [PATCH] selinux: Only attempt to load policy
 exactly once, in the real root
From: Eric Paris <eparis@parisplace.org>
To: Colin Walters <walters@verbum.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: systemd Mailing List <systemd-devel@lists.freedesktop.org>,
 SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I think the idea was

if we are not in the initrd - try to load policy
if we are in the initrd and we find selinux_path() - try to load policy

Thus embeded/thin who put everything inside the initrd will work (and
the kernel enforce=1 will mean what is should)
And where we don't put anything inside the initrd will still be
correct since we'll try to load no matter what in the real root

On Thu, Feb 20, 2014 at 3:52 PM, Colin Walters <walters@verbum.org> wrote:
> On Thu, Feb 20, 2014 at 2:45 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>
> You mean "!in_initrd() || access(selinux_path(), F_OK) >= 0"?
>
>
> I don't think so - that would mean we would silently continue if
> enforcing=1, but we happen to not find a policy on disk.  Right?
>
> I think my patch is better than this - systemd will attempt to load policy
> from *only* the real root (not the initramfs), using the exact same logic as
> is in libselinux currently.
>
> For example, it would allow explicitly specifying enforcing=1 on the kernel
> command line, and that would continue to cause an explicit failure if policy
> is not found.
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>
