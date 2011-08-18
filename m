Subject: Re: install
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <201108182259.58177.russell@coker.com.au>
References: <201108182259.58177.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Aug 2011 09:40:24 -0400
Message-ID: <1313674824.21331.21.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-08-18 at 22:59 +1000, Russell Coker wrote:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=638304
> 
> I've reported a bug against coreutils regarding the SE Linux support in 
> install(1).  In summary my main problem is that there is no way of using 
> install to copy a file without bothering with it's SE Linux context.  For 
> creating Debian packages (which can't store SE Linux contexts) I don't want to 
> set the context to some specific value (which would differ depending on who 
> builds it) and "preserving" the context won't always work either (EG I could 
> use install(1) to copy a file to which I have read-only access).
> 
> As well as this it's not documented well enough.

Looks like if you give it a relative path as the target, it won't try to
set the context, because it doesn't apply realpath(), unlike restorecon,
and matchpathcon() will always fail on a relative path as all of the
file_contexts pathname regexes begin with a slash.  Not sure if that was
intentional or not.

Anyway, how do you address the same issue for the package manager (dpkg
or rpm)?  Is there a way to suppress setting of the security context
when rpm or dpkg unpacks a package?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
