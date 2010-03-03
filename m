Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o23G1xGP019784
	for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2010 11:01:59 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id o23G2LrD008365
	for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2010 16:02:21 GMT
Subject: Re: squid and apache
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Dominick Grift <domg472@gmail.com>, russell@coker.com.au,
        SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4B8E7B5E.30005@redhat.com>
References: <201003031007.35281.russell@coker.com.au>
	 <4B8E3807.3060809@gmail.com>  <4B8E7B5E.30005@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 03 Mar 2010 11:01:24 -0500
Message-ID: <1267632084.30557.96.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-03-03 at 10:08 -0500, Daniel J Walsh wrote:
> On 03/03/2010 05:20 AM, Dominick Grift wrote:
> > On 03/03/2010 12:07 AM, Russell Coker wrote:
> > <snip>
> >    
> >> How should we solve this?
> >>
> >>      
> > I Wrote a blog with my view on this issue here:
> >
> > http://selinux-mac.blogspot.com/2010/02/about-apachecontenttemplate.html
> >
> > I am also interested in other views on this.
> >
> >    
> Dominic your example would not work since it would not have rules to 
> handle apache content is not present.  What happens to you executable.
> 
> I am not sure this would work.
> optional_policy(`
> apache_cgi_domain(backuppc_admin_t, backuppc_admin_exec_t)
> ',`
>      gen_require(`
>              type bin_t;
>      ')
>      typealias bin_t alias backuppc_admin_exec_t;
> ')

That won't work because you can't put require blocks in the else block
of an optional.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
