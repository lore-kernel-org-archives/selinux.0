Date: Tue, 28 May 2002 11:32:46 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Thomas G Land <tgland@iserv.net>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: RH cds from RH Linux 7.2 Bible Unlimited Ed.
In-Reply-To: <200205261433.g4QEXLQ21791@mail2.iserv.net>
Message-ID: <Pine.GSO.4.33.0205281125460.1315-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 26 May 2002, Thomas G Land wrote:

> 1) Does any one know if this RH cd version can be used with selinux?

We have successfully used SELinux with RH7.1 and RH7.2.

> 2) RH 7.3 is all I can find in the stores here. Should I get that and wait
> for selinux to catch up?

We haven't tried RH7.3 yet, but Justin Smith has posted to this list about
his successful experience in using SELinux with RH7.3.  Just be aware that
we track the mainstream Linux kernel, not the RedHat kernel, so there may
be some incompatibilities (e.g. quotas).  For production use in RedHat
systems today, the right thing to do would be to port the LSM kernel patch
and SELinux module to the RedHat-patched kernel.  With RedHat 7.3, the
RedHat kernel is based on 2.4.18, like the current SELinux release, so
this should be straightforward, although it would require resolving the
RedHat patches (~145 distinct patch files) with LSM/SELinux and verifying
that none of those patches require additional processing by LSM or SELinux.

> 3) Is selinux generally only to be used by very experienced people.

There is definitely a high learning curve associated with SELinux.
However, it appears that the community is beginning to develop tools to
help manage the complexity, which will ultimately make SELinux accessible
to the end user.

> Eventually I want to use SuSE with selinux but for now most developement and
> information avail seems to center around RH.

Others have posted to this list about successfully using SELinux with SuSE
- see the mailing list archives.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
