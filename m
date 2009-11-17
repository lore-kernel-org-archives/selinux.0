Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAHDeqQl006848
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 08:40:52 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id nAHDgvSO000090
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 13:42:57 GMT
Subject: Re: [refpolicy] No rule to make target `/seusers', needed by
 `tmp/seusers'. Stop.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss1.tresys.com>
In-Reply-To: <dd18b0c30911162244o6fd2ba4asdf77d2342fb10326@mail.gmail.com>
References: <dd18b0c30911162244o6fd2ba4asdf77d2342fb10326@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 17 Nov 2009 08:41:10 -0500
Message-ID: <1258465270.27504.194.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-11-16 at 22:44 -0800, Justin Mattock wrote:
> I've hit something confusing to me.
> When building a Monolithic policy everything
> goes good. But as soon as I build a binary I hit this:
> 
> m4 -D distro_redhat -D enable_ubac -D mls_num_sens=16 -D
> mls_num_cats=256 -D mcs_num_cats=256 -D hide_broken_symptoms -D
> users_extra support/divert.m4 policy/support/file_patterns.spt
> policy/support/ipc_patterns.spt policy/support/loadable_module.spt
> policy/support/misc_macros.spt policy/support/misc_patterns.spt
> policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
> support/undivert.m4 policy/users | \
>                 sed -r -n -e 's/^[[:blank:]]*//g' -e '/^user/p' >
> tmp/users_extra
> make: *** No rule to make target `/seusers', needed by `tmp/seusers'.  Stop.
> 
> I've looked at the Makefile to make sure
> I didn't forget anything(python,sed,awk,m4,flex)
> but still can't seem to figure out what I'm missing
> to have the policy compile the modules correctly.
> 
> Keep in mind I don't want to wast any of your guy's time,
> so any quick hints are appreciated.

I can't reproduce this.  My guess is that either your policy sources are
corrupt or the seusers makefile variable is being changed somehow, eg.
by environmental variables.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
