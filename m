Date: Wed, 17 Sep 2003 09:07:23 +0100
From: Dale Amon <amon@vnl.com>
To: Diyab <diyab@diyab.net>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>, Frank Mayer <mayerf@tresys.com>,
   Dave Caplan <dac@tresys.com>
Subject: Re: Policy source and initial ramdisk
Message-ID: <20030917080723.GU8988@vnl.com>
References: <1063747354.25176.44.camel@colossus.columbia.tresys.com> <3F67CC08.9050106@diyab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F67CC08.9050106@diyab.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 16, 2003 at 10:50:48PM -0400, Diyab wrote:
> Also there are distributions that don't include mkinitrd and I'm willing 
> to be there are slight differences between the actual script of the 
> distros that do.  

"Slight" is putting it mildly. You're really getting into "vendor"
dependencies here. The debian mkinitrd uses run-parts on two different
directories for instance.

This is mostly a package issue. Whether RPM or DEB there will have to be
a mkinitrd dependency. And for TGZ installs... well if you install via
tarballs you're supposed to know these things. Tarballs are for
real OS programmers :-)





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
