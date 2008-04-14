From: Jim Meyering <jim@meyering.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        =?utf-8?B?T25kxZllaiBWYcWhw61r?=
 <ovasik@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>, James Morris
 <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: setfscreatecon-w/invalid-context can mistakenly succeed
In-Reply-To: <1208175424.18883.6.camel@moss-spartans.epoch.ncsc.mil> (Stephen
	Smalley's message of "Mon, 14 Apr 2008 08:17:04 -0400")
References: <Pine.LNX.4.44.0803271805390.3341-100000@redline.boston.redhat.com>
	<874pa5buqs.fsf@rho.meyering.net>
	<1208175424.18883.6.camel@moss-spartans.epoch.ncsc.mil>
Date: Mon, 14 Apr 2008 14:44:35 +0200
Message-ID: <871w588v2k.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:
...
> Sounds more like a bug in mcstrans to me - giving back an empty string
> in place of the "xxx" so that the kernel never sees the "xxx"?  Or do I
> misunderstand your description above.

You are probably right about it being an mcstrans bug.
When I turn it off (service mcstrans stop) and rerun the test,
the problem is gone: i.e., it prints all '.'s and no X's.

    rm -rf d; while :; do mkdir d -Z xxx 2> /dev/null&&{t=X;rmdir d;}||t=.;
      printf $t 1>&2;done

> However, I'm a little surprised by the EINVAL above as well from the
> kernel, as the selinux_setprocattr handler in the kernel is written to
> accept NULL, "\0", or "\n" as a way of clearing the attribute value
> (resetting to policy default).  setfscreatecon(NULL) does the former for
> use by programs, while echo -n "" > /proc/self/attr/fscreate does the
> last one for use from scripts.  I'm wondering if we are running afoul of
> some inconsistency in the proc code itself before we reach the selinux
> code.  So possibly a kernel bug report would also make sense.  But the
> mcstrans issue is more crucial, as we shouldn't be mapping an invalid
> context to the empty string there.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
