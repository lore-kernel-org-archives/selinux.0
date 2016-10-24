Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9OEgVMx023057
 for <selinux@tycho.nsa.gov>; Mon, 24 Oct 2016 10:42:32 -0400
Received: by mail-oi0-f69.google.com with SMTP id f78so77441271oih.7
 for <selinux@tycho.nsa.gov>; Mon, 24 Oct 2016 07:42:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <576dac61-bebb-cdd2-f69d-ce369a79cede@tycho.nsa.gov>
References: <1477088418.3651.15.camel@chicago.vc>
 <576dac61-bebb-cdd2-f69d-ce369a79cede@tycho.nsa.gov>
From: Judd Meinders <judd.meinders@rockwellcollins.com>
Date: Mon, 24 Oct 2016 09:42:27 -0500
Message-ID: <CAGReGbQBMVbNRVp9s0s6iJEBDP0pDVgOS+ys--5EJzVS34M6RA@mail.gmail.com>
Subject: Re: Question for the experts -- DIRTY COW and SELinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Robert Lee <robert.lee@chicago.vc>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Oct 24, 2016 at 9:35 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 10/21/2016 06:20 PM, Robert Lee wrote:
> > Given the unpleasant nature of CVE-2016-5195, would an SELinux confined
> > application that exploited the Dirty COW vulnerability be capable also
> > of escaping domain enforcement?
> >
> > Hopefully my question is not ambiguous.
> >
> > Thanks in advance.
>
> Sorry, SELinux can't help with CVE-2016-5195.
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

Couldn't SELinux help reduce the attack surface.  From the small
amount of testing I have conducted, it looks like the attacker is
required to be able to read the file or object they are trying to
manipulate.  If MAC denies read, the attack doesn't work right?

Please let me know if I'm mistaken.


-- 
Judd Meinders
Sr. Software Security Engineer
e. judd.meinders@rockwellcollins.com
p. 319-263-1875
