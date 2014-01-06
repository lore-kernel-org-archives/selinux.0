MIME-Version: 1.0
In-Reply-To: <CAOFt0CSftkNgEVBaM3Hr6eb+ygYyd2JoSATTir1=EOQy5+uQmA@mail.gmail.com>
References: <CAOFt0CSftkNgEVBaM3Hr6eb+ygYyd2JoSATTir1=EOQy5+uQmA@mail.gmail.com>
Date: Mon, 6 Jan 2014 08:32:51 -0800
Message-ID: <CAFftDdq=R1Ueiz6_SGi0auF0Y8UWUmktNE7Nt8xhtjoUrKX0GQ@mail.gmail.com>
Subject: Re: Allowing all access in SELinux without permissive mode.
From: William Roberts <bill.c.roberts@gmail.com>
To: Kernel freak <kernelfreak@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "selinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jan 6, 2014 at 4:08 AM, Kernel freak <kernelfreak@gmail.com> wrote:
> Hello Friends,
>                       I am currently working on SELinux and as a part of it,
> I need to make some changes to it. Basically, I would like to allow all
> access requests, but not by enabling permissive mode.

That's what permissive mode is. It logs all requests not granted and
allows them to
happen. Why would you need to modify the code?

If you need finer granularity, you can use the permissive attribute on domains
so in global enforcing mode, domains declared with this will run in
permissive mode.

I checked the code
> from SELinux/ss/services.c. The 2 main functions that can be helpful are
> security_compute_av() and context_struct_compute_av(). The 1st call has the
> parameters that I need to make other things work like the ssid, tsid, etc.
> But how to allow all access request. I am posting some code for handy
> reference. Thank you for your time.
>
> /**
>
>  * security_compute_av - Compute access vector decisions.
>
>  * @ssid: source security identifier
>
>  * @tsid: target security identifier
>
>  * @tclass: target security class
>
>  * @requested: requested permissions
>
>  * @avd: access vector decisions
>
>  *
>
>  * Compute a set of access vector decisions based on the
>
>  * SID pair (@ssid, @tsid) for the permissions in @tclass.
>
>  * Return -%EINVAL if any of the parameters are invalid or %0
>
>  * if the access vector decisions were computed successfully.
>
>  */
>
> int security_compute_av(u32 ssid,
>
> u32 tsid,
>
> u16 tclass,
>
> u32 requested,
>
> struct av_decision *avd)
>
> {
>
> struct context *scontext = NULL, *tcontext = NULL;
>
> int rc = 0;
>
>
> if (!ss_initialized) {
>
> avd->allowed = 0xffffffff;
>
> avd->auditallow = 0;
>
> avd->auditdeny = 0xffffffff;
>
> avd->seqno = latest_granting;
>
> return 0;
>
> }
>
>
> read_lock(&policy_rwlock);
>
>
> scontext = sidtab_search(&sidtab, ssid);
>
> if (!scontext) {
>
> printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
>
>       __func__, ssid);
>
> rc = -EINVAL;
>
> goto out;
>
> }
>
> tcontext = sidtab_search(&sidtab, tsid);
>
> if (!tcontext) {
>
> printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
>
>       __func__, tsid);
>
> rc = -EINVAL;
>
> goto out;
>
> }
>
>
> rc = context_struct_compute_av(scontext, tcontext, tclass,
>
>       requested, avd);
>
>
> /* permissive domain? */
>
> if (ebitmap_get_bit(&policydb.permissive_map, scontext->type))
>
>    avd->flags |= AVD_FLAGS_PERMISSIVE;
>
> out:
>
> read_unlock(&policy_rwlock);
>
> return rc;
>
> }
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



-- 
Respectfully,

William C Roberts
