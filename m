Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBDEtTMA026463
	for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2005 09:55:29 -0500 (EST)
Received: from wproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBDEk6nv026588
	for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2005 14:46:06 GMT
Received: by wproxy.gmail.com with SMTP id i3so137226wra
        for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2005 06:46:55 -0800 (PST)
Message-ID: <4c4ba1530512130646i3a9b0dd7v5935599dbdd43111@mail.gmail.com>
Date: Tue, 13 Dec 2005 06:46:55 -0800
From: Tom London <selinux@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Adding two new booleans to httpd to tighten it's security.
Cc: Robert L Cochran <cochranb@speakeasy.net>, Joe Orton <jorton@redhat.com>,
   Mark J Cox <mjc@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <439E4AF6.40403@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4399EFE6.5040206@redhat.com> <20051212110247.GA25100@redhat.com>
	 <439E23F3.7090709@speakeasy.net> <439E4AF6.40403@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

VMWare has problems with execmem as previously reported:
type=AVC msg=audit(1134338328.000:56): avc: denied { execmem } for
pid=5215 comm="ld-linux.so.2"
scontext=root:system_r:unconfined_t:s0-s0:c0.c255
tcontext=root:system_r:unconfined_t:s0-s0:c0.c255 tclass=process
type=SYSCALL msg=audit(1134338328.000:56): arch=40000003 syscall=125
success=no exit=-13 a0=bfc78000 a1=1000 a2=1000007 a3=98b6e0 items=0
pid=5215 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0
sgid=0 fsgid=0 comm="ld-linux.so.2" exe="/lib/ld-2.3.90.so"

and
time->Sun Dec 11 13:05:51 2005
type=AVC_PATH msg=audit(1134335151.660:39):
path="/usr/lib/vmware/lib/libgdk-x11-2.0.so.0/libgdk-x11-2.0.so.0"
type=SYSCALL msg=audit(1134335151.660:39): arch=40000003 syscall=125 per=400000
success=no exit=-13 a0=b7c99000 a1=7b000 a2=5 a3=bfc5a1e0 items=0
pid=4418 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0
sgid=0 fsgid=0 comm="vmware" exe="/usr/lib/vmware/bin/vmware"
type=AVC msg=audit(1134335151.660:39): avc:  denied  { execmod } for
pid=4418 comm="vmware" name="libgdk-x11-2.0.so.0" dev=dm-0 ino=343461
scontext=root:system_r:unconfined_t:s0-s0:c0.c255
tcontext=system_u:object_r:lib_t:s0 tclass=file


Reply from VMware on my complaint about execmem issues:


As your system refuses to execute even /lib/ld-2.3.90.so (if I
understand it correctly), you seems to have some problem...

None of VMware parts (at least I believe) require executable stack or
heap. Applications which need it explicitly call mmap with PROT_EXEC.
Another question is whether libraries we ship are correctly tagged to
signal this - but it should not be problem as you can install all
libraries VMware needs from your distribution, VMware just ships
libraries it was linked with as it is simpler for us to ship you
libgdk-whatever than (finding and) explaining that you must to install
some-strange-package-with-no-gdk-in-filename to get VMware to work. On
"correct" system with all libraries you should be able to run vmware
directly by /usr/lib/vmware/bin/vmware. Apparently your system is
missing at least openssl097...
--------------------------------------------


My understanding from this thread on how execmem works is that calling
mmap with PROT_EXEC can (will?) still trigger execmem.  Right?

Here is the link to the discussion thread: Please hop on to help/clarify!
http://www.vmware.com/community/thread.jspa?messageID=320149&#320149

thanks,
   tom
--
Tom London


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
