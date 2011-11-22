MIME-Version: 1.0
In-Reply-To: <1321990751.4161.64.camel@moss-pluto>
References: <4E7B9233.6080609@redhat.com>
	<1316723465.2354.6.camel@moss-pluto>
	<4E7B9B43.9000400@redhat.com>
	<1316723821.2354.9.camel@moss-pluto>
	<1316724121.2354.12.camel@moss-pluto>
	<4E7C9F3D.9030704@redhat.com>
	<1316790421.10259.70.camel@moss-pluto>
	<CAEXv5_hX_dG8+YeJPOdxZafxV2Nf2dM=CKpstUf+vzdYaw2TLw@mail.gmail.com>
	<1317139611.22218.9.camel@moss-pluto>
	<4E82123C.4070406@redhat.com>
	<4E985BFB.1000806@redhat.com>
	<4E9D7267.9060004@tresys.com>
	<4E9EED35.8070408@manicmethod.com>
	<1319041597.7667.5.camel@moss-pluto>
	<CACLa4ptMpMif=DR3-8ppf0Sx-WXFL9WssVV_0usWCvwNqhPy0g@mail.gmail.com>
	<1321989939.4161.60.camel@moss-pluto>
	<CACLa4pvXHuNftBX56zeuQ6oaXg6W8y3CLv9qW4OYCyF+ALJTmw@mail.gmail.com>
	<1321990751.4161.64.camel@moss-pluto>
Date: Tue, 22 Nov 2011 14:42:46 -0500
Message-ID: <CACLa4puxB_udwjWdQwH-CKQ6ydwNQ6nofazrWxc7=bpt7aFaNw@mail.gmail.com>
Subject: Re: I would like to change the behavior of MCS label creations in directory.
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <method@manicmethod.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, David Windsor <dwindsor@gmail.com>,
        SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Nov 22, 2011 at 2:39 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2011-11-22 at 14:37 -0500, Eric Paris wrote:
>> On Tue, Nov 22, 2011 at 2:25 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> > On Tue, 2011-11-22 at 13:59 -0500, Eric Paris wrote:

>> >> A month later and I'm finally back looking at this.  I'm not certain
>> >> looking through the thread what your original suggestions were!  I
>> >> don't see an example of the syntax you want to see.  My best guess is
>> >> people would like to see:
>> >>
>> >> default_user [class_set] {source, target};
>> >> default_role [class_set] {source, target};
>> >> default_type [class_set] {source, target};
>> >> default_range [class_set] {source, target, lub};
>> >>
>> >> Is this right?
>> >
>> > I only gave example syntax for the user/role/type cases (in the earlier
>> > discussion I cited in the archives).  For the MLS range, you need to
>> > distinguish low vs. high vs. full-range for source or target.  If you
>> > want to be able to replace the current hardcoded logic in
>> > mls_compute_sid with configurations, you'd need to be able to express
>> > something like:
>> >
>> > # For processes or sockets, inherit the complete source range.
>> > default_range { process socket_class_set } source low-high;
>> >
>> > # For files, inherit only the low/current level of the source range.
>> > default_range dir_file_class_set source low;
>>
>> Are you suggesting we don't offer a lub option?
>
> I don't think we strictly need it in a first implementation.  We do need
> the ability to distinguish inherit-full-range from inherit-low-level
> though.

I'm just trying to make sure the policy language is ok with it
assuming someone wants it.  But i'm happy not doing it right now.

default_range { process socket_class_set } both lub;

Seems like it could work without too much trouble to the language.
Ok, I've got it!

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
