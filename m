Subject: Re: 2.6.0-test3
From: Colin Walters <walters@verbum.org>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200308212337.59952.russell@coker.com.au>
References: <1061468940.1665.16.camel@kusturica>
	 <200308212337.59952.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1061487623.22355.27.camel@columbia>
Mime-Version: 1.0
Date: Thu, 21 Aug 2003 13:40:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-08-21 at 09:37, Russell Coker wrote:

> This new version of SE Linux does not use the sys_security system call, and 
> therefore any application compiled for the old SE Linux which uses that call 
> (such as avc_toggle) will fail.
> 
> Colin Walters is doing most of the work for the new SE Linux in Debian at the 
> moment.  Unfortunately my 2.6.0 work has not progressed far enough for me to 
> be able to advise you on how to do it right at this time.  Hopefully Colin 
> will be able to help.

My 2.6.0 Debian packages are here:

http://web.verbum.org/debian/experimental/

I have been busy with some other things and haven't had a chance to
update my packages recently.  I know at least coreutils, pam, and passwd
all have higher versions in unstable now.

Eventually, I'd like to not have to use any packages outside of unstable
at all.  Russell, what do you think about starting to send these patches
to the Debian package maintainers and get them integrated?  At least the
Debian coreutils package already applies over 50 patches, one more
wouldn't hurt :)
The only drawback I see is a dependency on libselinux, but it's so small
anyways.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
