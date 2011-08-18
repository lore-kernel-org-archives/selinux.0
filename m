From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: install
Date: Fri, 19 Aug 2011 00:24:15 +1000
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <201108182259.58177.russell@coker.com.au> <1313674824.21331.21.camel@moss-pluto>
In-Reply-To: <1313674824.21331.21.camel@moss-pluto>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201108190024.15482.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Aug 2011, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Looks like if you give it a relative path as the target, it won't try to
> set the context, because it doesn't apply realpath(), unlike restorecon,
> and matchpathcon() will always fail on a relative path as all of the
> file_contexts pathname regexes begin with a slash.  Not sure if that was
> intentional or not.

For the case of Debian package creation an absolute path is the most common 
way to do things.  I think that Debian package creation alone is a sufficient 
reason for changing this (in Debian at least).

> Anyway, how do you address the same issue for the package manager (dpkg
> or rpm)?  Is there a way to suppress setting of the security context
> when rpm or dpkg unpacks a package?

dpkg will call matchpathcon() whenever SE Linux is enabled, there doesn't 
appear to be a way of disabling this or a good reason for doing so.

A significant portion of the uses of install(1) involve something other than 
installing a system file.  The case of using install as part of a Debian 
package creation process (or some other form of archive creation) either 
deliberately or through "make install" is extremely common.  Changing tens of 
thousands of Makefiles isn't a viable option and having lots of warning 
messages isn't a great situation, so it seems that changing install(1) is 
required.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
