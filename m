Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3LIDHv2030362
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 14:13:17 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3LIDFSF005901
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 18:13:16 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4DB06A23.2040000@schaufler-ca.com>
References: <4DB06A23.2040000@schaufler-ca.com> <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: dhowells@redhat.com, serge.hallyn@canonical.com, eparis@redhat.com,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/9] Open loaders and interpreters with new creds during exec
Date: Thu, 21 Apr 2011 19:13:08 +0100
Message-ID: <4677.1303409588@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> Because mud is setgid to swill it gets the old interpreter

SGID is cancelled because mud is a script.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
