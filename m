Message-Id: <201206061755.q56HtHFF004774@vivaldi48.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: walters@verbum.org
Cc: SELinux@tycho.nsa.gov
Subject: Re: [PATCH]: allow standard compilation of GIT development tree (was Re: [PATCH]: do not link static libraries from the system library directory)
Date: Wed, 06 Jun 2012 19:55:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Colin.

>On Tue, 2012-06-05 at 00:07 +0200, Guido Trentalancia wrote:
>
>> >I've never really seen something which can get it right 'all the
>> >time'.  Fedora, and I assume other distros actually just use the git
>> >tree subdirectories.  I feel like any such patch to handle this is
>> >going to have to be something set in the top level Makefile and will
>> >have to cause no difficulties for other workflows....
>
>See http://people.gnome.org/~walters/docs/build-api.txt
>
>This patch looks roughly right to me, though it'd make me happier
>if you also added a configure script.  (Note: configure script does
>not have to be implemented with autoconf; see
>http://git.gnome.org/browse/gtk-doc-stub/tree/configure for a minimal
>plain sh one).
>
>> My problem with this patch is that now all of the CFLAGS stuff we have
>> lower in the tree (namely -W* stuff) is not going to get picked up
>> since
>> CFLAGS are already exported...
>> 
>> So how do we solve that one too?
>
>The automake way is to have AM_CFLAGS, AM_CPPFLAGS which are
>build-internal (and always used).  CFLAGS is then something that can
>be added by the builder.

The autotools option has been discussed already several times and it has always been rejected.

For example, some of the original authors just do not like autotools very much.

I am quite neutral about liking it or not, but to be honest, for this specific project and considered its size and nature, I really think at the moment autotools would only introduce unneeded complexity without any significant benefit.

Autotools are probably mandatory or strongly recommended only for GNU projects.

If and when, the project grows with a significant number of configurable build options (unlikely, as options are usually runtime ones), then it is probably possible to re-evaluate the situation, I suppose.

Or, at least, this is my personal opinion about it. Other people, in particular the maintainers, might have different opinions.

If you want to propose the minimal configure script that you wrote, my personal opinion is that it might tidy up the build logic a little bit so that it can be better managed over time and it might also turn out to be handy to someone someday...

But I think you should submit it as a patch for revision by the maintainers and other users with all the lower levels Makefiles modified to source the file produced by the script (i.e. as a working solution).

Regards,

Guido 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
