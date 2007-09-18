Date: Tue, 18 Sep 2007 02:12:13 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: whitespace fun
In-Reply-To: <1189097504.3418.22.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0709180210460.22144@us.intercode.com.au>
References: <1189097504.3418.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If you can create a clean, sanity-checked, tested version of this against 
for-akpm, it should be good to go for 2.6.24.

$ git apply --check --whitespace=warn patch
Adds trailing whitespace.
/tmp/ep1.txt:581:
Adds trailing whitespace.
/tmp/ep1.txt:584:
Adds trailing whitespace.
/tmp/ep1.txt:587:
error: patch failed: security/selinux/hooks.c:4
error: security/selinux/hooks.c: patch does not apply
error: patch failed: security/selinux/include/avc.h:109
error: security/selinux/include/avc.h: patch does not apply
error: patch failed: security/selinux/include/objsec.h:39
error: security/selinux/include/objsec.h: patch does not apply
error: patch failed: security/selinux/ss/avtab.c:10
error: security/selinux/ss/avtab.c: patch does not apply
error: patch failed: security/selinux/ss/avtab.h:14
error: security/selinux/ss/avtab.h: patch does not apply


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
