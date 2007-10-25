Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9PF6lE4028644
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2007 11:06:47 -0400
Received: from nf-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9PF6hw3014717
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2007 15:06:44 GMT
Received: by nf-out-0910.google.com with SMTP id k4so603386nfd
        for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2007 08:06:38 -0700 (PDT)
Message-ID: <cadfc0e40710250806o514cab07w264f641e53d2b102@mail.gmail.com>
Date: Thu, 25 Oct 2007 15:06:37 +0000
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: Re: HOME_DIR in .fc works?
Cc: "Daniel J Walsh" <dwalsh@redhat.com>
In-Reply-To: <cadfc0e40710241143n2b26c909m52e3ca1756ffde1b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <471F6C7D.7090807@gmail.com>
	 <cadfc0e40710241143n2b26c909m52e3ca1756ffde1b@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On RHEL5 genhomedircon is not processing my fc entries because they
are specifying "<<none>>" for the context. In the getHomeDirContext
function there is a call to security_check_context which fails for
"<<none>>" so the substituted string is not appended to the output.
Maybe this check should be something like:
if selinux.security_check_context(scon) == 0 or scon == "<<none>>":


On 10/24/07, Xavier Toth <txtoth@gmail.com> wrote:
> I'm getting the impression that genhomedircon is involved with the
> solution to my problem. Maybe you can't use HOME_DIR in a policy
> module? If I can then maybe I need to run genhomedircon to get
> homedir_templates processed into file_contexts.homedirs?
>
> On 10/24/07, Ted X Toth <txtoth@gmail.com> wrote:
> > I put entries into an .fc file to not relabel polyinstantied instance
> > directories but they get relabeled, am I doing it right:
> > HOME_DIR/\.mlrc\.inst/.*   <<none>>
> >
> > I don't see anything about this directory when I do:
> > /usr/sbin/semanage fcontext -l | grep mlrc
> >
> > I do see them in /etc/selinux/mls/contexts/files/homedir_templates.
> >
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
