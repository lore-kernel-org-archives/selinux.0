Subject: Re: [PATCH 2/2] RFC: selinux: sysctl: fix selinux labeling broken
 by last patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Lucian Adrian Grijincu <lucian.grijincu@gmail.com>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Dave
 Chinner <dchinner@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux <selinux@tycho.nsa.gov>,
        "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <AANLkTi=3z-en0HAgVx1hRKrj6KYOHi_ZUP4aDv=8zUaa@mail.gmail.com>
References: <AANLkTi=4CH2zFrDp6DAnSj3pa28MtymfG+NrtQ3iW5k-@mail.gmail.com>
	 <1296482354.26427.21.camel@moss-pluto>
	 <AANLkTimt5sxmgUmn-i-WcgMN4d0X00YVMujsA4QgS8nX@mail.gmail.com>
	 <1296493175.26427.37.camel@moss-pluto>
	 <AANLkTi=3z-en0HAgVx1hRKrj6KYOHi_ZUP4aDv=8zUaa@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 Jan 2011 13:35:40 -0500
Message-ID: <1296498940.26427.42.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-01-31 at 19:03 +0200, Lucian Adrian Grijincu wrote:
> On Mon, Jan 31, 2011 at 6:59 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > /proc/sys inode labeling was disabled earlier (hence marked S_PRIVATE)
> > when /proc/sys was reimplemented by Eric, so all access control
> > on /proc/sys was switched to using the sysctl hook rather than the
> > inode-based checking.  That's why you don't get a result from ls -Z
> > on /proc/sys on current kernels.  Getting actual labeling working again
> > for those inodes would be a win, so your patch is an improvement in that
> > regard for selinux.
> 
> 
> Oh, OK. Thanks for letting me know.
> 
> Do you see anything else that is wrong with these patches (apart from
> "//deleted")?

No, although I think someone should take them for a spin on a modern
Fedora in enforcing mode for a bit, and likely run the selinux testsuite
too.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
