Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Chad Hanson <chanson@TrustedCS.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <20041103172609.GE5061@lkcl.net>
References: <36282A1733C57546BE392885C06185924D93DC@chaos.tcs.tcs-sec.com>
	 <20041103172609.GE5061@lkcl.net>
Content-Type: text/plain
Message-Id: <1099587019.3174.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 04 Nov 2004 11:50:19 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 12:26, Luke Kenneth Casson Leighton wrote:
>  the problem that SELinux faces is that as soon as you provide a
>  seteuid-like function as a "sop" to help people adopt SElinux
>  in applications, all bets are off for being able to remove
>  it at a later date, and SELinux's security assurance is lost.

I don't think that this is a fair statement, and it misses an important
aspect of SELinux:  policy flexibility.  SELinux was designed with the
notion that no single policy will fit everyone's needs, and seeks to
provide an architecture that can support a wide range of requirements. 
While that doesn't mean that we have to blindly accept every requirement
that comes our way, it does mean that we need to give fair consideration
to them, and it is true that there is a substantial body of applications
today that presently require a privilege bracketing mechanism.  While
such a mechanism is far from perfect, it can provide some benefit, even
if only as a "discretionary" mechanism for the application.  Further, as
the mechanism is subject to the control of the policy, one can still
choose to disable or restrict it as desired, so no one is being forced
to use this mechanism.  Excluding the mechanism entirely will limit the
ability of people to use SELinux, and ultimately undermines the Flask
architecture's goal of providing a general purpose security mechanism. 
This mechanism does not seem to conflict with the three properties by
which we define MAC for SELinux.

I would like to move forward with this proposal, going beyond a
discussion of whether or not it should be implemented to how it should
be implemented.  One issue that has cropped up during this thread is the
question of whether the implementation be done as a separate kernel
configuration option so that the mechanism can be excluded from the
kernel entirely if desired, or is it sufficient to disable it via
policy?  Implementing it as a separate option may be a bit ugly, as we
are just talking about code modifications within the setprocattr hook
function as opposed to a completely new interface and code path, but
should be possible.  In either case, an error code can be returned by an
attempt to write to /proc/pid/attr/current; it is just a difference of
EOPNOTSUPP vs. EACCES.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
