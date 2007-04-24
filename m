Subject: Re: can not boot with strict policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@namei.org>,
        Ken YANG <spng.yang@gmail.com>, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1177417417.8672.25.camel@sgc>
References: <462CA1F0.2000400@gmail.com>
	 <1177340494.24282.28.camel@moss-spartans.epoch.ncsc.mil>
	 <Line.LNX.4.64.0704231341100.3793@d.namei>
	 <1177350508.24282.58.camel@moss-spartans.epoch.ncsc.mil>
	 <462CF79C.5080804@redhat.com>  <1177417417.8672.25.camel@sgc>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 08:59:34 -0400
Message-Id: <1177419574.24282.128.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-04-24 at 12:23 +0000, Christopher J. PeBenito wrote:
> On Mon, 2007-04-23 at 14:14 -0400, Daniel J Walsh wrote:
> > So the real question, is there much value with the division between 
> > lib_t and shlib_t.
> > When dealing with strict policy, shared libraries were always getting 
> > mislabeled as lib_t, and causing problems, for little security advantage. 
> 
> In Gentoo I don't see these kinds of problems, and we still have the
> strict policy as the default option (until recently on desktops) and I
> don't see this problem; the fc regexes work very well.  However, the
> Gentoo community is far smaller than Fedora/RHEL.
> 
> > As we remove the differences between strict and targeted, I don't intend 
> > to get rid of lib_t == shlib_t.
> 
> I had intended to drop the alias, so i guess we need more discussion. :)

There were definitely problems with shared objects showing up as lib_t
in Fedora, so I suppose the question is what security benefit do we
derive from maintaining the shlib_t vs. lib_t distinction (and the same
question could be applied for many of the "system" types).  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
