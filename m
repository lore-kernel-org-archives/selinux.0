Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Frank Mayer <mayerf@tresys.com>, "'Colin Walters'" <walters@verbum.org>,
   "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>
In-Reply-To: <418B968F.3070700@trustedcs.com>
References: <01df01c4c336$4facc6f0$1e0c010a@columbia.tresys.com>
	 <418B968F.3070700@trustedcs.com>
Content-Type: text/plain
Message-Id: <1099668037.6373.126.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 10:20:37 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-05 at 10:04, Darrel Goeddel wrote:
> The process first needs the ability to perform a dynamic transition ("allow 
> foo_t self:process dyntransition").

You mean "setcurrent", right?  dyntransition is the pairwise check, as
you correctly described later in the same message.

> Since the policy allows for such control, I do not see the need to wait for 
> policy language extensions, or to make dyntransitions a compile-time option to 
> the kernel.  Sorry if I got a little long-winded there :)

The only reason I can see for making it a compile-time option is greater
assurance that it will never be used, much as some people may want to
disable the selinux= boot parameter, runtime disable, or development
support options via the existing kernel config options.  But I am
hesitant to do this for an API (ability to write to
/proc/pid/attr/current), although I suppose one could argue that those
existing options also affect the API (ability to write to
/selinux/enforce and /selinux/disable as well as the boot parameters
themselves).  No strong preference either way for me.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
