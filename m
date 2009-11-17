Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAH6iGMd020674
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 01:44:16 -0500
Received: from mail-px0-f171.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nAH6hEEY017854
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 06:43:15 GMT
Received: by pxi1 with SMTP id 1so1501930pxi.32
        for <selinux@tycho.nsa.gov>; Mon, 16 Nov 2009 22:44:15 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 16 Nov 2009 22:44:15 -0800
Message-ID: <dd18b0c30911162244o6fd2ba4asdf77d2342fb10326@mail.gmail.com>
Subject: No rule to make target `/seusers', needed by `tmp/seusers'. Stop.
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss1.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've hit something confusing to me.
When building a Monolithic policy everything
goes good. But as soon as I build a binary I hit this:

m4 -D distro_redhat -D enable_ubac -D mls_num_sens=16 -D
mls_num_cats=256 -D mcs_num_cats=256 -D hide_broken_symptoms -D
users_extra support/divert.m4 policy/support/file_patterns.spt
policy/support/ipc_patterns.spt policy/support/loadable_module.spt
policy/support/misc_macros.spt policy/support/misc_patterns.spt
policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
support/undivert.m4 policy/users | \
                sed -r -n -e 's/^[[:blank:]]*//g' -e '/^user/p' >
tmp/users_extra
make: *** No rule to make target `/seusers', needed by `tmp/seusers'.  Stop.

I've looked at the Makefile to make sure
I didn't forget anything(python,sed,awk,m4,flex)
but still can't seem to figure out what I'm missing
to have the policy compile the modules correctly.

Keep in mind I don't want to wast any of your guy's time,
so any quick hints are appreciated.

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
