Message-ID: <4E04976D.4010708@redhat.com>
Date: Fri, 24 Jun 2011 09:55:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov
Subject: Re: Wrong context for user
References: <BANLkTinYGbMPaUMmJwMiCkxnBQEvZOd16g@mail.gmail.com>	<1308920243.15355.55.camel@moss-pluto> <BANLkTimkpy3RPkT5Mzg-Uc140KPbEcX4=w@mail.gmail.com>
In-Reply-To: <BANLkTimkpy3RPkT5Mzg-Uc140KPbEcX4=w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/24/2011 09:44 AM, c.r.madhusudhanan@gmail.com wrote:
> Hello  Daniel, Stephen,
> 
> Thanks for the quick reply.
> 
> Yes it looks login runs in the wrong context, system_u:system_r:kernel_t
> and most of the processes are.
> 
> I am loading selinux policies from init, so I would expect all daemons
> should show their respective contexts.
> 
You have got to get init to run as init_t to make this all work
correctly.  If you load policy in the init process then you should rexec
it should change its context to system_u:system_r:init_t:s0, or else the
rest of the transitions will not happen correctly.
> Attached is the "ps -aeZ" output.
> 
> BTW, when I do "run_init /etc/init.d/sshd restart" the context changes from 
> "system_u:system_r:kernel_t" to  "system_u:system_r:initrc_t" but not to
> sshd_t.
> 
This means sshd is not labeled sshd_exec_t.
> Regards,
> Madhu
> 
> 
> 
> 
> On Fri, Jun 24, 2011 at 12:57 PM, Stephen Smalley <sds@tycho.nsa.gov
> <mailto:sds@tycho.nsa.gov>> wrote:
> 
>     On Fri, 2011-06-24 at 08:04 -0400, c.r.madhusudhanan@gmail.com
>     <mailto:c.r.madhusudhanan@gmail.com> wrote:
>     > Hi All,
>     >
>     >
>     >
>     >
>     > I have meego configured with SELinux refpolicy. I have enabled SELinux
>     > user to linux user mapping, and though it shows correct selinux user
>     > and selinux role,
>     > the domain/type appears to be wrong.
>     >
>     >
>     > For example, when I login linux user "meego", and say ps -Z, it shows
>     > me,
>     >
>     >
>     > user_u:user_r:insmod_t          773   tty1   00:00:00 bash
>     > user_u:user_r:insmod_t          795   tty1   00:00:00 ps
>     >
>     >
>     > where I expect this has to be user_u:user_r:user_t, any pointers?
> 
>     Please provide your entire ps -Z output, or at least show the entire
>     ancestry of these processes (in particular the context of the login or
>     ssh process that spawned them).
> 
>     --
>     Stephen Smalley
>     National Security Agency
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk4El20ACgkQrlYvE4MpobP8rgCfXCOo3UZ6dWgk2qe2iy3S7qpL
WqwAoI982X9HrAXv3CClMcbGX2j6ly9a
=jf8Z
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
