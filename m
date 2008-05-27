Subject: Re: 7 simple noobie questions = 1-line answers ok :)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: green bean <1capybara@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <827143b70805271203ve677cdbs7ceafd8bc7879c3f@mail.gmail.com>
References: <827143b70805271203ve677cdbs7ceafd8bc7879c3f@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 27 May 2008 15:45:56 -0400
Message-Id: <1211917556.19360.103.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-05-27 at 12:03 -0700, green bean wrote:
> 7 simple noobie questions:

Resources that may help you:
http://www.nsa.gov/selinux/info/faq.cfm
http://selinuxproject.org/page/User_Resources

> 1. is selinux based on debian? what kernel - 2.6 or 2.4 ?
> 2. is there a built-in desktop like KDE or gnome?  or is it command line only?

It isn't a distribution, see above.

> 3. what is its install mechanism?
> if its debian based im assuming its
> $ apt-get install foo.bar

Depends on your particular distribution; some include SELinux enabled by
default; others have it as an optional feature.  Consult the
distro-specific website mentioned on the User Resources page.

> 4. does selinux have a root user or is it "rootless."

There is no inherent notion of a root user; it depends on your policy
configuration as to whether any single role/domain is all powerful.

> 5. are there new limits on
> $ su or
> $ sudo

The ability to use capabilities is controlled by SELinux orthogonally to
the normal restrictions.  Running su or sudo is not in itself sufficient
to gain a given capability under SELinux.

> 6. can you do this
> $ chmod  2000 foo.bar
> or
> $ chmod 4000 foo.bar

Yes, but the significance is not the same; the program/process is still
confined by the SELinux policy based on its security domain orthogonal
to the normal restrictions.

> 7. is  Apache compatible/easy to use with seLinux?

Yes; there has been SELinux policy for apache for a long time.

> ##########################
> 8.   fwiw, i was thinking of using seLinux as an experiment in our WISP
> socalfreenet dot org,  as a router or AP.    do-able or bad idea?

SELinux only applies further restrictions, so it shouldn't do any harm.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
