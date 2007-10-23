Message-ID: <471DD350.2020100@redhat.com>
Date: Tue, 23 Oct 2007 06:56:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: trouble with ssh in today's rawhide + refpolicy
References: <471D1596.8070900@tycho.nsa.gov> <471D284D.70700@tycho.nsa.gov>
In-Reply-To: <471D284D.70700@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eamon Walsh wrote:
> Eamon Walsh wrote:
>> On a rawhide box updated this afternoon, running refpolicy trunk in
>> mcs mode, I get the following after rebooting the box and logging in
>> over ssh:
>>
>> $ id -Z
>> sysadm_u:sysadm_r:system_chkpwd_t:s0
>>
>> After issuing a "service sshd restart" on the box and trying again, it
>> changes to:
> 
> Should have used run_init to restart sshd.  When I do this, it remains
> system_chkpwd_t.  Also, I'm running in permissive mode and using public
> key to authenticate.
> 
> Some searching revealed previous bug reports, most recently Sept 21:
> http://archives.gentoo.org/gentoo-hardened/msg_07021.xml
> 
> 
It sounds to me like sshd is not labeled correctly.  Or perhaps the
entire machine.  What is sshd running as?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHHdNQrlYvE4MpobMRAmNRAJ9XjTkqPfN3e18y+Ofhn4vWqg6vPwCfVMOt
Wi8iSuVsdSkNvamccgS6dwc=
=ksSk
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
