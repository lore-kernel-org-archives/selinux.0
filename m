Date: Wed, 10 Oct 2001 15:25:52 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Justin R. Smith" <jsmith@mcs.drexel.edu>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Vanilla unix policy
In-Reply-To: <1002732644.4547.11.camel@vorpal>
Message-ID: <Pine.GSO.4.33.0110101518570.16839-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 10 Oct 2001, Justin R. Smith wrote:

> 2. Is there a simple policy that merely duplicates the one that
> implicitly exists in Linux already (i.e., user, group ownership and
> permissions)?

The SELinux access controls are orthogonal to the existing Linux access
controls, so there isn't any reason to try to emulate the Linux access
controls in the SELinux policy.  The SELinux access controls can be used
to further restrict access based on the system security policy, but they
do not replace the existing controls.  With the example security server,
you can provide the "simple policy" that you describe by only using a
single role, domain, and type for all subjects and objects and granting
all permissions.  Or you can use the trivial security server, although we
haven't been maintaining it lately.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
