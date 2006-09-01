Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k81GUi3E014147
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 12:30:44 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k81GUOIk020927
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 16:30:24 GMT
Received: by wr-out-0506.google.com with SMTP id 68so388714wri
        for <selinux@tycho.nsa.gov>; Fri, 01 Sep 2006 09:30:43 -0700 (PDT)
Message-ID: <46ffa45f0609010930h403bf000k6cbf561c1334dfef@mail.gmail.com>
Date: Fri, 1 Sep 2006 11:30:43 -0500
From: "Aleks Kissinger" <aleks0@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Using scripting languages to "macro" policy
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been poking around with the idea of using Ruby and some
meta-programming to specify policy.  The complaint I've heard voiced
by a couple of people is that while many of the m4-based abstractions
present in refpolicy are pretty intuitive and useful, the limitation
of m4 as a language is that you cannot maintain relationships and
resolve conflicts automatically.  Therefore, in many cases you need to
result to naming conventions to do that work.

The idea I put forward here is to create a set of base objects in
Ruby, Python, or something of that ilk that can be extended and used
to define policy in an organized, error-checking, and namespaced
manner.  Heres a quick little example:

class LogDir < FileType
  pattern '/var/log/.*'
end

class SomeProgam < Application
  executable '/usr/bin/someprog'
  allow_role SysadminRole
  allow self, LogDir, File, File.perms(:r, :w)
end

This expands to all the relevant TE & FC statements.  'executable'
generates the someprogram_exec_t type and all needed type transitions
and allows, 'allow_role' looks up types associated with the role and
generates relevant allows and transitions.  The 'allow' statement
works pretty much as expected, except that the FLASK class File is an
actual Ruby class, with the ability to filter on permission
categories, etc.

This system isn't meant to replace all the work thats gone in to
existing policies, nor does it set out to be a policy language of its
own like existing high-level lanaguage work, but I think it would make
an interesting little project.  Ideas, comments, suggestions,
criticisms, etc. would be appreciated.


Aleks Kissinger

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
