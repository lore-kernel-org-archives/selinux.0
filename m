Subject: Re: Java Policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <4203B048.5070607@redhat.com>
References: <4203B048.5070607@redhat.com>
Content-Type: text/plain
Message-Id: <1107538571.8078.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 04 Feb 2005 12:36:11 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-02-04 at 12:26, Daniel J Walsh wrote:
> This is policy for the java plugin.
> Do not know if we want user apps that run java to transition.
> 
> Will be sending in a big diff later today, but wanted input sooner.

- Neither I nor Tim Fraser wrote this java policy ;)  Looks like there
is also cruft leftover from the netscape/mozilla policy in there.

- Might want to make it a general legacy_binary_t domain for use not
only by java but by other legacy binaries.

- I think there should also be a transition from the user domains on
these legacy programs, so that they can be separately confined.

- Not clear that you need to use a boolean in this domain, as the entire
purpose of it is to deal with binaries that need this access.  Unless we
can turn it off for other architectures.  But if you are going to use a
boolean, we definitely want a separate one so that we can allow it to
these legacy binaries without allowing it to the base user domains.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
