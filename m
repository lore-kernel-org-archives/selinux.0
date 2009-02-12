Message-ID: <499497F6.7070909@redhat.com>
Date: Thu, 12 Feb 2009 16:43:18 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Paul Howarth <paul@city-fan.org>
CC: Steven Stromer <filter@stevenstromer.com>, SELinux@tycho.nsa.gov
Subject: Re: SELinux blocking Samba share mounting?
References: <filter-A86D34.14203412022009@news.gmane.org> <20090212211640.652a3f99@metropolis.intra.city-fan.org>
In-Reply-To: <20090212211640.652a3f99@metropolis.intra.city-fan.org>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Paul Howarth wrote:
> On Thu, 12 Feb 2009 14:20:34 -0500
> Steven Stromer <filter@stevenstromer.com> wrote:
> 
>> Hopefully posting to the right list!
>>
>> I'm starting to migrate a few Fedora boxes over to the latest version
>> of CentOS 5 running the latest version of samba:
>>
>> [~]# smbstatus
>> Samba version 3.0.28-1.el5_2.1 
>>
>>
>> However, I am having a hard time getting SELinux to permit the
>> mounting of shares on the first CentOS box. Disabling SELinux permits
>> the shares to mount without problem:
>>
>> [~]# setenforce 1
>> [~]# mount -t cifs //192.168.10.3/PHFiles /mnt/samba -o
>> username=****,password=****,rw retrying with upper case share name
>> mount error 6 = No such device or address
>> [~]# setenforce 0
>> [~]# mount -t cifs //192.168.10.3/PHFiles /mnt/samba -o
>> username=****,password=****,rw [~]# ls -la /mnt/samba/
>> total 8
>> d---rws---+ 6 samba       samba          0 Feb 10 11:17 .
>> drwxr-xr-x  3 root        root        4096 Feb 12 11:13 ..
>> d---rws---+ 2 technology  technology     0 Feb 10 11:14 Computing
>> d---rws---+ 2 development development    0 Feb 10 11:17 Development
>> d---rws---+ 2 root        public         0 Feb 10 11:16 Marketing &
>> Design d---rws---+ 2 root        public         0 Feb 10 11:14 Public
>> Computing [~]# umount /mnt/samba/
>> [~]# setenforce 1
>>
>>
>> Installed policy version is:
>> selinux-policy.noarch              2.4.6-137.1.el5       
>> selinux-policy-targeted.noarch     2.4.6-137.1.el5
>>
>>
>> The two shared directories are:
>>
>> [~]# ls -laZ /home/server1/PHFiles/
>> d---rws---+ samba       samba       system_u:object_r:samba_share_t  .
>> drwxr-xr-x  root        root        root:object_r:user_home_dir_t
>>    .. d---rws---+ technology  technology  root:object_r:samba_share_t
>>      Computing d---rws---+ development development
>> root:object_r:samba_share_t      Development d---rws---+ root
>>        public      root:object_r:samba_share_t      Marketing &
>> Design d---rws---+ root        public
>>      root:object_r:samba_share_t      Public Computing
>>
>> and
>>
>> [~]# ls -laZ /var/www/html
>> d---rwsr-x+ development development
>> system_u:object_r:public_content_rw_t . drwxr-xr-x  root        root
>>        system_u:object_r:httpd_sys_content_t .. ----rwxr-x+
>> development development root:object_r:public_content_rw_t .DS_Store
>> d---rwsr-x+ development development root:object_r:public_content_rw_t
>> private d---rwsr-x+ development development
>> root:object_r:public_content_rw_t public
>>
>> (I am aware that my permissions seem a bit untraditional. I am
>> running an experiment with extended ACL configuration on samba
>> shares. However, I do not believe this to have any bearing on my
>> present problems, as I have numerous other production servers running
>> with these permissions under SELinux, and, again, turning SELinux off
>> resolves my problems instantly.)
>>
>>
>> The following has been executed with no apparent effect:
>> setsebool -P allow_smbd_anon_write=1
>>
>>
>> The following have been executed with no apparent effect (so these
>> have been turned back off): setsebool -P smbd_disable_trans=1
>> setsebool -P nmbd_disable_trans=1
>>
>>
>> I've added the new contexts to file_contexts, and executed
>> 'restorecon -R' to the two shared
>> directories: /home/server1/PHFiles(/.*)? --
>> system_u:object_r:samba_share_t /var/www/html(/.*)? --
>> system_u:object_r:public_content_rw_t
>>
>>
>> setroubleshoot-server is installed, but no AVC denials are reported
>> to /var/log/messages. Instead, when SELinux is enforcing, I get the
>> error: smbd[11852]:   '/home/server1/PHFiles' does not exist or
>> permission denied when connecting to [PHFiles] Error was Permission
>> denied
>>
>>
>> And, finally, I've rebooted. All to no avail. Any assistance would be
>> much appreciated!
> 
> If the audit daemon is running, the AVC denials will be
> in /var/log/audit/audit.log rather than /var/log/messages.
> 
> fedora-selinux-list would probably be more appropriate for this by the
> way.
> 
> Paul.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

setsebool -P use_samba_home_dirs 1
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmUl/YACgkQrlYvE4MpobMOOgCeMPI1VZu86N93qfBY5bxfhk71
o/4AnjypHIr5wCY3L6S6INi/w8LHSXuK
=PIJ/
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
