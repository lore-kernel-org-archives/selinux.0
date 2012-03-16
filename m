MIME-Version: 1.0
In-Reply-To: <1331904135.22861.36.camel@moss-pluto>
References: <CAPweEDzK22daM9ue26tMZ_6HbrFwEZxTfVUXhea31GFO4x0=Qw@mail.gmail.com>
	<1331904135.22861.36.camel@moss-pluto>
Date: Fri, 16 Mar 2012 13:45:28 +0000
Message-ID: <CAPweEDyWSm-2DYOAWfLLCDLsg4D8rRC3MopHZKoovv=TxGxwXA@mail.gmail.com>
Subject: Re: B2G
From: lkcl luke <luke.leighton@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Mar 16, 2012 at 1:22 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2012-03-16 at 05:46 +0000, lkcl luke wrote:
>> allo again: it's been a while since i've been actively been involved
>> with selinux.
>>
>> i just wanted to alert people to the proposal that i put forward to
>> the mozilla B2G team that they consider deploying the FLASK security
>> model (specifically SE/Linux).
>> https://wiki.mozilla.org/Apps/Security#FLASK_for_enforcing_permissions
>> (that's a publicly-editable wiki if anyone wants to comment/edit)
>
> See http://www.nsa.gov/research/selinux/related.shtml for some links to
> work done to apply Flask to various other applications like PostgreSQL,
> Xorg, and D-BUS.

 ta stephen.  put a link on the wiki to that.

>> the concept behind B2G is that the xulrunner (gecko) engine is bashed
>> about and hacked into submission to do double-duty of being *both* a
>> window manager *and* a web browser, and then applications are defined
>> as being "a bit of HTML and Javascript".  yeah it's WebOS in disguise,
>> but they're beginning from the android codebase, ripping out webkit
>> and all the java (hurraaay!) and dropping in gecko instead.
>>
>> so they've got quite a big - and cool - task ahead of them, and they
>> need a replacement for the android security model.  that's where i
>> went "eyy, i know something that would cope, that would be up to the
>> job and would mean no linux kernel coding required, it's called
>> SE/Linux" :)
>>
>> so i had a couple of questions which would help me to assess the
>> viability of my own recommendation.
>>
>> firstly: allo to steven, are you still around? :)
>
> Yes.

 eyyy, that's good to hear.

>> second: did that idea of dynamically allowing bits of binary-compiled
>> se-linux permissions ever get implemented?  last time i was on this
>> list (eek, 2004?), the whole SE/Linux precompiled blob was just that:
>> one huge humungous gelatinous blob that you couldn't mess with, not
>> without doing a tooootal recompile using the m4 macros.
>
> At the userspace level, there has long been support for binary policy
> modules (Fedora >= 5, RHEL >= 5, Debian >= 4.0).

 ha good stuff.  shows you how long it is since i've tackled SE/Linux...

> The policy modules are
> still ultimately linked into a single blob for the kernel before
> loading, but you can manage it at the userspace level via semodule and
> semanage.

 ok.

>> third: are them happy m4 macros still about? :)  did anyone invent
>> anything more... oo.. user-friendly shall we say?  i quite liked them
>> once i got used to it but i'm a bit concerned about the m4 macro
>> language's obtuseness, if people in the B2G group were to be expected
>> to cope with them.  or, more to the point, if application developers
>> were expected to be able to cope.
>
> m4 macros are still widely used in the source policy.  There has been
> some experimentation with a newer policy language with a first-class
> notion of interfaces to supplant the use of a preprocessor, but that's
> experimental, e.g. see:
> http://userspace.selinuxproject.org/trac/wiki/CilDesign
>
> There is a SELinux Policy IDE, http://oss.tresys.com/projects/slide,
> packaged as "eclipse-slide" in modern Fedora and RHEL.
>
> In the case of SEAndroid [http://selinuxproject.org/page/SEAndroid], we
> have carefully avoided the need for Android app developers to ever see
> or write SELinux policy rules.

 interesting.  that might help here.

>> the reason i ask about 2) above is because the suggestion has come up
>> that an application may provide a wide and comprehensive set of
>> functionality (access to the GSM/3G modem as well as access to the
>> GPS), and users may not wish the application to have both.
>>
>> so what i figured was that if the selinux permissions were actually
>> broken down into *three* binary blobs (or as many as are required) it
>> would save CPU cycles on the device (which is going to be
>> resource-limited) as well as improving the response time.
>
> I think you are better off just building the policy on a centralized
> server and shipping the final policy to the device rather than trying to
> manage it as modules on the device.  Linking the binary policy module
> together to form the kernel policy is still fairly memory and CPU
> intensive unfortunately.

 mmm.... hmm... that really can't happen unfortunately.  this could
potentially be millions of units out there, in just as uncontrolled a
fashion as android.

 worst case a phone vendor tries to put this OS onto a 700mhz ARM11
with only 256mb of RAM.  the user experience would be absolutely
dreadful but i'm sure they'll try it on, just to get the price down.
under such circumstances they'll probably have on-board DSPs for
base-band processing (with arbitrary code execution downloadable over
the GSM/3G/CDMA network) in which case it makes a whole mockery of the
idea of "security" anyway.

 so... they'd most likely end up switching off the entire security
model anyway, and just run it as a ghost shell.

>> so, in the example given, blob 1 would cover most of the app; blob 2
>> would cover that app's access to the GSM/3G modem and blob 3 would
>> cover access to the GPS.
>>
>> what's the story?
>
> Who provides the policy?  For a mobile device, you typically don't trust
> the application package (contrast with Linux packages) and thus do not
> want to simply take policy provided by the packager for that app.

 ah, right... :)  i'm actually proposing to them that they treat the
JS/HTML/CSS *as* a "package" - with a complete .deb that gets
digitally-signed etc. etc. all the implications thereof, including
archive management, FTP masters etc. etc.

 so there will be an opportunity to have the usual debconf postinst
triggers to apply/build the SE-Linux policy.

 thank you to both of you,

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
