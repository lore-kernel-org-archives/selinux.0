Subject: Re: Identification of Attribute values within the Security Server
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <557930.89616.qm@web86902.mail.ukl.yahoo.com>
References: <557930.89616.qm@web86902.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 11:52:51 -0400
Message-Id: <1175701971.30692.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-04 at 15:39 +0000, JanuGerman wrote:
> >avd->allowed is an "access vector", as described by our papers and
> >reports (please read the available documentation before asking
> >questions).  It is a bitmap of permissions that are allowed for the
> >(ssid, tsid, tclass) triple.  The security server can at its discretion
> >compute more than just the "requested" permissions and provide further
> >decisions, as indicated by the avd->decided vector (which is also a
> >bitmap).  Not sure what you mean by negative values - they are unsigned
> >integers representing bitmaps.
> 
> 
> Thanks.
> 
> 
> >Possibly you should seek out and read the papers on LSM, e.g.
> >http://www.usenix.org/event/sec02/wright.html
> >http://www.kroah.com/linux/talks/ols_2002_lsm_paper/lsm.pdf
> 
> Unfortunately, there is not much information about the composition of
> the access vector "bitmap" in the above papers, not even in the
> document "Configuring an SELinux policy" i think so. Can one deduce
> that if the value avd->allowed is greater than 1, it is always
> allowed? Because, i have noticed that when the avd->allowed is greater
> than one, no matter any value, all other values are -1, may be i am
> wrong.

The papers I cited were about LSM and related to your question about how
the core Linux kernel ultimately invokes SELinux to get decisions.

Access vectors are described in the papers about Flask and about
SELinux, such as:
http://www.nsa.gov/selinux/papers/flask-abs.cfm
http://www.nsa.gov/selinux/papers/slinux-abs.cfm

But the short answer is that an access vector is a bitmap of permissions
for a given security class, where each bit indicates whether the
permission at that position is in the permission set.  For class file,
an avd->allowed value of 0x6 would mean that FILE__READ and FILE__WRITE
was allowed (see security/selinux/include/av_permissions.h).  An
avd->allowed value of 0xffffffff (which you incorrectly call -1, as it
is an unsigned integer) would mean that all permissions are allowed for
that class.  An avd->decided value of 0xffffffff indicates that all bits
in avd->allowed were computed by the security server and may be safely
used by the AVC.  Again, please read the documentation and the code
before asking questions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
