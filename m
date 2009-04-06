Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n36HtG9W028705
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 13:55:16 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n36HtFBS017090
	for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2009 17:55:15 GMT
Message-ID: <49DA4200.1000102@redhat.com>
Date: Mon, 06 Apr 2009 13:55:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: Scott Radvan <sradvan@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: request for review of httpd-related Boolean definitions
References: <20090331151638.770627cb@redhat.com> <1238495418.3465.69.camel@notebook2.grift.internal>
In-Reply-To: <1238495418.3465.69.camel@notebook2.grift.internal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/31/2009 06:30 AM, Dominick Grift wrote:
> On Tue, 2009-03-31 at 15:16 +1000, Scott Radvan wrote:
>
> I am going to use this thread to just share any thoughts i have with regards to this
>> o  allow_httpd_anon_write
>> This Boolean is off by default, allowing httpd only read access to
>> files labeled with the public_content_rw_t type. Enabling this Boolean
>> will allow httpd to write to files labeled with the public_content_rw_t
>> type, such as a public directory containing files for a public file
>> transfer service.
>
>
>> o  allow_httpd_mod_auth_ntlm_winbind
>> This Boolean is off by default. Enabling it will allow access to NTLM
>> and Winbind authentication mechanisms via the mod_auth_ntlm_winbind
>> module in httpd.
>>
>> o  allow_httpd_mod_auth_pam
>> This Boolean is off by default. Enabling it will allow access to PAM
>> authentication mechanisms via the mod_auth_pam module in httpd.
>>
>> o  allow_httpd_sys_script_anon_write
>> This Boolean is off by default. It defines whether or not HTTP scripts
>> are allowed write access to files labeled with the public_content_rw_t
>> type, as used in a public file transfer service.
>>
>> o  httpd_builtin_scripting
>> This Boolean is on by default, allowing httpd scripting. Having this
>> Boolean enabled is often required for PHP content.
>
> It allows:
>
> 1. httpd_t to manage templated httpd rw content,
> 2. httpd_t to read templated httpd ra content,
> 3. httpd_t to read templated httpd content,
>
> # Allow the web server to run scripts and serve pages
> tunable_policy(`httpd_builtin_scripting',`
> 	manage_dirs_pattern(httpd_t, httpd_$1_content_rw_t, httpd_
> $1_content_rw_t)
> 	manage_files_pattern(httpd_t, httpd_$1_content_rw_t, httpd_
> $1_content_rw_t)
> 	manage_lnk_files_pattern(httpd_t, httpd_$1_content_rw_t, httpd_
> $1_content_rw_t)
> 	rw_sock_files_pattern(httpd_t, httpd_$1_content_rw_t, httpd_
> $1_content_rw_t)
>
> 	allow httpd_t httpd_$1_content_ra_t:dir { list_dir_perms
> add_entry_dir_perms };
> 	read_files_pattern(httpd_t, httpd_$1_content_ra_t, httpd_
> $1_content_ra_t)
> 	append_files_pattern(httpd_t, httpd_$1_content_ra_t, httpd_
> $1_content_ra_t)
> 	read_lnk_files_pattern(httpd_t, httpd_$1_content_ra_t, httpd_
> $1_content_ra_t)
>
> 	allow httpd_t httpd_$1_content_t:dir list_dir_perms;
> 	read_files_pattern(httpd_t, httpd_$1_content_t, httpd_$1_content_t)
> 	read_lnk_files_pattern(httpd_t, httpd_$1_content_t, httpd_$1_content_t)
>
> 	allow httpd_t httpd_$1_content_t:dir list_dir_perms;
> 	read_files_pattern(httpd_t, httpd_$1_content_t, httpd_$1_content_t)
> 	read_lnk_files_pattern(httpd_t, httpd_$1_content_t, httpd_$1_content_t)
> ')
>
> I think this is a bug in policy or atleast that this boolean is too
> coarse
>
> with this boolean set to false: httpd_t cannot read
> httpd_user_content_t. Basically what it means is that you cannot use
> httpd userdirs (httpd_enable_userdirs) without scripting enabled.
>
In Fedora policy I have removed the booleans from the templated 
interfaces,  So these booleans only effect httpd_sys_*.  If you use the 
templates you need to either allow the access or add your own booleans.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
