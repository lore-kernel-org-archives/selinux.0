Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u119adQ2012554
 for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2016 04:36:39 -0500
Received: by mail-pa0-f44.google.com with SMTP id cy9so79243295pac.0
 for <selinux@tycho.nsa.gov>; Mon, 01 Feb 2016 01:36:37 -0800 (PST)
Received: from localhost ([2404:e800:e600:38b:2d44:6189:65ef:57eb])
 by smtp.gmail.com with ESMTPSA id r77sm7816267pfa.47.2016.02.01.01.36.34
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Feb 2016 01:36:35 -0800 (PST)
Date: Mon, 1 Feb 2016 17:36:33 +0800
From: Jason Zaman <jason@perfinion.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: genhomedircon uid template
Message-ID: <20160201093633.GB21978@meriadoc.perfinion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all,

XDG_RUNTIME_DIR is usually /run/user/$UID but there is no way to label
that in an fcontext file. It used to be /run/user/USER which is easy but
not UID.

What template keyword should be used for such an entry? UID? USERID?

USERID is perhaps more obvious but has to be replaced before USER but
that should be doable.
https://github.com/SELinuxProject/selinux/blob/master/libsemanage/src/genhomedircon.c#L76

UID does not conflict with USER but this line exists in refpol which
is problematic:
contrib/fetchmail.fc:13:/var/mail/\.fetchmail-UIDL-cache -- gen_context(system_u:object_r:fetchmail_uidl_cache_t,s0)

This could also be used for several fcontexts in kerberos. It stores the
tickets in /tmp/krbcc_UID for example.

If we choose a template name I can put together a patch to add it.

-- Jason
