Message-ID: <5277D42D.6050609@tycho.nsa.gov>
Date: Mon, 04 Nov 2013 12:06:53 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: selinux@tycho.nsa.gov
Subject: Re: review of a dbus-selinux patch
References: <1383578801.23834.59.camel@localhost>
In-Reply-To: <1383578801.23834.59.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/04/2013 10:26 AM, Colin Walters wrote:
> Hi,
> 
> Does anyone have comments on:
> https://bugs.freedesktop.org/show_bug.cgi?id=71187
> 
> We expect people to be able to change major policy types without
> recompiling userspace, correct?
> 
> The patch makes sense to me (just needs some style fixups per smcv's
> comments).  However, from a quick look at the X.org xselinux code, it
> looks like it also hardcodes e.g. SECCLASS_X_DRAWABLE; we'd need
> a similar change there, right?

XSELinux correctly uses selinux_set_mapping() so that libselinux
internally creates a mapping from arbitrary class/perm indices used by
XSELinux and the policy values and handles all of the translation at
runtime on avc_has_perm() calls.

dbusd can either do the same thing or it can start using
selinux_check_access() instead of directly calling the AVC at all.  Then
all of the SID/context, class, and perm lookups and AVC setup/usage is
transparent to the application, at some potential runtime overhead cost
(but doubt it is significant).  Same topic came up recently for
glibc/ncsd (subject:  Handling unknown permissions in userspace object
managers).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
