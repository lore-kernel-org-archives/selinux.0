Subject: Re: SETools not compiling, refpolicy modules not loading
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kovacsics =?ISO-8859-1?Q?R=F3bert?= <kovirobi@gmail.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <CABPkNKmytMBPwsY_HV5YLbaBzTThGY1KaRFkD0ujt7h1ReA6yA@mail.gmail.com>
References: 
	 <CABPkNKmytMBPwsY_HV5YLbaBzTThGY1KaRFkD0ujt7h1ReA6yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 05 Mar 2012 14:56:50 -0500
Message-ID: <1330977410.7184.13.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-03-02 at 23:00 +0000, Kovacsics Róbert wrote:
> Hi!
> 
> It is me again, and after compiling SELinux, I went on to try to
> compile SETools, as I read, stuff like audit2allow needs it because of
> the python, so anyway it does not want to compile, saying that
> "checking for corrected libsepol boolean expand behavior... configure:
> error: this version of libsepol is incompatible with SETools", and I
> have the latest SELinux, downloaded from the website. I did also try
> with the latest SETools downloaded from SVN.

setools isn't required for audit2allow (or anything else needed for
day-to-day usage of SELinux).  Only for policy analysis.  You likely
should report problems to their own alias/list or bug tracker.

> Also, another problem I have been having, is that when I try to load
> refpolicy, it uses a lot of CPU (about the amount required for
> compilation, then it just hangs there with low CPU after 5 minutes,
> and anything I do to it ends with segfault.

You need to provide more details, like the exact versions of
libsepol/checkpolicy/libsemanage/policycoreutils and refpolicy.  But
loading the full refpolicy can indeed be slow and require significant
memory.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
