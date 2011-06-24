MIME-Version: 1.0
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
Date: Fri, 24 Jun 2011 14:26:29 -0700
Message-ID: <BANLkTim8At8cS9j85tf-_7RMQ8PgqM+ZgA@mail.gmail.com>
Subject: Re: Wrong context for user
From: Sam Gandhi <samgandhi9@gmail.com>
To: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, dwalsh@redhat.com,
        SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 24, 2011 at 8:50 AM, c.r.madhusudhanan@gmail.com
<c.r.madhusudhanan@gmail.com> wrote:
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
>

My guess it is picking up the context from
/etc/selinux/<context>/contexts/failsafe_context file.
Does your failsafe_context file have string  system_r:unconfined_t in
it. For experimental purpose if you change it to system_r:initrc_t you
will notice that your login session has context of
root:system_r:initrc_t

Now I don't know SELinux well enough to know if changing the
failsafe_context file is correct thing to do. You could run getseuser
through strace and see all the configuration files it examines.

One thing you will notice is SELinux user libraries read & write
various files in /selinux/ but I haven't found  description of how the
interface for /selinux/XXX is supposed to work


> On Fri, Jun 24, 2011 at 3:09 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On Fri, 2011-06-24 at 14:52 +0000, c.r.madhusudhanan@gmail.com wrote:
>> > attached for your reference.
>>
>> What do the libselinux/utils say, e.g.:
>> cd libselinux/utils
>> ./getconlist user_u system_u:system_r:local_login_t
>> ./getseuser root system_u:system_r:local_login_t
>>
>> --
>> Stephen Smalley
>> National Security Agency
>>
>
>

-Sam

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
