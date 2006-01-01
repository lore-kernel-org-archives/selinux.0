Message-ID: <43B82F43.5000900@cornell.edu>
Date: Sun, 01 Jan 2006 14:36:35 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Erich Schubert <erich@debian.org>
CC: SELinux@tycho.nsa.gov
Subject: Re: more genhomedircon badness...
References: <1136133436.27906.56.camel@wintermute.xmldesign.de> <1136146788.27906.65.camel@wintermute.xmldesign.de>
In-Reply-To: <1136146788.27906.65.camel@wintermute.xmldesign.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Erich Schubert wrote:
> I've now created /etc/selinux/modules/active/modules
> and /etc/selinux/modules/active/seusers...
>
> genhomedircon:  Warning!  No support yet for expanding ROLE macros in
> the /etc/selinux/./contexts/files/homedir_template file when using
> libsemanage.
> genhomedircon:  You must manually update file_contexts.homedirs for any
> non-user_r users (including root).
> zsh: 19705 segmentation fault  genhomedircon
>
> Ouch, a segfault!
>   
Trace?

Again, normally this folder (and file) are installed by a policy package 
which is "managed",
and makes use of the seusers file feature. You shouldn't have to do it 
manually.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
