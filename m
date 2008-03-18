Message-ID: <47DFB1CF.4040808@redhat.com>
Date: Tue, 18 Mar 2008 08:13:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: First Attempt at root login on console always FAILS ??
References: <47D9B0DB.90308@redhat.com> <47D9B8BB.2080402@redhat.com> <47D9BBEE.5090105@redhat.com> <1205501760.22912.38.camel@moss-spartans.epoch.ncsc.mil> <47DA9A3C.3080802@redhat.com>  <47DAD18F.5000309@tycho.nsa.gov> <1205525125.22912.96.camel@moss-spartans.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D0472B132@de01exm68.ds.mot.com> <1205756531.22912.128.camel@moss-spartans.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D0472B4EF@de01exm68.ds.mot.com>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D0472B4EF@de01exm68.ds.mot.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hasan Rezaul-CHR010 wrote:
> Hi Stephen & Dan,
> 
> From the /var/log/ files, I am not sure what pam module is having
> problems ?!?  All I get, is a "System error" in the /var/log/secure file
> !
> 
> So I reset the card, when I try to login the first time on the console
> as root, I get "Login incorrect", and the second time, the login is
> successful. This is 100% reproducible.  Selinux is running in
> "Permissive" mode.
> 
> 
> unknown_host login: root
> Password:
> 
> Login incorrect
> Unknown_host login: root
> Password:
> 
> Last login: Mon Mar 17 21:45:52 GMT 2008 on ttyS0
> root@hapWibbSc3:/root> 
> 
> 
> Here are excerpts from the necessary files:
> 
> /var/log/secure
> ----------------------
> 
> Mar 17 21:45:45 unknown sshd[1087]: Server listening on 0.0.0.0 port 22.
> Mar 17 21:45:49 unknown login[2103]: FAILED LOGIN (1) on 'ttyS0' FOR
> `root', System error
> Mar 17 21:45:52 unknown login[2103]: pam_unix(login:session): session
> opened for user root by LOGIN(uid=0)
> Mar 17 21:45:52 unknown login[2951]: ROOT LOGIN  on 'ttyS0'
> 
> 
> 
> /var/log/messages/
> ----------------------------
> 
> Mar 17 21:45:49 unknown kernel: SELinux: initialized (dev dm-5, type
> ext3), uses xattr
> Mar 17 21:45:49 unknown kernel: SELinux: initialized (dev tmpfs, type
> tmpfs), uses transition SIDs
> Mar 17 21:45:49 unknown kernel: SELinux: initialized (dev tmpfs, type
> tmpfs), uses transition SIDs
> Mar 17 21:45:49 unknown kernel: audit(1205790341.507:8): avc:  denied  {
> read } for  pid=743 comm="pam_console_app" name="mnt" dev=dm-3 ino=47105
> scontext=system_u:system_r:pam_console_t:s0
> tcontext=system_u:object_r:file_t:s0 tclass=dir
> 
> 
> /var/log/dmesg
> ----------------------
> 
> audit(1205790341.507:8): avc:  denied  { read } for  pid=743
> comm="pam_console_app" name="mnt" dev=dm-3 ino=47105
> scontext=system_u:system_r:pam_console_t:s0
> tcontext=system_u:object_r:file_t:s0 tclass=dir 
>
Still not sure why you are not able to log in, but it looks like you
have an SELinux labeling problem.  You should not see file_t files on
your system, you probably need to relabel.  fixfiles restore



> 
> 
> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> Sent: Monday, March 17, 2008 7:22 AM
> To: Hasan Rezaul-CHR010
> Cc: SE Linux
> Subject: Re: First Attempt at root login on console always FAILS ??
> 
> 
> On Fri, 2008-03-14 at 18:15 -0400, Hasan Rezaul-CHR010 wrote:
>> Hi All,
>>
>> I am getting an irritating problem on my Linux card (running selinux 
>> in permissive mode), that I didn't use to see before, and am not sure 
>> whats causing it :
>>
>> When I reset my Linux Card, once it boots up, and I get the login 
>> prompt, my first attempt at logging in as root on the console, ALWAYS 
>> fails ! My second attempt and afterwards ALWAYS succeeds !
>>
>> unknown host login: root
>> password: root
>> Login Failure
>> unknown host login: root
>> Password: root
>> root@unknown host#
>>
>>
>>
>> This didn't used to happen before, and I am not sure what's causing 
>> it. I do know that if I disable selinux, the problem goes away !  I am
> 
>> guessing the problem is somewhere in between PAM and SELinux. Any 
>> suggestions on what may be causing it ?  I have versions:
>>
>> checkpolicy     1.34.1 
>> libselinux         1.34.7 
>> libsemanage     1.10.3 
>> libsepol            1.16.1 
>> policycoreutils  1.34.6
>>
>>
>> Contents of  /etc/pam.d/login file
>> ------------------------------------------------
>>
>> # Begin /etc/pam.d/login 
>> auth        required       pam_tally.so onerr=fail deny=3
>> unlock_time=300 
>> auth        requisite      pam_securetty.so 
>> auth        requisite      pam_nologin.so 
>> auth        required       pam_env.so 
>> auth        required       pam_unix.so 
>> account     required       pam_tally.so onerr=fail 
>> account     required       pam_access.so 
>> account     required       pam_unix.so 
>> # pam_selinux.so close should be the first session rule 
>> session     required       pam_selinux.so close 
>> session     required       pam_loginuid.so 
>> session     required       pam_motd.so 
>> session     required       pam_limits.so 
>> session     optional       pam_mail.so     dir=/var/mail standard 
>> session     optional       pam_lastlog.so 
>> session     required       pam_unix.so 
>> # pam_selinux.so open should only be followed by sessions to be 
>> executed in the user context
>> session     required       pam_selinux.so open 
>> # End /etc/pam.d/login
> 
> The pam_selinux entries look ok, assuming the version of pam_selinux you
> are using actually supports the close/open arguments.  The rest of your
> pam config though is rather different from the stock Fedora one.
> 
> Do you get any output in /var/log/secure or elsewhere that identifies
> what pam module is encountering an error?
> 
> If not, can you comment out or make optional some of the pam modules to
> help identify where the failure is occurring, e.g. pam_tally and
> pam_access? 
> 
> --
> Stephen Smalley
> National Security Agency
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkffsc8ACgkQrlYvE4MpobMtzwCggiMDiXjA/h5j603dpQp9e6wV
X4QAn16io7LYkP8X8BpblToKkAFkAZ/G
=vOTe
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
