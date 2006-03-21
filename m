Subject: Re: How can modular policy ever have worked? [patch]
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: sds@tycho.nsa.gov, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1142873874.20739.54.camel@sgc>
References: <1142691657.4017.23.camel@wintermute.xmldesign.de>
	 <1142865553.16487.21.camel@moss-spartans.epoch.ncsc.mil>
	 <1142867787.6145.18.camel@wintermute.xmldesign.de>
	 <1142873874.20739.54.camel@sgc>
Content-Type: multipart/mixed; boundary="=-feAho3YnKmjwYQkI+DCN"
Date: Tue, 21 Mar 2006 11:21:24 -0500
Message-Id: <1142958084.28649.14.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-feAho3YnKmjwYQkI+DCN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2006-03-20 at 11:57 -0500, Christopher J. PeBenito wrote:
> On Mon, 2006-03-20 at 16:16 +0100, Erich Schubert wrote:
> > Any progress on the optional{} in base.pp issues?

> I'm working on it right now.  It requires other changes, as you get
> situations like this:
> 
> optional {
> 	require {
> 		type foo_t;
> 	}
> 	...
> }
> 
> 	type foo_t;
> 
> which results in an duplicate declaration (if this should be considered
> a duplicate declaration is a different discussion).  There is some
> sed'ing to move type declarations above, but it doesn't catch
> declarations that don't start at the beginning of the line (like types
> declared by templates), but if we allow whitespace before the type
> declaration, we need a smarter sed script to skip over the ones in
> require blocks (already written).  But the gen_require() isn't expanded
> until m4 is run (current sed'ing happens before m4), so we have to push
> the m4 to before the sed.  So the build has to be changed to run m4 on
> the individual modules, which should have the added effect of making
> compiler errors useful again.

I've committed all of the prerequisite changes.  The patch to enable
optionals in base is attached; when I apply it, I get:

Compiling refpolicy policy.20
/usr/bin/checkpolicy policy.conf -o policy.20
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
libsepol.expand_module: Error while indexing out symbols
Error while expanding policy
make: *** [policy.20] Error 1

when compiling monolithic.  This is on last week's release versions of
the toolchain.  It doesn't happen with the default base module from make
conf, but if you add enough modules to base, it will also hit this
error.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--=-feAho3YnKmjwYQkI+DCN
Content-Disposition: attachment; filename=opt_in_base.diff
Content-Type: text/x-patch; name=opt_in_base.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64

SW5kZXg6IHBvbGljeS9zdXBwb3J0L2xvYWRhYmxlX21vZHVsZS5zcHQNCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0t
LSBwb2xpY3kvc3VwcG9ydC9sb2FkYWJsZV9tb2R1bGUuc3B0CShyZXZpc2lvbiAxNjI4KQ0KKysr
IHBvbGljeS9zdXBwb3J0L2xvYWRhYmxlX21vZHVsZS5zcHQJKHdvcmtpbmcgY29weSkNCkBAIC0y
NCwxMCArMjQsMTYgQEANCiAjIEZvciB1c2UgaW4gaW50ZXJmYWNlcywgdG8gb3B0aW9uYWxseSBp
bnNlcnQgYSByZXF1aXJlIGJsb2NrDQogIw0KIGRlZmluZShgZ2VuX3JlcXVpcmUnLGANCi0JaWZk
ZWYoYHNlbGZfY29udGFpbmVkX3BvbGljeScsYCcsYA0KKwlpZmRlZihgc2VsZl9jb250YWluZWRf
cG9saWN5JyxgDQorCQlpZmRlZihgX19pbl9vcHRpb25hbF9wb2xpY3knLGANCisJCQlyZXF1aXJl
IHsNCisJCQkJJDENCisJCQl9ICMgZW5kIHJlcXVpcmUNCisJCScpDQorCScsYA0KIAkJcmVxdWly
ZSB7DQogCQkJJDENCi0JCX0NCisJCX0gIyBlbmQgcmVxdWlyZQ0KIAknKQ0KICcpDQogDQpAQCAt
ODYsMTcgKzkyLDE1IEBADQogIyBPcHRpb25hbCBwb2xpY3kgaGFuZGxpbmcNCiAjDQogZGVmaW5l
KGBvcHRpb25hbF9wb2xpY3knLGANCi0JaWZkZWYoYHNlbGZfY29udGFpbmVkX3BvbGljeScsYA0K
LQkJaWZkZWYoYCQxLnRlJyxgJDInLGAkMycpDQotCScsYA0KLQkJb3B0aW9uYWwgew0KLQkJCSQy
DQotCQlpZmVsc2UoYCQzJyxgJyxgJyxgDQotCQl9IGVsc2Ugew0KLQkJCSQzDQotCQknKQ0KLQkJ
fQ0KKwlvcHRpb25hbCB7DQorCQlwdXNoZGVmKGBfX2luX29wdGlvbmFsX3BvbGljeScpIGRubA0K
KwkJJDINCisJCXBvcGRlZihgX19pbl9vcHRpb25hbF9wb2xpY3knKSBkbmwNCisJaWZlbHNlKGAk
MycsYCcsYCcsYA0KKwl9IGVsc2Ugew0KKwkJJDMNCiAJJykNCisJfQ0KICcpDQogDQogIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQo=


--=-feAho3YnKmjwYQkI+DCN--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
