Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j13Mwu53004055
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 17:58:56 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j13Mwwf1022437
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 22:58:59 GMT
Subject: Re: Latest diffs
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4200D68A.6030309@redhat.com>
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9717.2000609@redhat.com>
	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>
	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>
	 <4200D68A.6030309@redhat.com>
Content-Type: text/plain
Date: Thu, 03 Feb 2005 19:58:47 -0500
Message-Id: <1107478728.4065.3.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-02 at 08:32 -0500, Daniel J Walsh wrote:
> -if (allow_execmod) {
> -allow $1 texrel_shlib_t:file execmod;
> -}

... X needs execmod, and this change breaks it:

audit(1107469036.956:0): avc:  denied  { execmod } for  pid=3383 comm=X
path=/usr/lib/nvidia/tls/libnvidia-tls.so.1.0.6629 dev=dm-0 ino=519237
scontext=system_u:system_r:xdm_xserver_t
tcontext=system_u:object_r:texrel_shlib_t tclass=file

Also, mozilla needs execmem. What's going on with this - I've
seen it sent twice and rejected twice... 

audit(1107476807.924:0): avc:  denied  { execmem } for  pid=3828
comm=firefox-bin scontext=user_u:user_r:user_mozilla_t
tcontext=user_u:user_r:user_mozilla_t tclass=process

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
