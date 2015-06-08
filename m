Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t58Egldu018814
 for <selinux@tycho.nsa.gov>; Mon, 8 Jun 2015 10:42:47 -0400
Received: by ykfr66 with SMTP id r66so52907038ykf.0
 for <selinux@tycho.nsa.gov>; Mon, 08 Jun 2015 07:42:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5575947A.3070005@tresys.com>
References: <CAFPpqQEKBu2SsRN=GJj2SMvNLDW+Hj91MUTkU_L_-3DbKaW1Xg@mail.gmail.com>
 <5575947A.3070005@tresys.com>
Date: Mon, 8 Jun 2015 09:42:45 -0500
Message-ID: <CAFPpqQEqzE2777RpH_aGWGHEFs4AOd76t-wxBJAyNn8AUHCe8A@mail.gmail.com>
Subject: Re: refpolicywarn usage
From: Ted Toth <txtoth@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: text/plain; charset=UTF-8
Cc: refpolicy <refpolicy@oss.tresys.com>, SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

So many lists so little time ... I'll post to the refpolicy list next time.
Simply adding:
gen_require(` type null_device_t; ')


did the trick.

On Mon, Jun 8, 2015 at 8:11 AM, Christopher J. PeBenito
<cpebenito@tresys.com> wrote:
> On 6/5/2015 4:28 PM, Ted Toth wrote:
>> I tried to use "refpolicywarn(`$0($*) has been deprecated.')" in a
>> deprecated interface removing all of the previously defined policy.
>> However the interface is used in an 'optional' which then causes the
>> policy compilation to fail. What is the right way to handle this
>> situation?
>
> This should go to the refpolicy list.
>
> Refpolicywarn is an m4 macro, so it doesn't result in any policy.  If
> you have an optional block with only one call to an interface that only
> has a refpolicywarn in its implementation, it will result in an optional
> with no rules inside.
>
> We handle this in refpolicy by calling the new interface, e.g. if
> interface X is being replaced by interface Y, in the implementation of X
> we put a refpolicywarn message and call Y.  If there is no new
> interface, you could put safe placeholder rules, such as a call to
> dev_rw_null().
>
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> www.tresys.com | oss.tresys.com
