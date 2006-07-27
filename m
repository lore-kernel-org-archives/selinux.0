Subject: Re: semanage and RHPL
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Stephen Bennett <spb@gentoo.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20060717204049.2d6eae10@localhost>
References: <20060712210909.575163ad@localhost>
	 <20060717204049.2d6eae10@localhost>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 16:18:14 -0400
Message-Id: <1154031494.27604.237.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-07-17 at 20:40 +0100, Stephen Bennett wrote:
> Having investigated this some more and discussed it on IRC, it seems
> that rhpl is only being used for one function (_), which it seems can
> be replaced by Python's standard gettext interface. A patch to do this
> is attached, tested with LC_* both unset and set to en_GB. semanage and
> genhomedircon are known to work in these situations; the changes to the
> other scripts are identical so they ought to work as well. Please
> comment.

Thanks, merged upstream.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
