Subject: Re: setfscreatecon-w/invalid-context can mistakenly succeed
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        =?UTF-8?Q?Ond=C5=99ej_Va=C5=A1=C3=ADk?= <ovasik@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <871w588v2k.fsf@rho.meyering.net>
References: 
	 <Pine.LNX.4.44.0803271805390.3341-100000@redline.boston.redhat.com>
	 <874pa5buqs.fsf@rho.meyering.net>
	 <1208175424.18883.6.camel@moss-spartans.epoch.ncsc.mil>
	 <871w588v2k.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Mon, 14 Apr 2008 10:17:30 -0400
Message-Id: <1208182650.18883.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-04-14 at 14:44 +0200, Jim Meyering wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> ...
> > Sounds more like a bug in mcstrans to me - giving back an empty string
> > in place of the "xxx" so that the kernel never sees the "xxx"?  Or do I
> > misunderstand your description above.
> 
> You are probably right about it being an mcstrans bug.
> When I turn it off (service mcstrans stop) and rerun the test,
> the problem is gone: i.e., it prints all '.'s and no X's.
> 
>     rm -rf d; while :; do mkdir d -Z xxx 2> /dev/null&&{t=X;rmdir d;}||t=.;
>       printf $t 1>&2;done

Ok, please bugzilla it against mcstrans then.  Thanks.

> > However, I'm a little surprised by the EINVAL above as well from the
> > kernel, as the selinux_setprocattr handler in the kernel is written to
> > accept NULL, "\0", or "\n" as a way of clearing the attribute value
> > (resetting to policy default).  setfscreatecon(NULL) does the former for
> > use by programs, while echo -n "" > /proc/self/attr/fscreate does the
> > last one for use from scripts.  I'm wondering if we are running afoul of
> > some inconsistency in the proc code itself before we reach the selinux
> > code.  So possibly a kernel bug report would also make sense.  But the
> > mcstrans issue is more crucial, as we shouldn't be mapping an invalid
> > context to the empty string there.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
