Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9OIhpZE011483
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2007 14:43:51 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9OIho8j006478
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2007 18:43:51 GMT
Received: by nf-out-0910.google.com with SMTP id k4so313413nfd
        for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2007 11:43:50 -0700 (PDT)
Message-ID: <cadfc0e40710241143n2b26c909m52e3ca1756ffde1b@mail.gmail.com>
Date: Wed, 24 Oct 2007 13:43:48 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: Re: HOME_DIR in .fc works?
In-Reply-To: <471F6C7D.7090807@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <471F6C7D.7090807@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm getting the impression that genhomedircon is involved with the
solution to my problem. Maybe you can't use HOME_DIR in a policy
module? If I can then maybe I need to run genhomedircon to get
homedir_templates processed into file_contexts.homedirs?

On 10/24/07, Ted X Toth <txtoth@gmail.com> wrote:
> I put entries into an .fc file to not relabel polyinstantied instance
> directories but they get relabeled, am I doing it right:
> HOME_DIR/\.mlrc\.inst/.*   <<none>>
>
> I don't see anything about this directory when I do:
> /usr/sbin/semanage fcontext -l | grep mlrc
>
> I do see them in /etc/selinux/mls/contexts/files/homedir_templates.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
