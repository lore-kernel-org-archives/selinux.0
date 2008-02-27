Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1RG7Yr1014929
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 11:07:34 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1RG7VDp023839
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 16:07:31 GMT
Message-ID: <47C58688.1030504@redhat.com>
Date: Wed, 27 Feb 2008 10:49:28 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
CC: selinux@tycho.nsa.gov
Subject: Re: apache_content_template
References: <1204113879.2678.19.camel@vogon>
In-Reply-To: <1204113879.2678.19.camel@vogon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stefan Schulze Frielinghaus wrote:
> I wanted to fix a problem with awstats and httpd_t but I ran into a
> problem and just wanted to hear some other ideas.
>
> Awstats uses the apache content template:
> apache_content_template(awstats)
>
> And a few awstats icons are labeled as httpd_awstats_content_t. When the
> awstats CGI script is executed it generates a HTML file which includes
> links to these icons. As soon as the httpd receives a query from the
> client to download these icons an AVC is generated and the request is
> denied. To allow this I would have to include a rule like:
>
> allow httpd_t httpd_awstats_content_t:dir getattr;
> allow httpd_t httpd_awstats_content_t:file { getattr read };
>
> But then I would have to write a require statement for my awstats module
> to include the type httpd_t as a dependency. While reading the apache.te
> file I recognized three lines:
>
> allow httpd_t httpd_sys_content_t:dir list_dir_perms;
> read_files_pattern(httpd_t,httpd_sys_content_t,httpd_sys_content_t)
> read_lnk_files_pattern(httpd_t,httpd_sys_content_t,httpd_sys_content_t)
>
> Why aren't these ones included in the apache_content_template like these
> ones:
>
> allow httpd_t httpd_$1_content_t:dir list_dir_perms;
> read_files_pattern(httpd_t,httpd_$1_content_t,httpd_$1_content_t)
> read_lnk_files_pattern(httpd_t,httpd_$1_content_t,httpd_$1_content_t)
>
> This would solve my problem with awstats and what my interpretation of
> the httpd_$1_content_t type is that only these files should be red by
> the httpd_t directly. I think other ones will run into the same problem
> too.
>
> Any thoughts?
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>   
Making that change would eliminate any possibility  of separation of cgi 
data from php data.  IE If I only want my cgi scrips/processes to be 
able to read my data, it ie easy to do now.  But with your change, any 
script that does not cause a transition can now access my data.

I would prefer an

apache_can_read(httpd_awstats_content_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
