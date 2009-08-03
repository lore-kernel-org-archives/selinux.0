Subject: Re: best way to comile userspace to use lib64 for x86_64
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4A770542.3050103@gmail.com>
References: <4A770542.3050103@gmail.com>
Content-Type: text/plain
Date: Mon, 03 Aug 2009 12:09:29 -0400
Message-Id: <1249315769.9193.2.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-08-03 at 08:41 -0700, Justin P. Mattock wrote:
> As an experimanet I'm building an x86_64 system, in doing so
> I'm noticing I need to have the libs point to /lib64 and /usr/lib64
> what is the easiest way to do this for the
> userspace from git. looking at the Makefiles seems a bit confusing,
> using LIBDIR=/lib64 does make /usr/lib64 but does not  make /lib64.
> 
> any ideas?

make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
