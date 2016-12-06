Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB6K4bZv023693
 for <selinux@tycho.nsa.gov>; Tue, 6 Dec 2016 15:04:37 -0500
To: SELinux <selinux@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Subject: Why do we block context="foobar" from User Namespace
Cc: Seth Forshee <seth.forshee@canonical.com>,
 "Eric W. Biederman" <ebiederm@redhat.com>
Message-ID: <90ddcce6-a5eb-b05e-a347-ec8ef5c47db1@redhat.com>
Date: Tue, 6 Dec 2016 15:04:32 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------D76F28397F4225BFE518132E"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------D76F28397F4225BFE518132E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Currently in SELinux and UserNamespace can not be enabled with Docker/runc at the same time.

Runc mounts tmpfs directories with --context="system_u:object_r:container_file_t:s0:c1,c2" type labels
but the following patch blocks the use of context mounts when using user namespace.

http://kernel.suse.com/cgit/kernel/commit/?id=aad82892af261b9903cc11c55be3ecf5f0b0b4f8

User Namespace has to be established before tmpfs are mounted so we are unable to mount a
tmpfs with a context=flag and UserNamespace enabled.

Controlling the ability to change the label of a mounted file systemd should be a MAC decision not a DAC, 
or UserNamespace. Setting the SELinux labels on an object like a file system mount point
should be controlled by SELinux.  SELinux should check if the label of the process doing the
mount is able to relabel from the label of the mount point, and labelto the specified label.

SELinux does this for privileged processes (running with SYS_ADMIN) so use namespace should not be
any different.  Also the process doing the mount would be allowed by DAC to set the label of the tmpfs after
it is mounted (As long as SELinux allowed).

There is no security difference between:

mount -o tmpfs context="foobar" none /dev


And

mount -o tmpfs none /dev

chcon foobar -R /dev


The second would not be blocked by usernamespace.  

Bottom line this patch should be reverted so container runtimes like docker can use both User Namespace
and SELinux at the same time.

 





--------------D76F28397F4225BFE518132E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>
    </p>
    <div class="moz-text-plain" wrap="true" graphical-quote="true"
      style="font-family: -moz-fixed; font-size: 12px;" lang="x-unicode">
      <pre wrap="">Currently in SELinux and UserNamespace can not be enabled with Docker/runc at the same time.

Runc mounts tmpfs directories with --context="system_u:object_r:container_file_t:s0:c1,c2" type labels
but the following patch blocks the use of context mounts when using user namespace.

<a class="moz-txt-link-freetext" href="http://kernel.suse.com/cgit/kernel/commit/?id=aad82892af261b9903cc11c55be3ecf5f0b0b4f8">http://kernel.suse.com/cgit/kernel/commit/?id=aad82892af261b9903cc11c55be3ecf5f0b0b4f8</a>

User Namespace has to be established before tmpfs are mounted so we are unable to mount a
tmpfs with a context=flag and UserNamespace enabled.

Controlling the ability to change the label of a mounted file systemd should be a MAC decision not a DAC, 
or UserNamespace. Setting the SELinux labels on an object like a file system mount point
should be controlled by SELinux.  SELinux should check if the label of the process doing the
mount is able to relabel from the label of the mount point, and labelto the specified label.

SELinux does this for privileged processes (running with SYS_ADMIN) so use namespace should not be
any different.  Also the process doing the mount would be allowed by DAC to set the label of the tmpfs after
it is mounted (As long as SELinux allowed).

There is no security difference between:

mount -o tmpfs context="foobar" none /dev


And

mount -o tmpfs none /dev

chcon foobar -R /dev


The second would not be blocked by usernamespace.  

Bottom line this patch should be reverted so container runtimes like docker can use both User Namespace
and SELinux at the same time.

 
</pre>
      <pre wrap="">

</pre>
      <div class="add"><br>
      </div>
      <pre wrap="">

</pre>
    </div>
  </body>
</html>

--------------D76F28397F4225BFE518132E--
