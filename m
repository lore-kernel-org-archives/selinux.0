Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6FIJx0Z004829
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 14:20:07 -0400
Received: by mail-oi0-f50.google.com with SMTP id l72so28691680oig.2
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 11:19:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdoHASP4V0=q6mvOmFMtOBYhgw1S7Js=fMtYQPEFr9ryxw@mail.gmail.com>
References: <1468524562-30981-1-git-send-email-william.c.roberts@intel.com>
 <CAHC9VhReO7tLcB=K6KbGpH_inzMCLVLHmYWibNFGVku27Y=kFw@mail.gmail.com>
 <CAFftDdoHOeGdwfK79aviHmFr4JxE1rX0z0vcfZZtbtvv2TL9ew@mail.gmail.com>
 <CAFftDdoHASP4V0=q6mvOmFMtOBYhgw1S7Js=fMtYQPEFr9ryxw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 15 Jul 2016 14:19:49 -0400
Message-ID: <CAHC9VhRk6UfNjVFU04jA9RPWhgbE6DdCjuzB+vQHZt9KO6_yWA@mail.gmail.com>
Subject: Re: [PATCH] selinux: print leading 0x on ioctlcmd audits
To: William Roberts <bill.c.roberts@gmail.com>
Cc: William Roberts <william.c.roberts@intel.com>,
 Steve Grubb <sgrubb@redhat.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-audit@redhat.com" <linux-audit@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Thu, Jul 14, 2016 at 7:33 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Thu, Jul 14, 2016 at 4:18 PM, William Roberts wrote:
>> On Thu, Jul 14, 2016 at 3:17 PM, Paul Moore <paul@paul-moore.com> wrote:
>>> On Thu, Jul 14, 2016 at 3:29 PM,  <william.c.roberts@intel.com> wrote:
>>> > From: William Roberts <william.c.roberts@intel.com>
>>> >
>>> > ioctlcmd is currently printing hex numbers, but their is no leading
>>> > 0x. Thus things like ioctlcmd=1234 are misleading, as the base is
>>> > not evident.
>>> >
>>> > Correct this by adding 0x as a prefix, so ioctlcmd=1234 becomes
>>> > ioctlcmd=0x1234.
>>> >
>>> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
>>> > ---
>>> >  security/lsm_audit.c | 2 +-
>>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> NOTE: adding Steve Grubb and the audit mailing list to the CC line
>>>
>>> Like it or not, I believe the general standard/convention when it
>>> comes to things like this is to leave off the "0x" prefix; the idea
>>> being that is saves precious space in the audit logs and the value is
>>> only ever going to be in hex anyway.
>>
>> Is it always in hex, what about pid?
>
> Outside of escaped untrusted input ...

That's what I've been working on the past few days and it colored my
view of things.  I tracked down Steve just now and it looks like the
preference *is* to have a "0x" prefix, my apologies for the confusion.
I'll add this to the SELinux next queue.

-- 
paul moore
www.paul-moore.com
