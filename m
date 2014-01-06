Message-ID: <52CAFC9C.2040708@tycho.nsa.gov>
Date: Mon, 06 Jan 2014 13:57:32 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>,
 Kernel freak <kernelfreak@gmail.com>
Subject: Re: Allowing all access in SELinux without permissive mode.
References: <CAOFt0CSftkNgEVBaM3Hr6eb+ygYyd2JoSATTir1=EOQy5+uQmA@mail.gmail.com>
 <CAFftDdq=R1Ueiz6_SGi0auF0Y8UWUmktNE7Nt8xhtjoUrKX0GQ@mail.gmail.com>
In-Reply-To: <CAFftDdq=R1Ueiz6_SGi0auF0Y8UWUmktNE7Nt8xhtjoUrKX0GQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "selinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/06/2014 11:32 AM, William Roberts wrote:
> On Mon, Jan 6, 2014 at 4:08 AM, Kernel freak <kernelfreak@gmail.com> wrote:
>> Hello Friends,
>>                       I am currently working on SELinux and as a part of it,
>> I need to make some changes to it. Basically, I would like to allow all
>> access requests, but not by enabling permissive mode.
> 
> That's what permissive mode is. It logs all requests not granted and
> allows them to
> happen. Why would you need to modify the code?
> 
> If you need finer granularity, you can use the permissive attribute on domains
> so in global enforcing mode, domains declared with this will run in
> permissive mode.

Also, note that the default behavior of security_compute_av() is to
allow everything until you load a policy (until ss_initialized is set).

If you want to allow everything and collect avc messages, you want
permissive mode (either global permissive mode or per-domain permissive
mode).  That logic however is in the AVC (security/selinux/avc.c) not in
the security server (security/selinux/ss/*).

If you want to allow everything and not generate avc messages, you can
just not load a policy.  security_compute_av will already allow
everything by default until you load a policy, just by setting
avd->allowed to all-bits-set.
