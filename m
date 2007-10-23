Message-ID: <471E31E4.9010505@redhat.com>
Date: Tue, 23 Oct 2007 13:39:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: trouble with ssh in today's rawhide + refpolicy
References: <471D1596.8070900@tycho.nsa.gov> <1193144985.9466.53.camel@gorn> <471E2A72.2090903@tycho.nsa.gov>
In-Reply-To: <471E2A72.2090903@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eamon Walsh wrote:
> Christopher J. PeBenito wrote:
>> On Mon, 2007-10-22 at 17:26 -0400, Eamon Walsh wrote:
>>> On a rawhide box updated this afternoon, running refpolicy trunk in
>>> mcs mode, I get the following after rebooting the box and logging in
>>> over ssh:
>>>
>>> $ id -Z
>>> sysadm_u:sysadm_r:system_chkpwd_t:s0
>>
>> Do you have ssh_sysadm_login on?
> 
> Nope, didn't have this set.  That solves the problem, thanks.
> 
> 
You should never log in as root via ssh.  :^)

I think you should fail to login in enforcing mode and return anything
in permissive mode.  Allowing the user to reach a shell as a random
context is dangerous.  As system_chkpwd_t I can read the /etc/shadow
file.  Although in reality I would figure the shell would not have
access to the tty.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHHjHkrlYvE4MpobMRAnyqAJ4stfK0JgY6Fe8292atFcrUXRmsegCg5biQ
jWqGKGSVKrvvtrKzY13aec4=
=tS7D
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
