Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1NJCOjp006095
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2009 14:12:24 -0500
Received: from yw-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1NJ8ue3013087
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2009 19:08:56 GMT
Received: by yw-out-1718.google.com with SMTP id 5so874139ywr.84
        for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2009 11:12:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <A4219691-58AB-4D38-82C9-F4C593018ED9@nall.com>
References: <cadfc0e40902230944q217ed46ar618dc06ccfa2e9fa@mail.gmail.com>
	 <A4219691-58AB-4D38-82C9-F4C593018ED9@nall.com>
Date: Mon, 23 Feb 2009 13:12:21 -0600
Message-ID: <cadfc0e40902231112n21f62bafk426737d8a399a75e@mail.gmail.com>
Subject: Re: semanage fcontext --list doesn't list contexts which include
	HOME_DIR
From: Xavier Toth <txtoth@gmail.com>
To: Joe Nall <joe@nall.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Feb 23, 2009 at 12:50 PM, Joe Nall <joe@nall.com> wrote:
>
> On Feb 23, 2009, at 11:44 AM, Xavier Toth wrote:
>
>> Is there a different option or command I can use to see these?
>
> Is
> cat /etc/selinux/mls/contexts/files/file_contexts.homedirs
> complete?
>
> joe
>
>

I knew about /etc/selinux/mls/contexts/files/file_contexts.homedirs I
was really just trying to point out that there appears to be a
deficiency in `semanage fcontext --list`.

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
