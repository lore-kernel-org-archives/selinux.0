Subject: Re: Bugs with bool_ids usage (libsepol)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Cedric Roux <Cedric.Roux@eurecom.fr>, selinux@tycho.nsa.gov
In-Reply-To: <1149016021.524.100.camel@moss-spartans.epoch.ncsc.mil>
References: <Pine.LNX.4.44.0605101702540.19909-100000@perignan.eurecom.fr>
	 <1147283537.22880.52.camel@jackjack.columbia.tresys.com>
	 <1148569615.20976.110.camel@moss-spartans.epoch.ncsc.mil>
	 <1148570661.10246.27.camel@jackjack.columbia.tresys.com>
	 <1148572287.20976.141.camel@moss-spartans.epoch.ncsc.mil>
	 <1148575882.10246.39.camel@jackjack.columbia.tresys.com>
	 <1149011874.524.90.camel@moss-spartans.epoch.ncsc.mil>
	 <1149016021.524.100.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 30 May 2006 15:14:39 -0400
Message-Id: <1149016479.524.103.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-30 at 15:07 -0400, Stephen Smalley wrote:
> On Tue, 2006-05-30 at 13:57 -0400, Stephen Smalley wrote:
> > On Thu, 2006-05-25 at 12:51 -0400, Karl MacMillan wrote:
> > > On Thu, 2006-05-25 at 11:51 -0400, Stephen Smalley wrote:
> > > > On Thu, 2006-05-25 at 11:24 -0400, Karl MacMillan wrote:
> > > > > What about this patch instead - it seems to make the usage of nbools and
> > > > > bool_ids more natural and potentially improves the comparison speed for
> > > > > larger conditionals.
> > > > 
> > > > Not clear, given that you are only using the bool_ids for the
> > > > precomputation and it is still limited to the same max.
> > > 
> > > That's not the case - I changed the comparison code to always verify
> > > that the larger conditionals have the same booleans before comparing the
> > > full expression. Changing the precomputation max is harder.
> > > 
> > > Looking at it though, the complexity of comparing the booleans is high
> > > for a large number of unique booleans so comparing the booleans first is
> > > only sometimes a win.
> > > 
> > > For me, though, the larger issue is that it is very strange to have
> > > nbools != to the bool_ids. Preserving that behavior requires the user of
> > > the struct to understand the boolean code - looking at the header is not
> > > sufficient without more comments. This has already generated the bugs
> > > that both of these patches fix.
> > > 
> > > >   Patch was
> > > > malformed, btw.  
> > > > 
> > > 
> > > Patch attached - it applies cleanly here. I think that my mail server
> > > munged the inline patch, but I will have to investigate.
> > 
> > Thanks, merged.
> 
> Hmmm...actually, that's no good:
> 
> valgrind /usr/sbin/semodule -r foo
> ==6474== Memcheck, a memory error detector.
> ==6474== Copyright (C) 2002-2005, and GNU GPL'd, by Julian Seward et al.
> ==6474== Using LibVEX rev 1575, a library for dynamic binary translation.
> ==6474== Copyright (C) 2004-2005, and GNU GPL'd, by OpenWorks LLP.
> ==6474== Using valgrind-3.1.1, a dynamic binary instrumentation framework.
> ==6474== Copyright (C) 2000-2005, and GNU GPL'd, by Julian Seward et al.
> ==6474== For more details, rerun with: -v
> ==6474==
> ==6474== Invalid write of size 4
> ==6474==    at 0x4032A52: copy_cond_list (in /lib/libsepol.so.1)
> ==6474==    by 0x4033274: copy_avrule_decl (in /lib/libsepol.so.1)
> ==6474==    by 0x4033978: copy_module (in /lib/libsepol.so.1)
> ==6474==    by 0x40353EC: link_modules (in /lib/libsepol.so.1)
> ==6474==    by 0x40378CF: sepol_link_packages (in /lib/libsepol.so.1)
> ==6474==    by 0x408D8AF: semanage_link_sandbox (in /lib/libsemanage.so.1)
> ==6474==    by 0x40826EF: semanage_direct_commit (in /lib/libsemanage.so.1)
> ==6474==    by 0x4085047: semanage_commit (in /lib/libsemanage.so.1)
> ==6474==    by 0x8049B12: main (in /usr/sbin/semodule)

And that's because link.c:copy_cond_list() malloc's a cond_node_t
directly and thus bool_ids is never allocated for it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
