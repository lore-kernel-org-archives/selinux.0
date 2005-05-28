Subject: Re: file_type_auto_trans is not sufficient
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: SELinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
In-Reply-To: <1117249760.19257.18.camel@localhost.localdomain>
References: <1117249760.19257.18.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 27 May 2005 23:47:24 -0400
Message-Id: <1117252045.19698.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> To address those problems, I think I need to add selinux support
> to a number of applications, and perform the transition in the code. 
> I'm not sure what's the best way to do that. Does adding 
> the following functions to libselinux (or elsewhere) make sense?
> 
> int mkdir_restorecon(const char *pathname, mode_t mode);
> int creat_restorecon(const char *pathname, mode_t mode);
> int mknod_restorecon(const char *pathname, mode_t mode, dev_t dev);
> 
> Those would perform getfscreate/matchpathcon/setfscreate cycle,
> and would ignore errors in permissive mode.

Actually, what exactly happens when you call setfscreate() and
at the same time you have a matching file_type_auto_trans rule?

In my case for /tmp/gconfd-$USER vs /tmp/orbit-$USER,
(process is gconf, executing libORBit code that creates orbit-$USER)
the orbit getfscreate() rule took precedence over
the matching file_type_auto_trans in gconfd... does
this always happen, or do I have to make a choice 
between either file_type_auto_trans, or setfscreate() ?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
