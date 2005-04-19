From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Jason <jason@tyrannical.org>
Subject: Re: Problems with SElinux and MySQL accessing file on /tmp
Date: Tue, 19 Apr 2005 22:45:47 +1000
Cc: SELinux@tycho.nsa.gov
References: <426468C8.1080102@tyrannical.org>
In-Reply-To: <426468C8.1080102@tyrannical.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504192245.51491.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 19 April 2005 12:11, Jason <jason@tyrannical.org> wrote:
>  I get that when I try to use a mysql query "load data concurrent infile
> '/tmp/filename' etc"
>
> allow mysqld_t tmp_t:dir { getattr }; doesn't help. I need a way to give
> mysql  getattr globally, or at least in the tmp folder.  in
> filecontexts, /tmp/.* is listed as <<none>>
>
> the file it's accessing in /tmp is user_u:object_r:tmp_t

The following policy should allow what you want:
allow mysqld_t tmp_t:file r_file_perms;

However this might not be ideal for security reasons, there may be data in 
files labeled as tmp_t.

Maybe a better option would be to create a directory named /var/lib/mysql/tmp 
for temporary files related to mysql (it will have type mysqld_db_t which 
grants full access to mysqld_t).  Then you won't be granting any extra access 
to mysqld_t and you won't need to change your policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
