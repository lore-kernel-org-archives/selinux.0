Date: Fri, 23 Aug 2002 09:50:03 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: new file contexts
In-Reply-To: <1030110414.16277.8.camel@phobos>
Message-ID: <Pine.GSO.4.33.0208230945320.20183-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 23 Aug 2002, Timothy Wood wrote:

> When you make a new file in the policy/file_contexts/program directory
> do you have to specify the new file somewhere so that it gets compiled
> into the policy or should it just pickup the new file automatically?

The policy/Makefile automatically includes up a program .fc file into the
file contexts configuration for each program .te file that exists under
domains/program.  This approach is designed to permit users to remove
program .te files for programs that they do not run and have the
corresponding .fc files automatically ignored.  However, you may encounter
problems in selectively removing program .te files, since there may be
other .te files that have dependencies on them.  We are trying to wrap all
such inter-domain dependencies with m4 ifdefs, but that is not yet
complete.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
