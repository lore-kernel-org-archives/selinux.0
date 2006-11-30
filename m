Subject: Re: how to use a single *.fc to set files
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Jian Liu <gjk.liu@gmail.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <8c2dc7030611300151s6dc2f353x651a5d25bb476a8@mail.gmail.com>
References: <8c2dc7030611300151s6dc2f353x651a5d25bb476a8@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 30 Nov 2006 08:15:41 -0500
Message-Id: <1164892541.7459.10.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-30 at 17:51 +0800, Jian Liu wrote:
> As the maypp example at
> http://oss.tresys.com/projects/refpolicy/wiki/GettingStarted
> 
> 1) create a module named myapp by writing the three files: myapp.te,
> myapp.if and myapp.fc
> 2) build the module using policy headers
>     $ make -f /usr/share/selinux/targeted/include/Makefile
> 3) insert myapp.pp
>     # semodule -i myapp.pp
> 
> Assuming there
> is "/usr/bin/myapp" in my system, then  "ls -Z /usr/bin/myapp", but 
> the security context of "/usr/bin/myapp" is not changed to
> "system_u:object_r:myapp_exec_t"
> as expected.
> 
>    How to use the mypp.fc to set files?

Changing the file contexts will not automatically change the context of
files.  You have to explicitly relabel the file, e.g.,
`restorecon /usr/bin/myapp`.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
