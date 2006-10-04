Subject: Re: [PATCH] enable/disable context translation in libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Klaus Weidner <klaus@atsec.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Linda Knippers <linda.knippers@hp.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20061004205527.GA28525@w-m-p.com>
References: <4523E6D5.1040805@hp.com>  <20061004205527.GA28525@w-m-p.com>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 17:04:49 -0400
Message-Id: <1159995889.19176.272.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-04 at 15:55 -0500, Klaus Weidner wrote:
> On Wed, Oct 04, 2006 at 12:52:37PM -0400, Linda Knippers wrote:
> > --- libselinux-1.30.28/src/setrans_client.c     2006-09-13 13:37:04.000000000 -0400
> > +++ libselinux-1.30.28.ljk/src/setrans_client.c 2006-10-04 11:35:48.000000000 -0400
> > @@ -17,6 +17,7 @@
> >  #include "setrans_internal.h"
> > 
> >  static int mls_enabled = -1;
> > +static int trans_enabled = 1;
> [...]
> > +void selinux_set_translation (int value)
> > +{
> > +       trans_enabled = value;
> > +       return;
> > +}
> 
> This is unsafe for multithreading - mls_enabled won't change during the
> lifetime of a process, but it could cause strange results when a thread
> toggling translation affects the results returned by another thread.
> 
> Does anyone care? Alternatively, should the interface offer a translation
> flag parameter, with a backwards compatible function that sets the
> translation flag to "true"?

I think that patch itself will be obsoleted by Darrel's patch for the
userspace AVC, and the use of _raw functions by mcstransd.

However, if we still wanted this patch (and addressed the other issue I
mentioned - retaining the ability to explicitly request translations but
disable automatic ones), we could simply mark the trans_enabled flag
with the __thread attribute to use thread-local storage.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
