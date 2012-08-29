MIME-Version: 1.0
In-Reply-To: <CAFftDdrXWFPee+uGy1-UXRYM+4e5ZWxPfJXzE4Ts6Tn84ue_cQ@mail.gmail.com>
References: <CAFftDdrXWFPee+uGy1-UXRYM+4e5ZWxPfJXzE4Ts6Tn84ue_cQ@mail.gmail.com>
Date: Wed, 29 Aug 2012 10:46:30 -0400
Message-ID: <CAB9W1A2hVSOizbFmDxOZh04GZ1ABQfifZoFSL8FkA5EcJXzP=A@mail.gmail.com>
Subject: Re: check_seapp sepolicy integration
From: Stephen Smalley <stephen.smalley@gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 27, 2012 at 9:00 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> I have the initial check_seapp tool integrated inted sepolicy, and
> rather then blasting patches back and forth for code review, we can
> use bitbucket and its wiki...
>
> Please visit,
> https://bitbucket.org/billcroberts/external-sepolicy/overview
>
> lets work on getting this up to par, and then I will submit a patch
> back over the mailing list for it's inclusion.

A MLS level is a string consisting of a sensitivity
level:category-set, e.g. s0:c15.  It is not an integer.  You should be
able to use sepol_mls_check() to check the validity of a MLS level
against a given policy.

It doesn't seem like your two projects are consistent or buildable -
check_seapp has no Android.mk and would suggest it is named
check_seapp, whereas sepolicy wants to invoke checkseapp.

I can also throw together a simple checkfc program to check the
file_contexts against the policy to prevent the kinds of problems you
encountered when you omitted a MLS level from your file_contexts
entry.  In normal SELinux, we use setfiles -c for that purpose, but I
didn't bring setfiles over into the Android tree as a build host tool
and we don't need all of its functionality anyway.  I can create a
greatly streamlined version of the setfiles -c functionality as a
simple program under sepolicy in the Android tree.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
