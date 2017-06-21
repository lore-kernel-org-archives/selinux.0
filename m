Date: Wed, 21 Jun 2017 11:48:12 +0200
From: Luis Ressel <aranea@aixah.de>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris
 <james.l.morris@oracle.com>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: Assign proper class to PF_UNIX/SOCK_RAW sockets
Message-ID: <20170621114812.6aa3f62e@vega.skynet.aixah.de>
In-Reply-To: <CAHC9VhTz2uFMAcYBCph1=XVtib1owCuSi+c1stQsxkymDt_BJQ@mail.gmail.com>
References: <20170619213348.2970-1-aranea@aixah.de>
 <CAHC9VhQsVa+0LgqFyguqq0bhXOz7mrbJfXy-+rJjY53xnCkixg@mail.gmail.com>
 <1497989063.12069.18.camel@tycho.nsa.gov>
 <CAHC9VhTz2uFMAcYBCph1=XVtib1owCuSi+c1stQsxkymDt_BJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 20 Jun 2017 17:43:38 -0400
Paul Moore <paul@paul-moore.com> wrote:

> Considering where we are at with respect to the merge window, let's
> shelve this for now and I'll merge it after the next merge window
> closes.  In all likelihood I'll be sending selinux/next up to James
> later this week and I'd like this to sit in linux-next for longer than
> a few days.

That means the change will land in 4.14 at the earliest, right? (Just
out of curiosity.)

By the way, refpolicy only grants "socket" permissions to a handful of
domains, all of which also have the corresponding "unix_dgram_socket"
permissions. The fedora policy does the same (according to Stephen);
this only leaves custom policies to be potentially affected by this
change.

Given that the SOCK_RAW->SOCK_DGRAM translation is obscure enough not to
be documented anywhere outside the kernel sources, I doubt there are
many users of it, anyway.

Regards,
Luis Ressel
