Subject: Re: TypeError: in method 'getpidcon', argument 1 of type 'pid_t'
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <cadfc0e40801070808w30f405c0t6cec02573413e7b4@mail.gmail.com>
References: <cadfc0e40801070808w30f405c0t6cec02573413e7b4@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 07 Jan 2008 15:08:57 -0500
Message-Id: <1199736537.2944.249.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-01-07 at 10:08 -0600, Xavier Toth wrote:
> import selinux
> import os
> 
> pid = os.getpid()
> print "Type of pid ", type(pid)
> (ret,con) = selinux.getpidcon(pid)
> type = con.split(":", 4)
> print type
> 
> Running this script results in:
> 
> Type of pid  <type 'int'>
> Traceback (most recent call last):
>   File "test.py", line 8, in <module>
>     (ret,con) = selinux.getpidcon(pid)
> TypeError: in method 'getpidcon', argument 1 of type 'pid_t'
> 
> How do I make a pid_t in python? Or is the swig broke?

Possibly we need a typemap for it in the python binding?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
