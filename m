Subject: Re: Wrong context for user
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
Cc: dwalsh@redhat.com, SELinux@tycho.nsa.gov
In-Reply-To: <BANLkTikWc10KFhJEwk9hdJ4e2BbbfcB8BQ@mail.gmail.com>
References: <BANLkTinYGbMPaUMmJwMiCkxnBQEvZOd16g@mail.gmail.com>
	 <1308920243.15355.55.camel@moss-pluto>
	 <BANLkTimkpy3RPkT5Mzg-Uc140KPbEcX4=w@mail.gmail.com>
	 <1308924690.15355.72.camel@moss-pluto>
	 <BANLkTinSHxgR8nuBgeaPNqoV2aT8GKAa0Q@mail.gmail.com>
	 <1308926890.15355.74.camel@moss-pluto>
	 <BANLkTikWc10KFhJEwk9hdJ4e2BbbfcB8BQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 24 Jun 2011 11:09:37 -0400
Message-ID: <1308928177.15355.76.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-06-24 at 14:52 +0000, c.r.madhusudhanan@gmail.com wrote:
> attached for your reference.

What do the libselinux/utils say, e.g.:
cd libselinux/utils
./getconlist user_u system_u:system_r:local_login_t
./getseuser root system_u:system_r:local_login_t

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
