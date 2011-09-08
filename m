Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p88I6jaX022449
	for <selinux@tycho.nsa.gov>; Thu, 8 Sep 2011 14:06:45 -0400
Received: from mail-yw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p88I6iS4024490
	for <selinux@tycho.nsa.gov>; Thu, 8 Sep 2011 18:06:44 GMT
Received: by ywb5 with SMTP id 5so1178362ywb.12
        for <selinux@tycho.nsa.gov>; Thu, 08 Sep 2011 11:06:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1314847787-4055-1-git-send-email-qingtao.cao@windriver.com>
References: <1314847787-4055-1-git-send-email-qingtao.cao@windriver.com>
Date: Thu, 8 Sep 2011 14:06:43 -0400
Message-ID: <CACLa4puGPT4Fc7VgTQ3Xkz94E-epJBsWaDDhzhPOuntLfmaA7Q@mail.gmail.com>
Subject: Re: v2 Discard unused tunables from raw policy
From: Eric Paris <eparis@parisplace.org>
To: Harry Ciao <qingtao.cao@windriver.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 31, 2011 at 11:29 PM, Harry Ciao <qingtao.cao@windriver.com> wrote:

> Differences from v1
> --------------------
>
> The v2 patchset just provides two minor changes from v1:
>
> 1. 0008-Preserve-tunables-when-required-by-semodule-program.patch
>   Extract the codes to make use of sh->preserve_tunables flag in discard_tunable()
>   from the 0007 patch in v1, and present them in this separate 0008 patch;
>
> 2. 0007-Create-a-new-preserve_tunables-flag-in-sepol_handle_.patch
>   Fix an obvious error to mistakenly set sh->preserve_tunables flag in
>   semanage_direct_connect(), which should be solely set according to the options
>   passed for the semodule program.
>
>   Then the preserve_tunables flag file in the module store could be properly
>   removed if no "-P/--preserve_tunables" option used for semodule.

I tried to build fedora policy with this patch set and it didn't work
out this time.  It complains about:

libsepol.bool_copy_callback: ppp: Mismatch between boolean/tunable
definition and usage for secure_mode_insmod
/usr/bin/semodule_link:  Error while linking packages

And then stops building.  I know you mentioned this as a known issue,
but previously I don't remember it failing to build.  All I did was
apply the 8 patches in this series, then apply the 4 patches to policy
you sent a long time ago.  Applying those 4 to fedora policy still
meant a couple of minor changes, but nothing directly to ppp.{te,if}

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
