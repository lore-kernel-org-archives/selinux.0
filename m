Subject: Re: Add a new class
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Trent Jaeger <jaegert@us.ibm.com>,
   Luke Kenneth Casson Leighton <lkcl@lkcl.net>, SELinux@tycho.nsa.gov
In-Reply-To: <20050102071707.53956.qmail@web51504.mail.yahoo.com>
References: <20050102071707.53956.qmail@web51504.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1104760886.16598.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 03 Jan 2005 09:01:26 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-01-02 at 02:17, Park Lee wrote:
> Now, I'm using FC2. 

FC3 is strongly recommended over FC2 for SELinux users.

> I've added a new class to security_classes and the
> permissions to access_vectors (In
> /etc/security/selinux/src/policy/flask), after that,
> rebuilt the headers with the Makefile in the flask
> directory and put them in
> /usr/src/linux-2.6.5-1.358/security/selinux/include as
> Joshua Brindle have mentioned.

When adding new classes, you should typically work off of our
sourceforge CVS tree, as that will have the latest definitions.
Or at the very least, you should work off of the latest kernel, i.e.
2.6.10 + 2.6.10-mm1 from kernel.org.  Note that until you submit a patch
reserving your classes to us and until we accept such a patch into our
tree, the class value may be re-used at any time for some other purpose,
forcing you to re-base, much like adding a new syscall to the kernel. 
We have already reserved a new class and permissions for Trent Jaeger's
IPSEC work, as you can see in our sourceforge CVS tree.

> What confused me here is that: MUST we also copy the
> headers to libselinux/include/selinux directory, and
> regenerate a new libselinux.so for the new class and
> its permissions? can we ignore this step?

It isn't required unless some application needs to reference the new
class, but we do update them when we merge new classes into our tree to
keep them in sync.  In the long term, it is expected that there will be
a separate mechanism for userspace object managers to dynamically
register security classes and permissions for their own use, e.g. see
the SELinux Policy Server project by Tresys.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
