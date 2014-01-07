Message-ID: <52CC2663.9020903@tycho.nsa.gov>
Date: Tue, 07 Jan 2014 11:08:03 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Kernel freak <kernelfreak@gmail.com>
Subject: Re: Allowing all access in SELinux without permissive mode.
References: <CAOFt0CSftkNgEVBaM3Hr6eb+ygYyd2JoSATTir1=EOQy5+uQmA@mail.gmail.com>	<CAFftDdq=R1Ueiz6_SGi0auF0Y8UWUmktNE7Nt8xhtjoUrKX0GQ@mail.gmail.com>	<52CAFC9C.2040708@tycho.nsa.gov>	<CAOFt0CS+YFG8HVym1rX-aiKs6=nmLWu0FPyb8L25-VyK3FDh2g@mail.gmail.com>	<52CC2088.8050809@tycho.nsa.gov>
 <CAOFt0CR7xW1+3nzZoLfGLP5Nz++Lq_yvctEU+=gM--nq+tX2eQ@mail.gmail.com>
In-Reply-To: <CAOFt0CR7xW1+3nzZoLfGLP5Nz++Lq_yvctEU+=gM--nq+tX2eQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "selinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/07/2014 11:00 AM, Kernel freak wrote:
>  Yes. Security_compute_av calls context_struct_compute_av() which does
> other checks like MLS constraints, allow_unknown flags, etc. Post that, the
> access decisions are relayed. Thinking out loud here, I need to make
> changes to security_compute_av() to make changes in how SELinux calls for
> policy data structure/policy/pseudo filesystem. Am i correct?

security_compute_av() isn't reading the policy file or any pseudo
filesystem; it is just consulting the policy data structures that are
already in kernel memory as a result of the earlier
security_load_policy() call (which is triggered by a write to
/sys/fs/selinux/load by init).  I'm not sure what kind of change you are
envisioning so it is difficult to say where you need to make it.

> Thank you. Will keep this in mind.
> 
> I hope this mail was correctly formatted. Thank you for your time.

Also, please try to avoid HTML mail; disable that in your mail client.
