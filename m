Subject: Re: Wrong context for user
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <BANLkTinYGbMPaUMmJwMiCkxnBQEvZOd16g@mail.gmail.com>
References: <BANLkTinYGbMPaUMmJwMiCkxnBQEvZOd16g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 24 Jun 2011 08:57:23 -0400
Message-ID: <1308920243.15355.55.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-06-24 at 08:04 -0400, c.r.madhusudhanan@gmail.com wrote:
> Hi All,
> 
> 
> 
> 
> I have meego configured with SELinux refpolicy. I have enabled SELinux
> user to linux user mapping, and though it shows correct selinux user
> and selinux role, 
> the domain/type appears to be wrong.
> 
> 
> For example, when I login linux user "meego", and say ps -Z, it shows
> me,
> 
> 
> user_u:user_r:insmod_t          773   tty1   00:00:00 bash
> user_u:user_r:insmod_t          795   tty1   00:00:00 ps
> 
> 
> where I expect this has to be user_u:user_r:user_t, any pointers?

Please provide your entire ps -Z output, or at least show the entire
ancestry of these processes (in particular the context of the login or
ssh process that spawned them).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
