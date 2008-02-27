Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1RK65iF017676
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 15:06:05 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1RK63Jv026659
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 20:06:03 GMT
Message-ID: <47C5BAA4.5070407@redhat.com>
Date: Wed, 27 Feb 2008 14:31:48 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
CC: selinux@tycho.nsa.gov
Subject: Re: apache_content_template
References: <1204113879.2678.19.camel@vogon>  <47C58688.1030504@redhat.com>	 <1204129416.2678.31.camel@vogon>  <47C5A6E2.10400@redhat.com> <1204140324.2678.42.camel@vogon>
In-Reply-To: <1204140324.2678.42.camel@vogon>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stefan Schulze Frielinghaus wrote:
> On Wed, 2008-02-27 at 13:07 -0500, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Stefan Schulze Frielinghaus wrote:
>>> On Wed, 2008-02-27 at 10:49 -0500, Daniel J Walsh wrote:
>>>> Stefan Schulze Frielinghaus wrote:
>>>>> I wanted to fix a problem with awstats and httpd_t but I ran into a
>>>>> problem and just wanted to hear some other ideas.
>>>>>
>>>>> Awstats uses the apache content template:
>>>>> apache_content_template(awstats)
>>>>>
>>>>> And a few awstats icons are labeled as httpd_awstats_content_t. When the
>>>>> awstats CGI script is executed it generates a HTML file which includes
>>>>> links to these icons. As soon as the httpd receives a query from the
>>>>> client to download these icons an AVC is generated and the request is
>>>>> denied. To allow this I would have to include a rule like:
>>>>>
>>>>> allow httpd_t httpd_awstats_content_t:dir getattr;
>>>>> allow httpd_t httpd_awstats_content_t:file { getattr read };
>>>>>
>>>>> But then I would have to write a require statement for my awstats module
>>>>> to include the type httpd_t as a dependency. While reading the apache.te
>>>>> file I recognized three lines:
>>>>>
>>>>> allow httpd_t httpd_sys_content_t:dir list_dir_perms;
>>>>> read_files_pattern(httpd_t,httpd_sys_content_t,httpd_sys_content_t)
>>>>> read_lnk_files_pattern(httpd_t,httpd_sys_content_t,httpd_sys_content_t)
>>>>>
>>>>> Why aren't these ones included in the apache_content_template like these
>>>>> ones:
>>>>>
>>>>> allow httpd_t httpd_$1_content_t:dir list_dir_perms;
>>>>> read_files_pattern(httpd_t,httpd_$1_content_t,httpd_$1_content_t)
>>>>> read_lnk_files_pattern(httpd_t,httpd_$1_content_t,httpd_$1_content_t)
>>>>>
>>>>> This would solve my problem with awstats and what my interpretation of
>>>>> the httpd_$1_content_t type is that only these files should be red by
>>>>> the httpd_t directly. I think other ones will run into the same problem
>>>>> too.
>>>>>
>>>>> Any thoughts?
>>>>>
>>>>>
>>>>> --
>>>>> This message was distributed to subscribers of the selinux mailing list.
>>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>>   
>>>> Making that change would eliminate any possibility  of separation of cgi 
>>>> data from php data.  IE If I only want my cgi scrips/processes to be 
>>>> able to read my data, it ie easy to do now.  But with your change, any 
>>>> script that does not cause a transition can now access my data.
>>>>
>>>> I would prefer an
>>>>
>>>> apache_can_read(httpd_awstats_content_t)
>>> But if you want to hide data from other scripts you normally use
>>> httpd_$1_script_ro_t or httpd_$1_script_rw_t. The policy of the template
>>> does not have any allow rules to read httpd_$1_content_t (except two
>>> search_dir_perms which does not count). This means that even
>>> httpd_$1_script_t can't read httpd_$1_content_t. So whats the purpose of
>>> httpd_$1_content_t really? I can't see it.
>>>
>> You are right.  Those rules are missing and should be added.
>>
>> read_files_pattern(httpd_$1_script_t, httpdcontent, httpd_$1_content_t)
>> read_lnk_files_pattern(httpd_$1_script_t, httpdcontent, httpd_$1_content_t)
> 
> I'm sorry but I'm still not convinced.
> 
> This would mean we have two types:
> - httpd_$1_content_t
> - httpd_$1_script_ro_t
> which have the same allow rules and the same meaning. No real difference
> (after adding your allow rules).
> 
> And a comment from the apache_content_template indicates that there is
> something wrong with your definition:
> 
> # The following three are the only areas that 
> # scripts can read, read/write, or append to
> 
> After this comment allow rules follow for ro/rw and append types.
> 
> I still believe that the initial purpose of httpd_$1_content_t was to
> allow httpd_t to read files/dirs. Otherwise httpd_$1_script_ro_t could
> be used. Or even httpd_$1_content_t is a duplicate and could be removed.
> 
Yes you might be right.
I would say httpd_$1_script_ro_t should go away and be an alias of
httpd_$1_content_t.  Then allow httpd_$1_script_t read on all
files/directories/lnk_files.  Labeling a directory httpd_$1_script_ro_t
and putting rw_t content in is seems strange.

But there is a boolean to allow httpd to read script specific content.

httpd_builtin_scripting

Which if we changed the httpd_$1_script_ro_t would fix the problem.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfFuqQACgkQrlYvE4MpobMBYQCgtO3951Eg0gyq84wlE+H8FKTu
Xf8AoKLJeYBhJ96mcwyMBYI9aoLK0NE+
=vU6O
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
