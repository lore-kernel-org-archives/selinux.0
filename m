Date: Fri, 22 Aug 2003 21:17:09 +0100
From: Dale Amon <amon@vnl.com>
To: SELinux <SELinux@tycho.nsa.gov>
Cc: Russell Coker <russell@coker.com.au>
Subject: Re: 2.6.0-test3
Message-ID: <20030822201709.GE12548@vnl.com>
Mime-Version: 1.0
Content-Type: message/rfc822
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Why can't you install the new selinux package?

Ah, I see, it's not a kernel package. This is the first time I've
gone from packages instead of direct from the NSA tgz. But even so,
there is a conflict. I presume I can just --force-conflicts.

Unpacking selinux (from .../selinux_2003081307-3_i386.deb) ...
dpkg: error processing /var/cache/apt/archives/selinux_2003081307-3_i386.deb (--unpack):
 trying to overwrite `/etc/pam.d/newrole', which is also in package policycoreutils
dpkg-deb: subprocess paste killed by signal (Broken pipe)
Errors were encountered while processing:
 /var/cache/apt/archives/selinux_2003081307-3_i386.deb


 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
