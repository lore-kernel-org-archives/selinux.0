Subject: Re: [SEMANAGE] [SEPOL] Change size_t -> unsigned int
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Steve Grubb <sgrubb@redhat.com>
In-Reply-To: <43C592E9.20900@cornell.edu>
References: <43C592E9.20900@cornell.edu>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 08:51:45 -0500
Message-Id: <1137160305.3445.120.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-01-11 at 16:21 -0700, Ivan Gyurdiev wrote:
> The count functions work with unsigned int. The list functions work with 
> size_t, and do not convert unsigned int properly, breaking 64-bit 
> platforms. Size_t = unsigned int | unsigned long int, and long int >= 
> int. I was also told on #selinux that a size_t usually indicates a value 
> measured in bytes. Therefore, size_t does not seem appropriate in the 
> list() function.
> 
> Please consider the following patch, which changes list functions in 
> many places to use unsigned int, instead of size_t.
> I also changed get_roles/set_roles in the user record. Also, fixed an 
> unitialized variable bug in the error path of booleans_activedb.c: 
> bool_read_list, reported out by Sergey Tikhonov (bugzilla).
> 
> Technically this is an API change, but I doubt it will cause any 
> problems - it's much more likely to solve problems on 64-bit platforms.

Merged as of libsepol 1.11.9 and libsemanage 1.5.12.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
