Subject: Re: Configure: error: *** libwrap missing
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Christopher Carney <ccarney@seacorp.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <001401c3101b$2287ea80$e501a8c0@CarneyC>
References: <001401c3101b$2287ea80$e501a8c0@CarneyC>
Content-Type: text/plain
Message-Id: <1051875234.1377.405.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 May 2003 07:33:55 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-05-01 at 15:52, Christopher Carney wrote:
> "checking for libwrap. configure: error: *** libwrap missing
> 
> make[1]: *** [xopenssh-config] Error 1

If you look at the xopenssh-config target in the selinux/utils/Makefile,
you'll see that it specifies a number of options to configure, including
--with-tcp-wrappers.  If you don't have that package, you can either get
it or you can drop that option from the configure command line.

> So I went ahead and ran. /configure for XOpenSSH which worked fine.

Except that running ./configure without specifying any other options
will yield a sshd that doesn't include the SELinux support, and likely
won't be installed where you want it either.  I'd suggest just trimming
the --with-tcp-wrappers option from the configure line in
utils/Makefile.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
