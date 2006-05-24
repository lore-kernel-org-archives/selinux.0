Subject: Re: Fedora Core 5 Tomcat 4 problems
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Michael K. Smith" <mksmith@adhost.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <C099E0B2.24D7E%mksmith@adhost.com>
References: <C099E0B2.24D7E%mksmith@adhost.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 13:15:00 -0400
Message-Id: <1148490901.24463.465.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-24 at 10:06 -0700, Michael K. Smith wrote:
> Sadly, it's necessary to confirm whether or not the rc script will fire at
> boot.  If I run the script after the system has booted everything works just
> fine.

Hmmm...it should run in the same context in both cases (i.e. initrc_t)
so that manual execution of the rc script yields the expected behavior.
If I create a script in /etc/init.d and restorecon it, executing it
manually does run it in initrc_t as expected here.

> > Can we see the full avc message for the execmod denial?
> 
> Absolutely.
> 
> May 27 08:03:57 bmedia kernel: audit(1117206233.280:4): avc:  denied  { read
> } for  pid=1813 comm="su" name="tomcat" dev=sda6 ino=98262
> scontext=system_u:system_r:initrc_su_t:s0 tcontext=user_u:object_r:usr_t:s0
> tclass=lnk_file

Not that one - the execmod denial, please.  Might help to boot with
audit=1 as well to get the full syscall audit record for it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
