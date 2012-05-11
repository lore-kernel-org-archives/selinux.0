Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4BESdF8012557
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2012 10:28:39 -0400
Message-ID: <4FAD2219.6090603@schaufler-ca.com>
Date: Fri, 11 May 2012 07:28:41 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: zyxel <zyx1984@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: labeled NFS
References: <CAHx7xgW22yYYEgDR=tqomoS3AEOOwOc351d0+1WZNnbsv1rYVA@mail.gmail.com>
In-Reply-To: <CAHx7xgW22yYYEgDR=tqomoS3AEOOwOc351d0+1WZNnbsv1rYVA@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------020301070802080604010702"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020301070802080604010702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 5/11/2012 4:05 AM, zyxel wrote:
> Hello.
>
> I have some questions about labeled NFS.
> We have client and server systems running RHEL 6.1
> Kernels for both client and server were downloaded from
> git://git.selinuxproject.org/~dpquigl/lnfs
> <http://git.selinuxproject.org/%7Edpquigl/lnfs>
> Kernel version is 2.6.32. and they are already patched to support
> labeled NFS.
> Server is configured to export NFS share. Nfs-utils on server are
> patched for labeled nfs too.
>
> Here is listing for server exports file:
> /export
> *(rw,fsid=0,sec=unix,insecure,no_subtree_check,sync,security_label)
>
> Client and server have the same MLS policy.
>
> If I mount NFS share with command
>  #mount -t nfs4 server:/ /mnt/nfsv4
> everything works good, but when i try to mount the same share to
> another directory
>  #mount -t nfs4 server:/ /mnt/nfsv4_2
> it fails with:
>
> Message from syslogd@localhost at May 11 13:07:17 ...
> kernel:Oops: 0000 [#1] SMP
>  
> Message from syslogd@localhost at May 11 13:07:17 ...
> kernel:last sysfs file: /sys/devices/virtual/block/dm-0/dev
>  
> Message from syslogd@localhost at May 11 13:07:17 ...
> kernel:Stack:

An "Oops" indicates that a component of the kernel had a fatal
error, but that it only affected the current process or device
and the kernel was able to continue otherwise.

Use dmesg to see the kernel log. Any number of issues, from
misconfiguration to just plain bad code could have caused your
problem. There is not enough information in your email to do
much diagnosis.


>
> Why does it happens? Where I can get more information about that.
>
> The second question is that maybe I don't need labeled NFS.
> My task is to transfer security levels between client and server over NFS
> so that client with security level s0, for example, couldn't get
> access to file with level s1 on NFS share.
> I don't know if it may be done with netlabel or something.
> Could you help me a bit.
>
> Andrei


--------------020301070802080604010702
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    On 5/11/2012 4:05 AM, zyxel wrote:
    <blockquote
cite="mid:CAHx7xgW22yYYEgDR=tqomoS3AEOOwOc351d0+1WZNnbsv1rYVA@mail.gmail.com"
      type="cite">Hello. <br>
      <br>
      I have some questions about labeled NFS.<br>
      We have client and server systems running RHEL 6.1<br>
      Kernels for both client and server were downloaded from git://<a
        moz-do-not-send="true"
        href="http://git.selinuxproject.org/%7Edpquigl/lnfs">git.selinuxproject.org/~dpquigl/lnfs</a><br>
      Kernel version is 2.6.32. and they are already patched to support
      labeled NFS.<br>
      Server is configured to export NFS share. Nfs-utils on server are
      patched for labeled nfs too.<br>
      <br>
      Here is listing for server exports file:<br>
      /export
      *(rw,fsid=0,sec=unix,insecure,no_subtree_check,sync,security_label)<br>
      <br>
      Client and server have the same MLS policy.<br>
      <br>
      If I mount NFS share with command<br>
      &nbsp;#mount -t nfs4 server:/ /mnt/nfsv4<br>
      everything works good, but when i try to mount the same share to
      another directory<br>
      &nbsp;#mount -t nfs4 server:/ /mnt/nfsv4_2<br>
      it fails with:<br>
      <br>
      Message from syslogd@localhost at May 11 13:07:17 ...<br>
      kernel:Oops: 0000 [#1] SMP <br>
      &nbsp;<br>
      Message from syslogd@localhost at May 11 13:07:17 ...<br>
      kernel:last sysfs file: /sys/devices/virtual/block/dm-0/dev<br>
      &nbsp; <br>
      Message from syslogd@localhost at May 11 13:07:17 ...<br>
      kernel:Stack:<br>
    </blockquote>
    <tt><br>
      An "Oops" indicates that a component of the kernel had a fatal<br>
      error, but that it only affected the current process or device<br>
      and the kernel was able to continue otherwise.<br>
      <br>
      Use dmesg to see the kernel log. Any number of issues, from<br>
      misconfiguration to just plain bad code could have caused your<br>
      problem. There is not enough information in your email to do<br>
      much diagnosis.<br>
      <br>
      <br>
    </tt>
    <blockquote
cite="mid:CAHx7xgW22yYYEgDR=tqomoS3AEOOwOc351d0+1WZNnbsv1rYVA@mail.gmail.com"
      type="cite"><br>
      Why does it happens? Where I can get more information about that.<br>
      <br>
      The second question is that maybe I don't need labeled NFS.<br>
      My task is to transfer security levels between client and server
      over NFS<br>
      so that client with security level s0, for example, couldn't get
      access to file with level s1 on NFS share.<br>
      I don't know if it may be done with netlabel or something.<br>
      Could you help me a bit.<br>
      <br>
      Andrei<br>
    </blockquote>
    <br>
  </body>
</html>

--------------020301070802080604010702--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
