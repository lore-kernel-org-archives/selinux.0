Subject: Re: I would like to change the behavior of MCS label creations in
 directory.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: Joshua Brindle <method@manicmethod.com>,
        "Christopher J. PeBenito"
 <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Windsor
 <dwindsor@gmail.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <CACLa4pvXHuNftBX56zeuQ6oaXg6W8y3CLv9qW4OYCyF+ALJTmw@mail.gmail.com>
References: <4E7B9233.6080609@redhat.com>
	 <1316723465.2354.6.camel@moss-pluto> <4E7B9B43.9000400@redhat.com>
	 <1316723821.2354.9.camel@moss-pluto> <1316724121.2354.12.camel@moss-pluto>
	 <4E7C9F3D.9030704@redhat.com> <1316790421.10259.70.camel@moss-pluto>
	 <CAEXv5_hX_dG8+YeJPOdxZafxV2Nf2dM=CKpstUf+vzdYaw2TLw@mail.gmail.com>
	 <1317139611.22218.9.camel@moss-pluto> <4E82123C.4070406@redhat.com>
	 <4E985BFB.1000806@redhat.com> <4E9D7267.9060004@tresys.com>
	 <4E9EED35.8070408@manicmethod.com> <1319041597.7667.5.camel@moss-pluto>
	 <CACLa4ptMpMif=DR3-8ppf0Sx-WXFL9WssVV_0usWCvwNqhPy0g@mail.gmail.com>
	 <1321989939.4161.60.camel@moss-pluto>
	 <CACLa4pvXHuNftBX56zeuQ6oaXg6W8y3CLv9qW4OYCyF+ALJTmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 22 Nov 2011 14:39:11 -0500
Message-ID: <1321990751.4161.64.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-11-22 at 14:37 -0500, Eric Paris wrote:
> On Tue, Nov 22, 2011 at 2:25 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Tue, 2011-11-22 at 13:59 -0500, Eric Paris wrote:
> >> On Wed, Oct 19, 2011 at 12:26 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> > On Wed, 2011-10-19 at 11:31 -0400, Joshua Brindle wrote:
> >> >> Christopher J. PeBenito wrote:
> >> >> > On 10/14/11 11:57, Daniel J Walsh wrote:
> >> >> >> Eric and I have come up with the following syntax for this behaviour.
> >> >> >>
> >> >> >> default_trans level dir_file_class_set parent;
> >> >> >
> >> >> > I think we want this to be "range" instead of "level", since the field is actually a range.
> >> >> >
> >> >> >> default_trans user dir_file_class_set process;
> >> >> >> default_trans role file parent;
> >> >> >
> >> >> > Isn't there a better set of tokens than this?  Why not make it default_user, default_role, default_type, and default_range?  Creating an object doesn't really imply a transition, so "trans" seems misleading.
> >> >> >
> >> >>
> >> >> I agree with Chris. This will actually let you make things not transition by
> >> >> default so _trans is misleading. Further, "process" shouldn't be a token since
> >> >> it is an object class (you couldn't actually parse policy with Eric's patches
> >> >> could you?). I don't like "parent" as a token either, and SELinux doesn't know
> >> >> anything about processes and parents anyway. SDS's suggestions a while back are
> >> >> more appropriate IMO, since SELinux does know what source and target are.
> >> >
> >> > Unsurprisingly I agree with my original suggestions.  Also, I don't see
> >> > that you've addressed the issue of range/level defaults needing to
> >> > specify whether you want to inherit the low level, the high level or the
> >> > complete range of the source or the target contexts.
> >>
> >> A month later and I'm finally back looking at this.  I'm not certain
> >> looking through the thread what your original suggestions were!  I
> >> don't see an example of the syntax you want to see.  My best guess is
> >> people would like to see:
> >>
> >> default_user [class_set] {source, target};
> >> default_role [class_set] {source, target};
> >> default_type [class_set] {source, target};
> >> default_range [class_set] {source, target, lub};
> >>
> >> Is this right?
> >
> > I only gave example syntax for the user/role/type cases (in the earlier
> > discussion I cited in the archives).  For the MLS range, you need to
> > distinguish low vs. high vs. full-range for source or target.  If you
> > want to be able to replace the current hardcoded logic in
> > mls_compute_sid with configurations, you'd need to be able to express
> > something like:
> >
> > # For processes or sockets, inherit the complete source range.
> > default_range { process socket_class_set } source low-high;
> >
> > # For files, inherit only the low/current level of the source range.
> > default_range dir_file_class_set source low;
> 
> Are you suggesting we don't offer a lub option?

I don't think we strictly need it in a first implementation.  We do need
the ability to distinguish inherit-full-range from inherit-low-level
though.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
