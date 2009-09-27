Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8RMjQRK030665
	for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 18:45:26 -0400
Received: from mail-yx0-f174.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8RMifGX004539
	for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 22:44:41 GMT
Received: by yxe4 with SMTP id 4so4759316yxe.32
        for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 15:45:25 -0700 (PDT)
Message-ID: <4ABFEB08.5080606@gmail.com>
Date: Sun, 27 Sep 2009 15:45:28 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: pam_namespace context inside of name.inst
References: <dd18b0c30909262312l1c5a82dfxf9270ecc33b9d64a@mail.gmail.com> <20090927131307.GA4502@notebook2.grift.internal> <4ABF8148.4010108@gmail.com> <20090927160540.GA7217@notebook3.grift.internal>
In-Reply-To: <20090927160540.GA7217@notebook3.grift.internal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Well this is confusing to me
the first initial start created
/home/name/name.inst

then if I move name.inst that directory
just for some reason isn't being recreated after login.
But if I change the location to:
/home/name.inst that directory can be
deleted, and a new one created upon every login.

As for the context in name.inst
for some reason one system created

name:object_r:user_home_dir_t_name
as the directory name, but
then other directories created are:
system_u:object_r:file_t_name
(which seems right, but am unsure)

I think if Ill leave namespace.conf to
/home/name.inst because everything runs as is.

Justin P. Mattock





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
