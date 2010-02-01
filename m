Subject: Re: Allowing MLS->non-MLS and vice versa upon policy reload
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov, Refpolicy Mailing List <refpolicy@oss1.tresys.com>
In-Reply-To: <201002011303.o11D3TQR030787@vivaldi36.register.it>
References: <201002011303.o11D3TQR030787@vivaldi36.register.it>
Content-Type: text/plain
Date: Mon, 01 Feb 2010 10:32:31 -0500
Message-Id: <1265038351.12435.149.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-02-01 at 14:03 +0100, Guido Trentalancia wrote:
> Hello !
> 
> When switching at runtime from the standard reference policy and the MLS/MCS reference policy (2.20091117), the ssh server on a Debian Lenny system does not accept new connections until it is restarted.
> 
> The following denials are generated:
> 
> type=1400 audit(1265028026.079:19): avc:  denied  { transition } for  pid=8973 comm="sshd" path="/bin/bash" dev=dm-1 ino=146597 scontext=system_u:system_r:sshd_t:s0 tcontext=root:staff_r:staff_t:s0-s0:c0.c1023 tclass=process
> 
> Unfortunately, simply adding a custom module such as the following:
> 
> require {
>         type staff_t;
>         type sshd_t;
>         class process transition;
> }
> 
> #============= sshd_t ==============
> allow sshd_t staff_t:process transition;
> 
> does not help.
> 
> I believe the problem arises as soon as the ssh server opens a shell for the user as I get "/bin/bash: Permission denied" after the initial /etc/motd banner (and the connection is dropped at that point).
> 
> Does anybody have an idea on how to sort out this issue ?
> 
> I believe the server is OpenSSH version 5.1p1, while bash is version 3.2.39(1). I have not had time to test other distributions.

Normally under MCS policy, ssh is started as a ranged daemon (see
ssh.te) so that it can then create ranged user sessions.  So if you
start it under standard policy and then switch to MCS, and you then try
to login to a user who is authorized for something more than just s0,
then it will fail due to violation of a MCS/MLS constraint in the
policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
