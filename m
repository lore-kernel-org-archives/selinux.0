Subject: Re: Centos 5 OpenVPN / SElinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bernd Bartmann <bernd.bartmann@gmail.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        CentOS mailing list <centos@centos.org>, selinux@tycho.nsa.gov
In-Reply-To: <6c18a4f0705301047pf0cd360i434bf5d85cdf38e5@mail.gmail.com>
References: <6c18a4f0705301003xc08b41dsd871345a20197cd@mail.gmail.com>
	 <465DB770.8050903@redhat.com>
	 <6c18a4f0705301047pf0cd360i434bf5d85cdf38e5@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 30 May 2007 14:00:18 -0400
Message-Id: <1180548018.3340.205.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 19:47 +0200, Bernd Bartmann wrote:
> On 5/30/07, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > Easiest thing to do is update policy with these two rules.
> >
> > # grep openvpn /var/log/audit/audit.log | audit2allow -M myopenvpn
> > # semodule -i myopenvpn.pp
> >
> > This will add the following rules:
> > allow openvpn_t pppd_t:fd use;
> > allow openvpn_t self:process execstack;
> >
> > The pppd_t:fd is probably a leaked file descriptor and could probably be
> > dontaudited.
> > The execstack is potentially a problem in openvpn_t.  This is probably a
> > coding problem and should be reported as a bug/
> 
> Daniel, do you mean a bug in SElinux or OpenVPN?

OpenVPN.  See Ulrich Drepper's description of the selinux memory
protection tests, particularly the execstack description.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
