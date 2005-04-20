Message-ID: <4265B900.9040703@tyrannical.org>
Date: Tue, 19 Apr 2005 22:05:52 -0400
From: Jason <jason@tyrannical.org>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SELinux@tycho.nsa.gov
Subject: Re: Problems with SElinux and MySQL accessing file on /tmp
References: <426468C8.1080102@tyrannical.org> <200504192245.51491.russell@coker.com.au>
In-Reply-To: <200504192245.51491.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell,

You are my hero :)

I decided to go with your advice - simple and effective. I have my sql 
files written in the /var/lib/mysql/tmp directory. Now mysql has access, 
and selinux doesn't complain. Woo!

Thanks,

Jason

Russell Coker wrote:

>The following policy should allow what you want:
>allow mysqld_t tmp_t:file r_file_perms;
>
>However this might not be ideal for security reasons, there may be data in 
>files labeled as tmp_t.
>
>Maybe a better option would be to create a directory named /var/lib/mysql/tmp 
>for temporary files related to mysql (it will have type mysqld_db_t which 
>grants full access to mysqld_t).  Then you won't be granting any extra access 
>to mysqld_t and you won't need to change your policy.
>
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
