Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1N0XG40022104
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 19:33:16 -0500
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1N0YYWA021342
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 00:34:34 GMT
Received: by ug-out-1314.google.com with SMTP id y2so347333uge
        for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 16:34:31 -0800 (PST)
Message-ID: <f888952b0702221634h3a673ee5v1cc92722f60ced56@mail.gmail.com>
Date: Thu, 22 Feb 2007 19:34:31 -0500
From: "Dave Quigley" <dquigley+selinux@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Several SELinux questions
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
    My first question is if it is possible to query what the relabel
context for a path should be using one of the selinux libraries and a
policy module? I am working on a high level language for selinux that
uses the reference policy as a base to work on top of. Because of this
I need to make use of the types that already exist. For instance I
don't want to rely on the current state of the system to determine
that the type for /tmp should be tmp_t. An example I have for this is
the ability for a policy writer to say that he wants a set of isolated
tmp files. This means it can't use the default type tmp_t however by
placing the constraint on the developer that he will be placing his
files in a directory labeled with tmp_t I can generate the policy code
to do several things. First we can generate a type without the policy
developer having to be too conscious of it. Second we can generate the
transition rules that are needed to make sure the files created in a
tmp_t directory are labeled properly. Finally the developer specifies
what kinds of objects he will want to act upon and in what manner and
we generate the appropriate AV rules.
    My second question is how do we handle things such as shell
scripts and interpreted languages inside policy? I remember hearing
somewhere that we just run programs such as the java and python
interpreters as unconfined. I am not really sure if it is possible to
have java programs and other interpreted programs constricted under
SELinux since we do need to grant the interpreter privileges to do
quite a few things without making the interpreters aware of selinux
security contexts in addition to normal security controls.

Dave

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
