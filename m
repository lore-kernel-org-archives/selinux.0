Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w76JlmTj019998
 for <selinux@tycho.nsa.gov>; Mon, 6 Aug 2018 15:47:48 -0400
Received: by mail-oi0-f67.google.com with SMTP id q11-v6so24292111oic.12
 for <selinux@tycho.nsa.gov>; Mon, 06 Aug 2018 12:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180803093604.38254-1-jannh@google.com>
 <CAHC9VhT83LuwuGB4ndVpkqtfLZ2Se1Qqhw57CTEZ-5bzPATiag@mail.gmail.com>
In-Reply-To: <CAHC9VhT83LuwuGB4ndVpkqtfLZ2Se1Qqhw57CTEZ-5bzPATiag@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 6 Aug 2018 21:47:02 +0200
Message-ID: <CAG48ez0UPrDQ1t=3gWB3ahj3ksc1_FAC0T6-y2ngi6tLTpUUxg@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: stricter parsing in
 mls_context_to_sid()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Aug 4, 2018 at 2:01 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Aug 3, 2018 at 5:36 AM Jann Horn <jannh@google.com> wrote:
> >
> > mls_context_to_sid incorrectly accepted MLS context strings that are
> > followed by a dash and trailing garbage.
> >
> > Before this change, the following command works:
> >
> > # mount -t tmpfs -o 'context=system_u:object_r:tmp_t:s0-s0:c0-BLAH' \
> > none mount
> >
> > After this change, it fails with the following error message in dmesg:
> >
> > SELinux: security_context_str_to_sid(system_u:object_r:tmp_t:s0-s0:c0-BLAH)
> > failed for (dev tmpfs, type tmpfs) errno=-22
> >
> > This is not an important bug; but it is a small quirk that was useful for
> > exploiting a vulnerability in fusermount.
> >
> > This patch does not change the behavior when the policy does not have MLS
> > enabled.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  security/selinux/ss/mls.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Ooof.  mls_context_to_sid() isn't exactly the most elegant function is
> it?  I suppose some of that is due to the label format, but it still
> seems like we can do better.  However, before I jump into that let me
> say that speaking strictly about your patch, yes, it does look correct
> to me.
>
> What I'm wonder is if we rework/reorder some of the parser to remove
> some of the ordering specific (e.g. "l == 0") and reduce some
> redundancy ... be patient with me for a moment ...
>
> The while loops immediately following the "Extract low sensitivity"
> and "Extract high sensitivity" comments are basically the same,
> including NULL'ing the delimiter if necessary, the only difference is
> the additional '-' delimiter in the low sensitivity search.
>
> The only *legal* place for a '-' in the MLS portion of the label is to
> separate the low/high portions.
>
> What if we were to do a quick search for the low/high separator before
> extracting the low sensitivity and stored low/high pointers for later
> use?  e.g.
>
>   rangep[0] = *scontext;
>   rangep[1] = strchr(rangep[0], '-');
>   if (rangep[1])
>     rangep[1]++ = '\0';
>
> ... we could then move the "Extract X sensitivity" into the main for
> loop as well remove all of the '-' special case parsing checks, e.g.
>
>   for (l = 0; l < 2; l++) {
>
>     scontextp = rangep[l];
>     if (!scontextp)
>       break;
>
>     while (*p && *p != ':')
>       p++;
>     delim = *p;
>     if (delim != '\0')
>       *p++ = '\0';
>
>     /* extract the level (use existing code) */
>
>     /* extract the category set, if present (use existing code) */
>
>     /* no need to worry about the '-' delimiter */
>
>   }
>
> I *believe* that should work.  I think.  Does that make sense?

I'm fiddling with the code a bit now - your suggestion sounds good to
me, and I think there are a couple other small tweaks that can make
the code more readable. I hope I'll have a patch ready soon.
