From: David Howells <dhowells@redhat.com>
In-Reply-To: <1241466198.3023.237.camel@localhost.localdomain>
References: <1241466198.3023.237.camel@localhost.localdomain>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: Fix send_sigiotask hook
Date: Tue, 05 May 2009 13:47:21 +0100
Message-ID: <31955.1241527641@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> The CRED patch incorrectly converted the SELinux send_sigiotask hook to
> use the current task SID rather than the target task SID in its
> permission check, yielding the wrong permission check.  This fixes the
> hook function.  Detected by the ltp selinux testsuite and confirmed to
> correct the test failure.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: David Howells <dhowells@redhat.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
