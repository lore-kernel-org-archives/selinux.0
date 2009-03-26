Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2QFSElE031801
	for <selinux@tycho.nsa.gov>; Thu, 26 Mar 2009 11:28:14 -0400
Received: from mail-qy0-f108.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2QFSENc012467
	for <selinux@tycho.nsa.gov>; Thu, 26 Mar 2009 15:28:14 GMT
Received: by qyk6 with SMTP id 6so1052172qyk.32
        for <selinux@tycho.nsa.gov>; Thu, 26 Mar 2009 08:28:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cadfc0e40903260750x42c56e22u5c925d4dbbc1b132@mail.gmail.com>
References: <cadfc0e40903260750x42c56e22u5c925d4dbbc1b132@mail.gmail.com>
Date: Thu, 26 Mar 2009 15:28:12 +0000
Message-ID: <cadfc0e40903260828h3d41473raac79a65e709a47@mail.gmail.com>
Subject: Re: /usr/bin/firefox not mozilla_exec_t, why?
From: Xavier Toth <txtoth@gmail.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Mar 26, 2009 at 2:50 PM, Xavier Toth <txtoth@gmail.com> wrote:
> Why isn't firefox being labeled mozilla_exec_t? We're running FC10.
>
> Ted
>

Now I see /usr/lib64/firefox-3.0.6/firefox is labeled mozilla_exec_t.

ls -laZ /usr/lib64/firefox-3.0.6/firefox
-rwxr-xr-x  root root system_u:object_r:mozilla_exec_t:SystemLow
/usr/lib64/firefox-3.0.6/firefox


Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
