Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HJN2HN024723
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 15:23:02 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3HJN1C3005721
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 19:23:01 GMT
Received: by wx-out-0506.google.com with SMTP id s17so2230462wxc
        for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 12:23:01 -0700 (PDT)
Message-ID: <cadfc0e40704171223r5b566441p276426561ec21290@mail.gmail.com>
Date: Tue, 17 Apr 2007 14:23:01 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Michael C Thompson" <thompsmc@us.ibm.com>
Subject: Re: directory polyinstantiation failure
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46251650.7000509@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <cadfc0e40704171107l770c48cak16f504b6b0a0dcc0@mail.gmail.com>
	 <46251650.7000509@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If you try and use $HOME in the directory name for instance
$HOME/.mozilla the $HOME is not expanded. I'll submit a patch.

On 4/17/07, Michael C Thompson <thompsmc@us.ibm.com> wrote:
> Xavier Toth wrote:
> > pam_namespace complains that "Pathnames must start with '/'" when I
> > try and polyinstantiate "$HOME/$USER/.mozilla". Is there a particular
> > reason that I shouldn't be able to polyinstantiate a dot directory or
> > is this a bug?
>
> AFAIK, there is no reason that polyinstantiating shouldn't work for dot
> directories.
>
> Mike
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
