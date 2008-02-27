Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1RGOlOH016871
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 11:24:47 -0500
Received: from mail.seekline.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1RGOiKD011837
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 16:24:45 GMT
Subject: Re: apache_content_template
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <47C58688.1030504@redhat.com>
References: <1204113879.2678.19.camel@vogon>  <47C58688.1030504@redhat.com>
Content-Type: text/plain
Date: Wed, 27 Feb 2008 17:23:36 +0100
Message-Id: <1204129416.2678.31.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-02-27 at 10:49 -0500, Daniel J Walsh wrote:
> Stefan Schulze Frielinghaus wrote:
> > I wanted to fix a problem with awstats and httpd_t but I ran into a
> > problem and just wanted to hear some other ideas.
> >
> > Awstats uses the apache content template:
> > apache_content_template(awstats)
> >
> > And a few awstats icons are labeled as httpd_awstats_content_t. When the
> > awstats CGI script is executed it generates a HTML file which includes
> > links to these icons. As soon as the httpd receives a query from the
> > client to download these icons an AVC is generated and the request is
> > denied. To allow this I would have to include a rule like:
> >
> > allow httpd_t httpd_awstats_content_t:dir getattr;
> > allow httpd_t httpd_awstats_content_t:file { getattr read };
> >
> > But then I would have to write a require statement for my awstats module
> > to include the type httpd_t as a dependency. While reading the apache.te
> > file I recognized three lines:
> >
> > allow httpd_t httpd_sys_content_t:dir list_dir_perms;
> > read_files_pattern(httpd_t,httpd_sys_content_t,httpd_sys_content_t)
> > read_lnk_files_pattern(httpd_t,httpd_sys_content_t,httpd_sys_content_t)
> >
> > Why aren't these ones included in the apache_content_template like these
> > ones:
> >
> > allow httpd_t httpd_$1_content_t:dir list_dir_perms;
> > read_files_pattern(httpd_t,httpd_$1_content_t,httpd_$1_content_t)
> > read_lnk_files_pattern(httpd_t,httpd_$1_content_t,httpd_$1_content_t)
> >
> > This would solve my problem with awstats and what my interpretation of
> > the httpd_$1_content_t type is that only these files should be red by
> > the httpd_t directly. I think other ones will run into the same problem
> > too.
> >
> > Any thoughts?
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> >   
> Making that change would eliminate any possibility  of separation of cgi 
> data from php data.  IE If I only want my cgi scrips/processes to be 
> able to read my data, it ie easy to do now.  But with your change, any 
> script that does not cause a transition can now access my data.
> 
> I would prefer an
> 
> apache_can_read(httpd_awstats_content_t)

But if you want to hide data from other scripts you normally use
httpd_$1_script_ro_t or httpd_$1_script_rw_t. The policy of the template
does not have any allow rules to read httpd_$1_content_t (except two
search_dir_perms which does not count). This means that even
httpd_$1_script_t can't read httpd_$1_content_t. So whats the purpose of
httpd_$1_content_t really? I can't see it.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
