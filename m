Date: Tue, 23 Jul 2002 13:03:07 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Richard Mayo <rmayo@caci.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: SELinux Configuration Question
In-Reply-To: <OF166CCF9D.C3ACFF49-ON85256BFF.005A0CF7@hq.caci.com>
Message-ID: <Pine.GSO.4.33.0207231259030.4721-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 23 Jul 2002, Richard Mayo wrote:

> 3)    Created /selinux/policy/file_contexts/program/jdw.fc to assign file
> contexts to the appropriate files.
>             This doesn't work -- the make relabel command ignores this
> file, my software files are not re-typed.

If you look at the definition of FCFILES in the policy Makefile, you'll
see why.  FCFILES is defined to automatically pick up only those
program .fc files for which there is a corresponding program .te file.
That permits people to simply remove the program .te files that they do
not want and automatically ignore the corresponding .fc files when they
relabel.

Notice that even for domains that are primarily defined via a macro, there
is still at least a minimal .te file under domains/program with the type
for the entrypoint executable, e.g. crontab.te.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
