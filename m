Message-ID: <42F79CD4.1070404@trustedcs.com>
Date: Mon, 08 Aug 2005 12:56:36 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Daniel J Walsh <Dan-Walsh@comcast.net>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Category Translation patch for MCS/MLS Policy
References: <42F38DA8.4090300@comcast.net>
In-Reply-To: <42F38DA8.4090300@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> I have written up a patch for libselinux to implement two functions, to 
> translate the security level.
> 
> getselevelbyname
> getselevelbysename
> setransconlevel
> 
> These functions try to dlopen a libsetrans and call the equivalent 
> functions in this library.
> Currently the patch only changes the *getfilecon function calls use 
> these translations.
> I have also attached a libsetrans-0.1.0-src.rpm  which would be the 
> translation library for MCS.
> 
> I am not sure if a similar library was proposed by TCS or not,  I can 
> not find it.  This is a lot simpler than
> what Ivan proposed last week.
> Manipulation of securitylevel is to be done by the provider of the 
> translation library (setrans).  So that a MLS environment
> can use the Mitre library to translate, while MCS can use much simpler 
> algorithms.
...
> 
> Comments?
> Did I reimplement something that others already implemented?  Is this 
> what people expect?
> 

We at TCS have tried several approaches to address context translations to a "human
readable" form from within libselinux.  Attached is our latest incarnation of the
translation framework.  We have been using this for a while without problems so it
should be fairly stable.  I have shared this with some folks (I believe that I included
you, sorry I did not) to show where we were and get initial feedback before bringing
it to the list (just trying to minimize my public beatdown ;)).  Below is a brief
description of what are doing and a few of my comments/questions from before.  As far
as the question about finding the library - I like libsetrans.so.  We can then make
that a link to any lib which supports the proper interfaces.  I have briefly looked
over your patch and it seems to be a subset of our work (and I'm still not sure ours
is complete).

Here is a brief description of what we are currently doing for context
translations:

- When libselinux initializes, it looks for a translation library on the system.
 If this library is found, it will initialize that library and make a note that
 translations should be performed.  Otherwise, life goes on as before.

- The translations are performed in the routines that receive/return contexts
 from the user.  We have provided extra interfaces (such as getfilecon_raw for
 getfilecon) that will skip translations even if the translation library is
 present on the system.

This method provides a nearly seamless transition for current applications to
take advantage of the translation facility because it hooks into the currently
used interfaces.  The extra interface are provided for developers that wish to
bypass the translations in cases where they are assured that the contexts will
never be presented to the users (there are a few cases of this in the library
itself, such as checkPasswdAccess and rpm_execcon).

This also makes the translation layer very flexible.  The translation library
only needs to have three interface available to libselinux
(init_context_translations, translate_context, and untranslate_context).  The code
can perform the translations however it wants (it should be able to reverse the
translation though).  This includes freedom to use a network based translator where
the library is simply a communications mechanism to the translation daemon.  I'm
reluctant to impose a communication mechanism with a translation daemon into
libselinux itself...

There are some outstanding questions that I have regarding this implementation.

- How do we find the translation library?  It is currently hard coded in libselinux.
  Putting it in a config file has its own issues because every user of libselinux
  will need to be able to read that config.  I'm liking hard coding a name into
  libselinux and using a symlink to get to the real lib because traversing symlinks
  to get to libraries is already handled by the policy.
        Something like /lib/libseltrans -> /lib/libXXX.so

- What should all be stored in translated form?  Certain configuration files will
  most likely want to be kept in the raw form to allow portability across
  installations (just like the policy).  Other files may want to use the translated
  form because that is what will make the most sense to the users.  I have put in
  a safety mechanism in the translation hooks that will allow send back the current
  form of the context if a translation fails.  This allows an application to read in
  a raw or a translated context from a config file and use that context with the
  libselinux interfaces.  I was trying to be more strict about that, but I just
  couldn't get everything working without modding apps that I did not want to touch.

- There are possibly some more translation points that should be added.  For instance,
  I was going put translations into the uavc, but I didn't have time...  And there may
  have been some things added to the lib that I missed putting translations in.

- I made all of the "regular" functions call the "raw" functions.  This could be
  optimized for a lot of cases (the setfilecon functions could call setxattr directly
  instead of calling it through setfilecon_raw), but those are trivial changes.

I welcome questions and comments and patches, etc.  I'm interested to hear what people
think about the approach in general.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
