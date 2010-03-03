Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o23GPX7p021472
	for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2010 11:25:38 -0500
Received: from mail-pw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o23GQ0QR021606
	for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2010 16:26:00 GMT
Received: by pwi2 with SMTP id 2so934168pwi.12
        for <selinux@tycho.nsa.gov>; Wed, 03 Mar 2010 08:24:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1267632084.30557.96.camel@gorn.columbia.tresys.com>
References: <201003031007.35281.russell@coker.com.au>
	 <4B8E3807.3060809@gmail.com> <4B8E7B5E.30005@redhat.com>
	 <1267632084.30557.96.camel@gorn.columbia.tresys.com>
Date: Wed, 3 Mar 2010 11:24:35 -0500
Message-ID: <150846cc1003030824q73cc9fd5u34acab36a2f4e42c@mail.gmail.com>
Subject: Re: squid and apache
From: Caleb Case <calebcase@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Dominick Grift <domg472@gmail.com>,
        russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 3, 2010 at 11:01 AM, Christopher J. PeBenito
<cpebenito@tresys.com> wrote:
>
> On Wed, 2010-03-03 at 10:08 -0500, Daniel J Walsh wrote:
> > On 03/03/2010 05:20 AM, Dominick Grift wrote:
> > > On 03/03/2010 12:07 AM, Russell Coker wrote:
> > > <snip>
> > >
> > >> How should we solve this?
> > >>
> > >>
> > > I Wrote a blog with my view on this issue here:
> > >
> > > http://selinux-mac.blogspot.com/2010/02/about-apachecontenttemplate.html
> > >
> > > I am also interested in other views on this.
> > >
> > >
> > Dominic your example would not work since it would not have rules to
> > handle apache content is not present.  What happens to you executable.
> >
> > I am not sure this would work.
> > optional_policy(`
> > apache_cgi_domain(backuppc_admin_t, backuppc_admin_exec_t)
> > ',`
> >      gen_require(`
> >              type bin_t;
> >      ')
> >      typealias bin_t alias backuppc_admin_exec_t;
> > ')
>
> That won't work because you can't put require blocks in the else block
> of an optional.
>

Thought I'd mention that the proposed CIL would alleviate this problem
since it allows you to put FC statements in the policy (and in
conditional statements). For example:

# if the squid block exists (i.e., the squid module is in the policy)
IF (? /(BLOCK squid)) {
  # call the apache block with the squid type
  CALL /(BLOCK apache_content_template) (TYPE squid)

  # label the squid cache manager
  LABEL (PATH:FILE (PATH:REGEX "/usr/lib/squid/cachemgr\.cgi")
(PATH:FILETYPE "--")) {
     USER system
     ROLE object
     TYPE squid_script_exec
     RANGE (LEVEL s0)
  }
}

The syntax is probably going to be changed at some point, but this
does illustrate the general concept that labeling is part of the
policy language proper and can be used in conditionals.

Caleb


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
