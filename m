Subject: Re: Wrong context for user
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
Cc: dwalsh@redhat.com, SELinux@tycho.nsa.gov
In-Reply-To: <BANLkTinSHxgR8nuBgeaPNqoV2aT8GKAa0Q@mail.gmail.com>
References: <BANLkTinYGbMPaUMmJwMiCkxnBQEvZOd16g@mail.gmail.com>
	 <1308920243.15355.55.camel@moss-pluto>
	 <BANLkTimkpy3RPkT5Mzg-Uc140KPbEcX4=w@mail.gmail.com>
	 <1308924690.15355.72.camel@moss-pluto>
	 <BANLkTinSHxgR8nuBgeaPNqoV2aT8GKAa0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Jul 2011 09:56:04 -0400
Message-ID: <1309528564.31276.26.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-06-24 at 14:44 +0000, c.r.madhusudhanan@gmail.com wrote:
> Thanks Daniel, Stephen.
> 
> I am able to get init_t, local_login_t for init, and login
> respectively. 
> The mistake was tat I missed relabeling the file system, so all the
> executable was in the type file_t.
> 
> But it looks my problem still remains somehow, so that when I try
> login it still shows me wrong domain/type.
> 
> When I login using 'login' (tty1), the context shows as
> user_u:user_r:chkpwd_t and when I check in the X (auto login to user
> 'meego' using 'uxlaunch') shows as user_u:user_r:consoletype_t.
> 
> Attached is the "ps -aeZ" after relabeling the system.

Going back to this ps output, I think you'll need some policy changes to
support MeeGo's uxlaunch approach to starting a user desktop.  You need
uxlaunch to transition into a domain suitable for user login like xdm_t
(used for gdm/xdm/kdm) rather than running in init_t or we won't get the
expected transitions for user domains.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
