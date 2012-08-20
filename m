Message-ID: <1345465116.10242.12.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [UPDATE] Re: check_seapp script
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Mon, 20 Aug 2012 08:18:36 -0400
In-Reply-To: <CAFftDdoHDfwOLJ+LafeKYQ8kDcxPS0v2=0V665L1y+yURmRJBg@mail.gmail.com>
References: 
	<CAFftDdoAjsGQNSmLTywoB0Pkq2q2uOARpv=R2sahvzS7TVannQ@mail.gmail.com>
	 <CAFftDdr-T4mUVF7gHfNG40HjyXhD7ohTU4JfN0d4NFtLXWFQEw@mail.gmail.com>
	 <CAFftDdoHDfwOLJ+LafeKYQ8kDcxPS0v2=0V665L1y+yURmRJBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-08-17 at 21:39 -0700, William Roberts wrote:
> I was thinking of making the checks for types to make this more robust
> and find errors at compile time, but then it would be beneficial to
> use libselinux python bindings, which in turn would require building
> those for the host and having python development headers installed.
> Maybe I should just rewrite this in the future in C. Or should we see
> if we can get python-dev headers added to the Android initializing the
> build environment?

I doubt they would take that dependency.  Further, if you want to check
the domain=, type=, and level= values, then you need libsepol, not
libselinux, as you would be checking against the compiled policy file
not against the host (which may not even be running SELinux).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
