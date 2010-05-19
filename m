Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4JHjFPn032338
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2010 13:45:17 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o4JHiZi0029497
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2010 17:44:35 GMT
Subject: Re: [refpolicy] Howto enable or disable clipboard with selinux?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Shaz <shazalive@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>, refpolicy@oss1.tresys.com
In-Reply-To: <AANLkTimOdxgxn1jBFfWABOvTQbOK9ZT6sMsjFCdZQp2L@mail.gmail.com>
References: <AANLkTinfrhS8r4gnc92Pmt78dQ080wlJEdH8qZjM0ZjK@mail.gmail.com>
	 <AANLkTimOdxgxn1jBFfWABOvTQbOK9ZT6sMsjFCdZQp2L@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 19 May 2010 13:45:01 -0400
Message-ID: <1274291101.2093.271.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-05-19 at 20:33 +0500, Shaz wrote:
> On Sat, May 15, 2010 at 10:50 PM, Shaz <shazalive@gmail.com> wrote:
> > Dear list,
> >
> > I want to enable or disable the clipboard with booleans. Is there any
> > available policy that can do this? If not please indicate the relevant place
> > to start with.
> 
> There was a flaw in this question that someone on selinux irc
> explained to me. We need to control an application's access to
> booleans. But I am still not sure how much and what effort it
> requires? Pointer to tutorials or some guidance will be appreciated.

If you want to allow changing Booleans on a coarse level (all or
nothing), you just need to allow the setbool permission.  The
selinux_set_generic_booleans() or selinux_set_all_booleans() interfaces
should be sufficient for this.

If you want to be fine grained, you can label the selinuxfs entry for
the boolean using the selinux_labeled_boolean() interface.  For example
if you wanted to label the "disable_clipboard" boolean:

type my_boolean_t;
selinux_labeled_boolean(my_boolean_t, disable_clipboard)

Then you would need to allow rw permissions on the my_boolean_t file, in
addition to the setbool permission.  The caveat on this is that the
selinux_labeled_boolean() call and type declaration must be in the base
module, if you use a modular policy.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
