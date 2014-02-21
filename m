Date: Fri, 21 Feb 2014 03:33:15 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Colin Walters <walters@verbum.org>
Subject: Re: [systemd-devel] [PATCH] selinux: Only attempt to load policy
 exactly once, in the real root
Message-ID: <20140221023312.GF14086@tango.0pointer.de>
References: <20140220182215.4613AC00005@frontend1.nyi.mail.srv.osa>
 <20140220183643.GB24876@tango.0pointer.de>
 <CACLa4ps3J9i8sSqxgrn6X=X08__rv4DWUPwYpeTPC-VcYBpjAQ@mail.gmail.com>
 <20140220192644.GA28064@tango.0pointer.de>
 <CACLa4puwTAN5Qjkp1AW__v9w2vyupG-BxmtfBsZ8cyXNWD-Ppg@mail.gmail.com>
 <53065B50.1030004@redhat.com>
 <20140220205709.BFC67C00005@frontend1.nyi.mail.srv.osa>
 <CACLa4psP63Q7YYMxVA1Ei6r6AmDSrCGn+=q0-ZFrawUF2apQMA@mail.gmail.com>
 <20140220212635.7EC19C007AB@frontend1.nyi.mail.srv.osa>
 <20140220234907.001CFC007AA@frontend1.nyi.mail.srv.osa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140220234907.001CFC007AA@frontend1.nyi.mail.srv.osa>
Cc: systemd Mailing List <systemd-devel@lists.freedesktop.org>,
 SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 20.02.14 23:44, Colin Walters (walters@verbum.org) wrote:

> On Thu, Feb 20, 2014 at 4:21 PM, Colin Walters <walters@verbum.org>
> wrote:
> >
> >I'm testing this suggested patch now.
> >
> I tweaked the suggestion a bit because the selinux_path() API call
> made the most sense inside selinux-setup.c.  Attached patch works
> for me.

It's actually even easier than this patch, as in_initrd() is a normal
exported function, we can call it directly from selinux_setup(). I have
made that change to your patch and commited it. Please test!

Thanks!

Lennart

-- 
Lennart Poettering, Red Hat
