Subject: Re: How to trace why MCS permissions granted?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@udmvt.ru
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20091005071410.GV4221@ruber.office.udmvt.ru>
References: <20091002154012.GT4221@ruber.office.udmvt.ru>
	 <1254499643.30591.346.camel@moss-pluto.epoch.ncsc.mil>
	 <1254503251.30591.357.camel@moss-pluto.epoch.ncsc.mil>
	 <20091005071410.GV4221@ruber.office.udmvt.ru>
Content-Type: text/plain
Date: Mon, 05 Oct 2009 15:29:49 -0400
Message-Id: <1254770989.2251.165.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-10-05 at 12:14 +0500, selinux@udmvt.ru wrote:
> On Fri, Oct 02, 2009 at 01:07:31PM -0400, Stephen Smalley wrote:
> > On Fri, 2009-10-02 at 12:07 -0400, Stephen Smalley wrote:
> > > On Fri, 2009-10-02 at 20:40 +0500, selinux@udmvt.ru wrote:
> > > > Hello, everyone.
> > > > I'm just playing with MCS and trying to understand the system's behavior.
> > > > 
> ...
> > > policy/mcs says:
> > > mlsconstrain file { read }
> > >         (( h1 dom h2 ) or ( t2 == domain ) or ( t1 == mlsfileread ));
> > 
> > So it is operating in accordance with the policy configuration.  As to
> > whether the policy configuration makes sense is another question, I
> > think.
> Oh, thanks, I see now.
> 
> But is there any place, where I can read human definition
> of reference policy? I suppose, there should be one, that describes
> every requirement, that the policy should meet (or guarantee) to be "correct"
> or "have sense".
> So I (and everyone else) could know out whether there is a bug or a feature
> of a policy.

Reference policy goals were stated in the paper referenced from:
http://oss.tresys.com/projects/refpolicy/wiki/Documentation

That's written primarily in terms of the RBAC/TE components, and is
focused on least privilege and role separation.

MCS came later and was invented by James Morris, see:
http://fedoraproject.org/wiki/SELinux/MCS
http://marc.info/?l=selinux&m=124688422726897&w=2
http://marc.info/?l=selinux&m=125242426700964&w=2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
