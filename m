Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBE3fUMA004389
	for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2005 22:41:31 -0500 (EST)
Received: from wproxy.gmail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBE3WnN7009266
	for <selinux@tycho.nsa.gov>; Wed, 14 Dec 2005 03:32:49 GMT
Received: by wproxy.gmail.com with SMTP id 69so284714wri
        for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2005 19:31:49 -0800 (PST)
Message-ID: <4c4ba1530512131931o16728314s205ed41f906a573f@mail.gmail.com>
Date: Tue, 13 Dec 2005 19:31:49 -0800
From: Tom London <selinux@gmail.com>
To: Robert L Cochran <cochranb@speakeasy.net>
Subject: Re: Adding two new booleans to httpd to tighten it's security.
Cc: Daniel J Walsh <dwalsh@redhat.com>, Joe Orton <jorton@redhat.com>,
   Mark J Cox <mjc@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <439F4A13.3020701@speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4399EFE6.5040206@redhat.com> <20051212110247.GA25100@redhat.com>
	 <439E23F3.7090709@speakeasy.net> <439E4AF6.40403@redhat.com>
	 <439F4A13.3020701@speakeasy.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here is the response from vmware:

VMware generates lots of code on the fly, so flipping PROT_EXEC with
PROT_WRITE would not reasonably work. Especially not in the
multithreaded environment where it would continuously cause IPIs to be
send between processors, slowing down everything. If SELinux default
policy authors decided that they cannot trust applications, then I'm
afraid that you'll have to create special policy for VMware.

libgdk-x11's library from vmware's directory will be used only if
libraries on your host are found to be inadequate. Try
'VMWARE_USE_SHIPPED_GTK=no vmware' and it should tell you which
libraries are missing on your box. After you'll install them then
libgdk-x11 from /usr/lib should be used.

-------------------------------------------------------------
I haven't gotten the library test working yet.....

tom
--
Tom London


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
