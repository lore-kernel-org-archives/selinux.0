Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5MI5MDV020368
 for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2016 14:05:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.jlbond.com (Postfix) with ESMTP id BDB8A79D86
 for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2016 11:05:17 -0700 (PDT)
Received: from mail.jlbond.com ([127.0.0.1])
 by localhost (mail.jlbond.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id H3uWVl4qartw for <selinux@tycho.nsa.gov>;
 Wed, 22 Jun 2016 11:05:17 -0700 (PDT)
Received: from [192.168.0.97] (firewall.bbky.org [192.168.0.1])
 by mail.jlbond.com (Postfix) with ESMTP id 4C18E78F93
 for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2016 11:05:17 -0700 (PDT)
To: selinux@tycho.nsa.gov
From: Bond Masuda <bond.masuda@jlbond.com>
Subject: abnormal SELinux context labels
Message-ID: <05514320-f873-9b48-455e-e6c7caff4135@jlbond.com>
Date: Wed, 22 Jun 2016 11:05:17 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------004B69D64F6A491B7E139876"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------004B69D64F6A491B7E139876
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm installing CentOS 7 in a chroot'd environment to build new images of 
CentOS 7 for a private cloud environment. I've done this successfully 
before with CentOS 6 (with help from this list) and we have an automated 
process of doing that now. I'm now porting our process to do similarly 
for CentOS 7. However, after our process is complete, certain 
directories/symlinks have abnormal SELinux contexts assigned to them. 
This causes the system to fail to boot since we have SELinux enforcing 
by default and one of the problematic symlinks is /lib64.

Here is what we see in the CentOS 7 build tree root directory, right 
after a fresh install of CentOS 7 from the full updates repo:

|# ls -alZ /
dr-xr-xr-x. root root system_u:object_r:root_t:s0      .
dr-xr-xr-x. root root system_u:object_r:root_t:s0      ..
drwxr-xr-x. root root system_u:object_r:auditd_log_t:s0 audit
lrwxrwxrwx. root root system_u:object_r:bin_t:s0       bin -> usr/bin
dr-xr-xr-x. root root system_u:object_r:boot_t:s0      boot
drwxr-xr-x. root root unconfined_u:object_r:unlabeled_t:s0 dev
drwxr-xr-x. root root system_u:object_r:etc_t:s0       etc
drwxr-xr-x. root root system_u:object_r:home_root_t:s0 home
lrwxrwxrwx. root root /usr/lib                         lib -> usr/lib
lrwxrwxrwx. root root /usr/lib                         lib64 -> usr/lib64
drwxr-xr-x. root root system_u:object_r:mnt_t:s0       media
drwxr-xr-x. root root system_u:object_r:mnt_t:s0       mnt
drwxr-xr-x. root root system_u:object_r:usr_t:s0       opt
drwxr-xr-x. root root unconfined_u:object_r:unlabeled_t:s0 proc
dr-xr-x---. root root system_u:object_r:admin_home_t:s0 root
drwxr-xr-x. root root /var/run                         run
lrwxrwxrwx. root root system_u:object_r:bin_t:s0       sbin -> usr/sbin
drwxr-xr-x. root root system_u:object_r:var_t:s0       srv
drwxr-xr-x. root root unconfined_u:object_r:unlabeled_t:s0 sys
drwxrwxrwt. root root system_u:object_r:tmp_t:s0       tmp
drwxr-xr-x. root root system_u:object_r:usr_t:s0       usr
drwxr-xr-x. root root system_u:object_r:var_t:s0       var

|As you can see, the SELinux context for "lib", is "/usr/lib"!!! and 
similarly, for "lib64", it is "/usr/lib" ... those are not even valid 
context labels!

How can an invalid string like "/usr/lib" even be assigned as a SELinux 
label in the first place?

I can workaround this with a manual fix using 'chcon 
system_u:object_r:type_label:s0 path', but I'm just wondering how this 
can happen in the first place? When I try to manually reproduce the 
invalid label, I get this:

# chcon /usr/lib lib
chcon: invalid context: /usr/lib

Any insights would be appreciated...
Bond


--------------004B69D64F6A491B7E139876
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf=
-8">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    I'm installing CentOS 7 in a chroot'd environment to build new
    images of CentOS 7 for a private cloud environment. I've done this
    successfully before with CentOS 6 (with help from this list) and we
    have an automated process of doing that now. I'm now porting our
    process to do similarly for CentOS 7. However, after our process is
    complete, certain directories/symlinks have abnormal SELinux
    contexts assigned to them. This causes the system to fail to boot
    since we have SELinux enforcing by default and one of the
    problematic symlinks is /lib64.<br>
    <br>
    Here is what we see in the CentOS 7 build tree root directory, right
    after a fresh install of CentOS 7 from the full updates repo:<br>
    <br>
    <code># ls -alZ /<br>
      dr-xr-xr-x. root root system_u:object_r:root_t:s0=C2=A0 =C2=A0 =C2=A0=
 .<br>
      dr-xr-xr-x. root root system_u:object_r:root_t:s0=C2=A0 =C2=A0 =C2=A0=
 ..<br>
      drwxr-xr-x. root root system_u:object_r:auditd_log_t:s0 audit<br>
      lrwxrwxrwx. root root system_u:object_r:bin_t:s0=C2=A0 =C2=A0 =C2=A0=
 =C2=A0bin -&gt;
      usr/bin<br>
      dr-xr-xr-x. root root system_u:object_r:boot_t:s0=C2=A0 =C2=A0 =C2=A0=
 boot<br>
      drwxr-xr-x. root root unconfined_u:object_r:unlabeled_t:s0 dev<br>
      drwxr-xr-x. root root system_u:object_r:etc_t:s0=C2=A0 =C2=A0 =C2=A0=
 =C2=A0etc<br>
      drwxr-xr-x. root root system_u:object_r:home_root_t:s0 home<br>
      lrwxrwxrwx. root root /usr/lib=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lib -&gt;
      usr/lib<br>
      lrwxrwxrwx. root root /usr/lib=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lib64 -&gt;
      usr/lib64<br>
      drwxr-xr-x. root root system_u:object_r:mnt_t:s0=C2=A0 =C2=A0 =C2=A0=
 =C2=A0media<br>
      drwxr-xr-x. root root system_u:object_r:mnt_t:s0=C2=A0 =C2=A0 =C2=A0=
 =C2=A0mnt<br>
      drwxr-xr-x. root root system_u:object_r:usr_t:s0=C2=A0 =C2=A0 =C2=A0=
 =C2=A0opt<br>
      drwxr-xr-x. root root unconfined_u:object_r:unlabeled_t:s0 proc<br>
      dr-xr-x---. root root system_u:object_r:admin_home_t:s0 root<br>
      drwxr-xr-x. root root /var/run=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run<br>
      lrwxrwxrwx. root root system_u:object_r:bin_t:s0=C2=A0 =C2=A0 =C2=A0=
 =C2=A0sbin -&gt;
      usr/sbin<br>
      drwxr-xr-x. root root system_u:object_r:var_t:s0=C2=A0 =C2=A0 =C2=A0=
 =C2=A0srv<br>
      drwxr-xr-x. root root unconfined_u:object_r:unlabeled_t:s0 sys<br>
      drwxrwxrwt. root root system_u:object_r:tmp_t:s0=C2=A0 =C2=A0 =C2=A0=
 =C2=A0tmp<br>
      drwxr-xr-x. root root system_u:object_r:usr_t:s0=C2=A0 =C2=A0 =C2=A0=
 =C2=A0usr<br>
      drwxr-xr-x. root root system_u:object_r:var_t:s0=C2=A0 =C2=A0 =C2=A0=
 =C2=A0var<br>
      <br>
    </code>As you can see, the SELinux context for "lib", is
    "/usr/lib"!!! and similarly, for "lib64", it is "/usr/lib" ... those
    are not even valid context labels!<br>
    <br>
    How can an invalid string like "/usr/lib" even be assigned as a
    SELinux label in the first place?<br>
    <br>
    I can workaround this with a manual fix using 'chcon
    system_u:object_r:type_label:s0 path', but I'm just wondering how
    this can happen in the first place? When I try to manually reproduce
    the invalid label, I get this:<br>
    <br>
    # chcon /usr/lib lib<br>
    chcon: invalid context: /usr/lib<br>
    <br>
    Any insights would be appreciated...<br>
    Bond<br>
    <br>
  </body>
</html>

--------------004B69D64F6A491B7E139876--
