Subject: Re: Bugs with bool_ids usage (libsepol)
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Cedric Roux <Cedric.Roux@eurecom.fr>, selinux@tycho.nsa.gov
In-Reply-To: <1149016479.524.103.camel@moss-spartans.epoch.ncsc.mil>
References: <Pine.LNX.4.44.0605101702540.19909-100000@perignan.eurecom.fr>
	 <1147283537.22880.52.camel@jackjack.columbia.tresys.com>
	 <1148569615.20976.110.camel@moss-spartans.epoch.ncsc.mil>
	 <1148570661.10246.27.camel@jackjack.columbia.tresys.com>
	 <1148572287.20976.141.camel@moss-spartans.epoch.ncsc.mil>
	 <1148575882.10246.39.camel@jackjack.columbia.tresys.com>
	 <1149011874.524.90.camel@moss-spartans.epoch.ncsc.mil>
	 <1149016021.524.100.camel@moss-spartans.epoch.ncsc.mil>
	 <1149016479.524.103.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-C9THyY8KTMk1ldvaaLl5"
Date: Tue, 30 May 2006 15:14:14 -0400
Message-Id: <1149016454.32288.2.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-C9THyY8KTMk1ldvaaLl5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-05-30 at 15:14 -0400, Stephen Smalley wrote:
> On Tue, 2006-05-30 at 15:07 -0400, Stephen Smalley wrote:
> > On Tue, 2006-05-30 at 13:57 -0400, Stephen Smalley wrote:
> > > On Thu, 2006-05-25 at 12:51 -0400, Karl MacMillan wrote:
> > > > On Thu, 2006-05-25 at 11:51 -0400, Stephen Smalley wrote:
> > > > > On Thu, 2006-05-25 at 11:24 -0400, Karl MacMillan wrote:
> > > > > > What about this patch instead - it seems to make the usage of nbools and
> > > > > > bool_ids more natural and potentially improves the comparison speed for
> > > > > > larger conditionals.
> > > > > 
> > > > > Not clear, given that you are only using the bool_ids for the
> > > > > precomputation and it is still limited to the same max.
> > > > 
> > > > That's not the case - I changed the comparison code to always verify
> > > > that the larger conditionals have the same booleans before comparing the
> > > > full expression. Changing the precomputation max is harder.
> > > > 
> > > > Looking at it though, the complexity of comparing the booleans is high
> > > > for a large number of unique booleans so comparing the booleans first is
> > > > only sometimes a win.
> > > > 
> > > > For me, though, the larger issue is that it is very strange to have
> > > > nbools != to the bool_ids. Preserving that behavior requires the user of
> > > > the struct to understand the boolean code - looking at the header is not
> > > > sufficient without more comments. This has already generated the bugs
> > > > that both of these patches fix.
> > > > 
> > > > >   Patch was
> > > > > malformed, btw.  
> > > > > 
> > > > 
> > > > Patch attached - it applies cleanly here. I think that my mail server
> > > > munged the inline patch, but I will have to investigate.
> > > 
> > > Thanks, merged.
> > 
> > Hmmm...actually, that's no good:
> > 
> > valgrind /usr/sbin/semodule -r foo
> > ==6474== Memcheck, a memory error detector.
> > ==6474== Copyright (C) 2002-2005, and GNU GPL'd, by Julian Seward et al.
> > ==6474== Using LibVEX rev 1575, a library for dynamic binary translation.
> > ==6474== Copyright (C) 2004-2005, and GNU GPL'd, by OpenWorks LLP.
> > ==6474== Using valgrind-3.1.1, a dynamic binary instrumentation framework.
> > ==6474== Copyright (C) 2000-2005, and GNU GPL'd, by Julian Seward et al.
> > ==6474== For more details, rerun with: -v
> > ==6474==
> > ==6474== Invalid write of size 4
> > ==6474==    at 0x4032A52: copy_cond_list (in /lib/libsepol.so.1)
> > ==6474==    by 0x4033274: copy_avrule_decl (in /lib/libsepol.so.1)
> > ==6474==    by 0x4033978: copy_module (in /lib/libsepol.so.1)
> > ==6474==    by 0x40353EC: link_modules (in /lib/libsepol.so.1)
> > ==6474==    by 0x40378CF: sepol_link_packages (in /lib/libsepol.so.1)
> > ==6474==    by 0x408D8AF: semanage_link_sandbox (in /lib/libsemanage.so.1)
> > ==6474==    by 0x40826EF: semanage_direct_commit (in /lib/libsemanage.so.1)
> > ==6474==    by 0x4085047: semanage_commit (in /lib/libsemanage.so.1)
> > ==6474==    by 0x8049B12: main (in /usr/sbin/semodule)
> 
> And that's because link.c:copy_cond_list() malloc's a cond_node_t
> directly and thus bool_ids is never allocated for it.
> 

I thought that I had audited everywhere that a conditional node was
created / copied, but obviously that didn't actually happen. Not that
you need it, but a patch is attached.

I did grep trying to find any other uses just now (I looked for any use
of nbools) and didn't find any.

Karl

-- 
Karl MacMillan
Tresys Technology
www.tresys.com

--=-C9THyY8KTMk1ldvaaLl5
Content-Disposition: attachment; filename=cond-fixes-malloc-20060530.diff
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=cond-fixes-malloc-20060530.diff; charset=utf-8

SW5kZXg6IGxpYnNlcG9sL3NyYy9saW5rLmMNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0tLSBsaWJzZXBvbC9zcmMv
bGluay5jCShyZXZpc2lvbiA3MzQpDQorKysgbGlic2Vwb2wvc3JjL2xpbmsuYwkod29ya2luZyBj
b3B5KQ0KQEAgLTEwMTcsNiArMTAxNywxMCBAQA0KICAgICAgICAgICAgICAgICAgICAgICAgIGN1
cl9leHByLT5ib29sID0gbW9kdWxlLT5tYXBbU1lNX0JPT0xTXVtjdXJfZXhwci0+Ym9vbCAtIDFd
Ow0KICAgICAgICAgICAgICAgICB9DQogICAgICAgICAgICAgICAgIG5ld19ub2RlLT5uYm9vbHMg
PSBjdXItPm5ib29sczsNCisJCW5ld19ub2RlLT5ib29sX2lkcyA9IG1hbGxvYyhuZXdfbm9kZS0+
bmJvb2xzICogc2l6ZW9mKHVpbnQzMl90KSk7DQorCQlpZiAobmV3X25vZGUtPmJvb2xfaWRzID09
IE5VTEwpIHsNCisJCQlnb3RvIGNsZWFudXA7DQorCQl9DQogICAgICAgICAgICAgICAgIGZvciAo
aSA9IDA7IGkgPCBjdXItPm5ib29sczsgaSsrKSB7DQogICAgICAgICAgICAgICAgICAgICAgICAg
dWludDMyX3QgcmVtYXBwZWRfaWQgPSBtb2R1bGUtPm1hcFtTWU1fQk9PTFNdW2N1ci0+Ym9vbF9p
ZHNbaV0gLSAxXTsNCiAgICAgICAgICAgICAgICAgICAgICAgICBhc3NlcnQocmVtYXBwZWRfaWQg
IT0gMCk7DQo=


--=-C9THyY8KTMk1ldvaaLl5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
