Date: Tue, 20 Aug 2002 06:51:48 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Jeremy Kusnetz <JKusnetz@nrtc.org>
cc: "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: Re: New to SELinux
In-Reply-To: <9366A6ACB518D511B54B0008C78609E002440271@exchange.nrtc.org>
Message-ID: <Pine.GSO.4.33.0208200637180.13775-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 19 Aug 2002, Jeremy Kusnetz wrote:

> I've been reading SELinux documentation and getting ready to try to deploy
> it on a system.
>
> A couple of questions.  Are there any up to date archives of this mailing
> list other then what's on NSA's site, since it doesn't get updated daily
> (last update on July 3rd)?

Try http://marc.theaimsgroup.com/?l=selinux.  Or you can simply send email
to majordomo@tycho.nsa.gov to get the archives via the index and get
commands.  The NSA web site's hypermail archives are only updated when a
new release is made.

> Second, I got a scared and read a slashdot article from today saying that
> NSA is no longer developing SELinux due to lobbying from  Microsoft because
> the government is competing against private American companies.  Is this
> true?  Is SELinux still being developed?  Is it still being developed by
> NSA, or someonen else now.

Yes, SELinux is still being actively developed by the NSA, by us, and by
others.

> If it is still being developed, is there an SELinux patch to the 2.4.19
> kernel?  I can only find patches to 2.4.18.  I see LSM has a patch to 2.4.19
> but I read somewhere that I should only use SELinux LSM patches.

There should be a new NSA public release available soon with a
2.4.19-based kernel.  As you noted, you should typically use the LSM
patch available from the NSA site when using SELinux, because it may
contain further changes to the LSM patch and/or to the SELinux
kernel module that were made after the latest LSM snapshot patch was
generated.  For example, the next NSA release should include the new sock
hooks, a reliable accept_secure implementation, a bug fix to the
ipc_permission hook, and configurable sysctl labeling, none of which made
it into the 2.4.19-lsm1 snapshot patch.  However, if you need to use
2.4.19 immediately with SELinux, you can use the LSM snapshot patch until
the new NSA release is available - I don't think that there are any
compatibility issues at present.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
