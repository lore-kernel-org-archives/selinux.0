Subject: Re: Wrong context for user
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
Cc: dwalsh@redhat.com, SELinux@tycho.nsa.gov
In-Reply-To: <BANLkTikJLUuP4g=krqa3wyxh1FF=2E52SA@mail.gmail.com>
References: <BANLkTinYGbMPaUMmJwMiCkxnBQEvZOd16g@mail.gmail.com>
	 <1308920243.15355.55.camel@moss-pluto>
	 <BANLkTimkpy3RPkT5Mzg-Uc140KPbEcX4=w@mail.gmail.com>
	 <1308924690.15355.72.camel@moss-pluto>
	 <BANLkTinSHxgR8nuBgeaPNqoV2aT8GKAa0Q@mail.gmail.com>
	 <1308926890.15355.74.camel@moss-pluto>
	 <BANLkTikWc10KFhJEwk9hdJ4e2BbbfcB8BQ@mail.gmail.com>
	 <1308928177.15355.76.camel@moss-pluto>
	 <BANLkTikJLUuP4g=krqa3wyxh1FF=2E52SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Jul 2011 09:23:15 -0400
Message-ID: <1309526595.31276.2.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-06-24 at 15:50 +0000, c.r.madhusudhanan@gmail.com wrote:
> [root@localhost utils]# ./getconlist user_u 
> user_u:user_r:consoletype_t
> [root@localhost utils]# ./getconlist root
> root:sysadm_r:sysadm_t
> 
> [root@localhost utils]# ./getseuser meego
> seuser:  user_u, level (null)
> Context 0       user_u:user_r:consoletype_t
> [root@localhost utils]# ./getseuser root
> seuser:  root, level (null)
> Context 0       root:sysadm_r:sysadm_t
> (I dont know but the getseuser dint work until I changed the code 
>  if (argc != 2). )

You aren't invoking them correctly - you need to pass the security
context of the login process as the second argument, as I showed.

For example, on Fedora, we have:
$ ./getconlist user_u system_u:system_r:local_login_t:s0
user_u:user_r:user_t:s0
$ ./getseuser root system_u:system_r:local_login_t:s0
$ ./getseuser root system_u:system_r:local_login_t:s0
seuser:  unconfined_u, level s0-s0:c0.c1023
Context 0	unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023

Omit the :s0 if you don't have MLS enabled in your policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
