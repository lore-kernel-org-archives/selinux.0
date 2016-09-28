Subject: Re: DISABLE_AVC=y
To: William Roberts <bill.c.roberts@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <CAFftDdo3rRxW=qEzcLJbAABxJ09XmEK6_=x_6TiiZ5avxM9opQ@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a1666e63-9f17-e61e-23ce-09ada3ff993a@tycho.nsa.gov>
Date: Wed, 28 Sep 2016 10:58:12 -0400
MIME-Version: 1.0
In-Reply-To: <CAFftDdo3rRxW=qEzcLJbAABxJ09XmEK6_=x_6TiiZ5avxM9opQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/28/2016 10:39 AM, William Roberts wrote:
> Does anyone actualy use this, this currently doesn't build:
> 
> compute_av.c: In function ‘security_compute_av_flags_raw’:
> compute_av.c:65:28: error: suggest braces around empty body in an ‘if’
> statement [-Werror=empty-body]
>    map_decision(tclass, avd);
>                             ^
> cc1: all warnings being treated as errors
> make[1]: *** [compute_av.o] Error 1
> 
> clude -D_GNU_SOURCE -DDISABLE_AVC   -c -o compute_av.o compute_av.c
> compute_av.c: In function ‘security_compute_av_flags_raw’:
> compute_av.c:65:28: error: expected expression before ‘;’ token
>    map_decision(tclass, avd);
>                             ^
> make[1]: *** [compute_av.o] Error 1
> make[1]: Leaving directory `/home/wc
> 
> Should we fix it or kill it off?

I am not aware of any users of it; it is a legacy of some early work on
embedded SELinux but does not appear to be used in current solutions
(e.g. meta-selinux does not use it).  So I would just kill it.
Especially since the userspace AVC is used by many userspace programs
now in Linux and in Android.
